{ config, pkgs, ... }:

{
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
