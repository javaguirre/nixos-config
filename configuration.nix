# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Init file to make dwm available in Slim
      ./dwm.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.extraEntries =
    ''
      menuentry "ArchLinux" {
        set root=(hd0,2)
        linux /boot/vmlinuz-linux root=UUID=c3797685-5561-4050-9302-1495b1703557 ro quiet
        initrd /boot/initramfs-linux.img
      }
    '';
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "calypso";
  networking.wireless.enable = true;
  networking.extraHosts =
    ''
      127.0.0.1	localhost.localdomain localhost local.selltag.com local.api.selltag.com
      ::1		localhost.localdomain	localhost calypso
      192.168.1.37    board.taikoa.net
    '';

  # networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts

  security.sudo.enable = true;
  security.sudo.configFile=
   ''
     root	ALL=(ALL) SETENV: ALL
     javaguirre	ALL=(ALL) SETENV: ALL
   '';

  # nix.gc.automatic = true;
  # nix.gc.dates = "18:00";


  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    emacs
    tmux
    vim
    git
    dwm
    st
    mutt
    zsh
    firefox
  ];

  # List services that you want to enable:

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # window manager
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.awesome.enable = true;

  # hardware.pulseaudio.enable = true;
  users.defaultUserShell = "/var/run/current-system/sw/bin/zsh";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.guest = {
    name = "javaguirre";
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/javaguirre";
    shell = "/run/current-system/sw/bin/zsh";
  };
}
