{
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/a04aa82c-42be-48eb-9b61-e4d0cbfc1a0d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/8310-1ACC";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/8367e392-08ff-41ea-b9cc-a96d4775d434";
      fsType = "ext4";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/89331bb5-0f09-4578-b5e5-16ab30fac135"; }];
}
