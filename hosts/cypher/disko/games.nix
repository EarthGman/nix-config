{
  disko.devices.disk.nvme1n1 = {
    device = "/dev/nvme1n1";
    type = "disk";
    content = {
      type = "gpt";
      partitions.games = {
        size = "100%";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/home/g/games";
        };
      };
    };
  };
}
