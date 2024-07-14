{
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/86e42e50-1853-440d-8d32-d3f3b69eaf50";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/8478-AC6B";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/5b3c1cad-41da-4671-9eb1-ab9ef3de22ea";
      fsType = "ext4";
    };
}
