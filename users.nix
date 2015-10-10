{ config, pkgs, ... }:

{
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

  # Security
  security.sudo = {
    enable = true;
    configFile =
      ''
        root        ALL=(ALL) SETENV: ALL
        javaguirre  ALL=(ALL) SETENV: ALL
      '';
  };
}
