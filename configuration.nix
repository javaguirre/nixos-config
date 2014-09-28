# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts

  # nix.gc.automatic = true;
  # nix.gc.dates = "18:00";


  # Select internationalisation properties.
  i18n = {
    consoleFont = "";
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

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;
  # services.xserver.windowManager.default.enable = true;
  services.xserver.windowManager.awesome.enable = true;

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
