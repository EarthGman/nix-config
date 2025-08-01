{
  disko.devices = {
    disk = {
      games = {
        device = "/dev/nvme1n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            "1" = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home/pumpkinking/games";
              };
            };
          };
        };
      };
    };
  };
}
