# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./grub.nix
      ./packages.nix
      ./users.nix
    ];

  networking = {
    hostName = "calypso";
    networkmanager.enable = true;
    firewall = {
        # Disabled due to Chromecast problem
        # https://github.com/NixOS/nixpkgs/issues/3107
        enable = false;
        allowedTCPPorts = [ 80 443 22 5556 ];
        allowedUDPPorts = [ 5556 ];
    };
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List services that you want to enable:
  virtualisation.virtualbox.host.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

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
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };
}
