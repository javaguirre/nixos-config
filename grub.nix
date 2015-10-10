{ config, pkgs, ... }:

{
  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    extraEntries = ''
      menuentry "Elementary OS" {
        set root=(hd0,1)
        linux /boot/vmlinuz-3.13.0-65-generic root=UUID=1de84a9e-55f2-4d96-983a-a135d44f82bd ro quiet
        initrd /boot/initrd.img-3.13.0-65-generic
      }
    '';
  };
}
