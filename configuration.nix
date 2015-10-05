# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # virtualisation.virtualbox.guest.enable = true;
  # boot.initrd.checkJournalingFS = false;

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = false;
    version = 2;
    device = "/dev/sda";
  };

  networking = {
    hostName = "calypso";
    networkmanager.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ansible
    emacs24Packages.cask
    chromium
    ctags
    emacs
    firefox
    gcc
    git
    gparted
    htop
    "python2.7-glances-2.4.2"
    stow
    tmux
    unzip
    vagrant
    vim
    wget
    zsh
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 22 ];
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e,ctrl:nocaps";

    synaptics.enable = true;
    synaptics.twoFingerScroll = true;

    desktopManager.gnome3.enable = true;
    windowManager.i3.enable = true;
  };

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableHardening = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers = {
    javaguirre = {
      group = "users";
      uid = 1000;
      extraGroups = [
        "adm"
        "audio"
        "networkmanager"
        "vboxusers"
        "tty"
        "video"
        "systemd-journal"
      ];
      createHome = true;
      home = "/home/javaguirre";
      shell = "/run/current-system/sw/bin/zsh";
      isNormalUser = true;
    };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

  # Security

  security.sudo = {
    enable = true;
    configFile =
      ''
        root        ALL=(ALL) SETENV: ALL
        javaguirre  ALL=(ALL) SETENV: ALL
      '';
  };

  nixpkgs.config = {
    firefox.enableAdobeFlash = true;
  };

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      ubuntu_font_family
      unifont
      powerline-fonts
    ];
  };
}
