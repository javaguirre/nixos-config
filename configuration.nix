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
    bluez
    emacs24Packages.cask
    chromium
    ctags
    emacs
    firefoxWrapper
    gcc
    git
    gnome3.geary
    gnome3.gnome-tweak-tool
    gparted
    htop
    idea.android-studio
    linuxPackages_4_1.virtualbox
    python34Packages.glances
    python34Packages.powerline
    spideroak
    stow
    tmux
    unzip
    vagrant
    vim_configurable
    vlc
    wget
    zsh
  ];

  # List services that you want to enable:
  virtualisation.virtualbox.host.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Firewall
  networking.firewall = {
    # Disabled due to Chromecast problem https://github.com/NixOS/nixpkgs/issues/3107
    enable = false;
    allowedTCPPorts = [ 80 443 22 5556 ];
    allowedUDPPorts = [ 5556 ];
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e,ctrl:nocaps";

    synaptics.enable = true;
    synaptics.twoFingerScroll = true;

    desktopManager.gnome3.enable = true;
    windowManager.i3.enable = false;
  };

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
    allowUnfree = true;

    firefox = {
        enableAdobeFlash = true;
        enableGoogleTalkPlugin = true;
    };
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
