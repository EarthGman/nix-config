#!/usr/bin/env bash
function y_or_n {
	while true; do
		read -p "$* [y/n]: " yn
		case $yn in
		[Yy]*) return 0 ;;
		[Nn]*)
			return 1
			;;
		esac
	done
}

function install {
	if [[ $(cat /proc/meminfo | grep MemAvailable | cut -d ":" -f2 | tr -d " kB") -lt 4000000 && ! -f /mnt/tmp/swapfile ]]; then
		printf "Detected less than 4GB of free ram\nNixOS requires at least 4GB of free ram to install smoothly.\nCreating a 4GB swapfile at /mnt/tmp/swapfile."
		mkdir -p /mnt/tmp
		dd if=/dev/zero of=/mnt/tmp/swapfile bs=1024 count=4194304
		mkswap /mnt/tmp/swapfile
		chmod 600 /mnt/tmp/swapfile
		swapon /mnt/tmp/swapfile
	fi

	if [[ $REPO_DIR != "" ]]; then
		nixos-install --flake $REPO_DIR'#'$HOST
	else
		nixos-install --flake /mnt/etc/nixos'#'$HOSTNAME
	fi
}

function pull_repo {
	read -p "Enter the url for your config repository: " REPO_URL
	$(git ls-remote $REPO_URL)
	while [[ $? == 128 ]]; do
		read -p "Try again: " REPO_URL
		$(git ls-remote $REPO_URL)
	done

	REPO_DIR=/tmp/nix-config

	if [[ -d $REPO_DIR ]]; then
		echo "removing existing repository found at $REPO_DIR"
		rm -rf $REPO_DIR
	fi
	echo "$REPO_URL $REPO_DIR"
	git clone $REPO_URL --depth 1 $REPO_DIR
}

function create_config {
	format_disks

	read -p "Set your system hostname: " HOSTNAME
	HOST_CONFIG=/mnt/etc/nixos/hosts/$HOSTNAME

	y_or_n "Is this machine going to be a server?" && SERVER=true || SERVER=false

	if [[ $(lscpu | grep -i "intel") ]]; then
		CPU="intel"
	elif [[ $(lscpu | grep -i "amd") ]]; then
		CPU="amd"
	else
		CPU=""
	fi

	if [[ $(lspci -nnk | grep VGA | grep -i intel) ]]; then
		GPU="intel"
	elif [[ $(lspci -nnk | grep VGA | grep -i amd) ]]; then
		GPU="amd"
	elif [[ $(lspci -nnk | grep VGA | grep -i nvidia) ]]; then
		GPU="nvidia"
	else
		GPU=""
	fi

	if [[ -d /sys/firmware/efi ]]; then
		BIOS="UEFI"
	else
		BIOS="legacy"
	fi

	ARCH=$(lscpu | grep Arch | tr -d " " | cut -d ":" -f2)
	STATEVERSION=$(nixos-version | cut -d "." -f1-2)

	y_or_n "The default locale is en_US. Would you like to set a different localization configuration?" &&
		LOCALE="$(cat /etc/locales.txt | fzf --border --border-label-pos 1:bottom --border-label="Select the default locale")"".UTF-8" ||
		LOCALE="en_US.UTF-8"
	KBD_LAYOUT=$(localectl list-keymaps | fzf --border --border-label-pos 1:bottom --border-label="Select a keyboard layout")
	TIMEZONE=$(timedatectl list-timezones | fzf --border --border-label-pos 1:bottom --border-label="Select your time zone.")

	DESKTOPS=("gnome" "sway" "hyprland" "no-desktop")
	DESKTOP=$(printf "%s\n" "${DESKTOPS[@]}" | fzf --border --border-label-pos 1:bottom --border-label "Choose a desktop environment.")

	echo "Do you wish to enable imperative user management for this system?"
	echo "When enabled, users can be imperatively modified using traditional commands (useradd, usermod, etc) independently of nix"
	y_or_n "Choosing 'N' or 'n' will require the creation of a non-root user for reasons that will be explained later." && IMPERATIVE_USERS=true || IMPERATIVE_USERS=false

	echo "
	  NixOS will install with the following configuration.
	 	CPU - $CPU
	 	GPU - $GPU
	 	BIOS - $BIOS
	 	Arch - $ARCH 
		NixOS - $STATEVERSION
		Locale - $LOCALE
		keyboard - $KBD_LAYOUT
		timezone - $TIMEZONE
		Desktop - $DESKTOP 
	"

	if [[ ! -d /mnt/etc/nixos ]]; then
		mkdir -p $HOST_CONFIG
	fi

	echo " {
		description = \"my NixOS configurations\";

		inputs = {
			nixpkgs.url = \"github:NixOS/nixpkgs/nixpkgs-unstable\";

			gman = {
				url = \"github:EarthGman/nix-config\";
				inputs.nixpkgs.follows = \"nixpkgs\";
			};
		};

		outputs = { gman, ... }@inputs:
		let
			lib = gman.lib;
		in
		{
			nixosConfigurations = import ./hosts { inherit lib; };
		};
	}
	" >/mnt/etc/nixos/flake.nix

	echo "Warning: hashed passwords are stored declaratively in the world-readable /nix/store."
	echo "After install, it is advised to remove the hash from the config and manually set the user password."
	echo "Alternatively, you can make use of sops-nix to securely encrypt the hashes in a sops file."

	if [[ $IMPERATIVE_USERS == true ]]; then
		y_or_n "Add a non-root user to the system?"
	else
		yn="y"
		echo "Detected declarative user management. This requires the creation of a non-root user."
		echo "As explained above, storing the password for root in the nix store is not a good idea."
		echo "Without a valid password for an account, NixOS will fail to install."
		echo "Add a non-root user to the system."
	fi

	USERS=()
	while [[ $yn == [Yy]* ]]; do
		read -p "Username: " USERNAME
		read -p "Password: " PASSWORD
		read -p "Retype password: " PASSWORD2
		while [[ $PASSWORD != $PASSWORD2 ]]; do
			read -p "Passwords do not match. Try again: " PASSWORD2
		done
		y_or_n "Should this user have access to sudo?" && SUDO=true || SUDO=false

		USER_DIR=$HOST_CONFIG/users/$USERNAME
		mkdir -p $USER_DIR

		echo " {
      users.users.$USERNAME = {
				hashedPassword = \"$(echo $PASSWORD | mkpasswd -s)\";
        isNormalUser = true;
		" >$USER_DIR/default.nix
		if [[ $SUDO == true ]]; then
			echo "extraGroups = [ \"wheel\"];" >>$USER_DIR/default.nix
		fi
		echo "};
    }
		" >>$USER_DIR/default.nix

		if [[ ! -d /mnt/etc/nixos/home/$USERNAME ]]; then
			mkdir -p /mnt/etc/nixos/home/$USERNAME
		fi

		if [[ ! -f /mnt/etc/nixos/home/$USERNAME/default.nix ]]; then
			echo "{ hostname, ... }:
			{
				imports = [ ../../hosts/\${hostname}/users/$USERNAME/home-manager.nix ];
			}
	  " >/mnt/etc/nixos/home/$USERNAME/default.nix
		fi

		echo "{ }" >$USER_DIR/home-manager.nix

		USERS+=$(echo \"$USERNAME\")

		y_or_n "Add another non-root user to the system?"

	done

	echo "{ pkgs, lib, config, ... }:
		{
			# kernel and fstab configuration
			imports = [ ./hardware-configuration.nix ];

			time.timeZone = \"$TIMEZONE\";

			i18n.defaultLocale = \"$LOCALE\";

			services.xserver.xkb.layout = \"$KBD_LAYOUT\";
			
			users.mutableUsers = $IMPERATIVE_USERS;
			
			# import configuration files that match a particular username from this directory
			home-manager.profilesDir = ../../home;
		}
	" >$HOST_CONFIG/default.nix

	if [[ $DESKTOP == "no-desktop" ]]; then
		DESKTOP=""
	fi

	echo " { lib, ... }:
	{
		$HOSTNAME = lib.mkHost {
			hostname = \"$HOSTNAME\";
			stateVersion = \"$STATEVERSION\";
			system = \"$ARCH-linux\";
			server = $SERVER;
			cpu = \"$CPU\";
			gpu = \"$GPU\";
			desktop = \"$DESKTOP\";
			configDir = ./$HOSTNAME;
			users = [ $(echo ${USERS[*]}) ];
		};
	}
  " >/mnt/etc/nixos/hosts/default.nix

	nixos-generate-config --root /mnt >/dev/null
	rm /mnt/etc/nixos/configuration.nix
	mv /mnt/etc/nixos/hardware-configuration.nix $HOST_CONFIG

	for i in $(find /mnt/etc/nixos -type f -not -path '*/.*'); do
		if [[ $i == *.nix ]]; then
			nixfmt $i
		fi
	done
}

function disko {
	pushd $REPO_DIR >/dev/null
	DISKO_CONFIG=$(fzf --border --border-label-pos 1:bottom --border-label="Choose a disko.nix file")

	while [[ ! $DISKO_CONFIG != "*disko.nix" ]]; do
		DISKO_CONFIG=$(fzf --border --border-label-pos 1:bottom --border-label="File must be named disko.nix. Try again")
	done
	printf "\nThese are the drives in your current environment\n"
	lsblk

	printf "\nConfiguration file in use: %s\n" $DISKO_CONFIG

	printf "This configuration file will affect the following drives\n\n"
	cat $DISKO_CONFIG | grep -i "/dev"

	y_or_n "All data on the drives listed will be erased. Do you wish to continue?" || exit 0

	disko --mode zap_create_mount $DISKO_CONFIG

	popd >/dev/null
}

function format_disks {
	echo "You will need to choose and format a disk to install NixOS"
	if [[ $REPO_DIR != "" ]]; then
		y_or_n "Use a disko file from your repo?"

		if [[ $yn == [Yy]* ]]; then
			disko
			return 0
		fi
	fi

	if [[ $(ls /mnt) ]]; then
		y_or_n "/mnt contains files, is your disk mounted?" && return 0 || echo "empty the /mnt directory and run the installer again"
		exit 1
	fi

	echo "By default, the installer will create a boot with FAT32 and root partition with ext4, which is sufficient for daily use such as gaming or productivity work."
	echo "More complex setups such as RAID, encrypted drives, or an existing configuration without using disko require manual disk setup."
	echo "In this case, you will have to format and mount the disks yourself or use a disko file then run the installer when you are finished."
	y_or_n "Would you prefer to do disk setup manually?" && exit 0

	DISKS=$(lsblk -dp | grep -v /dev/loop)
	SELECTED_DISK=$(printf "%s\n" "${DISKS[@]}" | fzf --border --border-label-pos 1:bottom --border-label="Select a disk to install NixOS")

	if [[ $SELECTED_DISK == "" ]]; then
		echo "aborted"
		exit 1
	fi

	SELECTED_DISK=$(echo $SELECTED_DISK | cut -d " " -f1)
	y_or_n "WARNING: All data on $SELECTED_DISK will be destroyed. Are you sure you want to proceed?" || exit 1

	wipefs -af $SELECTED_DISK
	dd if=/dev/zero of=$SELECTED_DISK bs=1M count=1

	parted -a optimal -s $SELECTED_DISK mklabel gpt mkpart "EFI" 0% 512MiB && parted -s $SELECTED_DISK set 1 esp on
	parted -s $SELECTED_DISK mkpart "root" 512MiB 100%

	mkfs.fat -F 32 "$SELECTED_DISK""1"
	mkfs.ext4 "$SELECTED_DISK""2"

	mount "$SELECTED_DISK""2" /mnt
	mkdir -p /mnt/boot
	mount "$SELECTED_DISK""1" /mnt/boot
}

function main {
	if [[ ! $(whoami) == "root" ]]; then
		echo "You must be root."
		exit 1
	fi

	while [[ ! $(curl -s ifconfig.me) ]]; do
		y_or_n "No internet connection detected. Connect Now?" && nmtui || exit 0
	done

	y_or_n "Are you installing an existing configuration?"

	if [[ $yn == [Yy]* ]]; then
		pull_repo

		CONFIGURATIONS=($(nix eval $REPO_DIR'#'nixosConfigurations --apply builtins.attrNames | sed 's/[][]//g' | tr -d '"'))
		HOST=$(printf "%s\n" "${CONFIGURATIONS[@]}" | fzf --border --border-label-pos 1:bottom --border-label="Found the following configurations. Which one would you like to install?")

		if [[ $HOST == "" ]]; then
			echo "No host selected."
			exit 1
		fi

		printf "\nIf performing a fresh install you will need to proceed to disk partitioning and formatting\n"
		echo "If performing a recovery install due to a non-booting system, skip partiioning"
		y_or_n "Format Disks?" && format_disks
		install

		echo "checking configuration"
		if [[ $(nix eval $REPO_DIR'#'nixosConfigurations.$HOST.config.sops.secrets) != "{ }" ]]; then
			SOPS_KEYFILE=$(nix eval $REPO_DIR'#'nixosConfigurations.$HOST.config.sops.age.keyFile | tr -d '"')
			echo "Detected sops secrets from this configuration."
			printf "You will need to imperatively place your private key file at /mnt%s before you continue\n" $SOPS_KEYFILE
			printf "Press any key to continue..."
			read -n 1 key

			while [[ ! -f /mnt$SOPS_KEYFILE ]]; do
				printf "Keyfile not found.\nEnsure the file is present in /mnt%s.\n" $SOPS_KEYFILE
				printf "Press any key to continue..."
				read -n 1 key
			done
		fi

		exit 0
	fi

	create_config
	install
}

main
