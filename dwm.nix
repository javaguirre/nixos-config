{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.xserver.windowManager.dwm;

in

{

  ###### interface

  options = {

    services.xserver.windowManager.dwm.enable = mkOption {
      default = false;
      description = "Enable the Dwm window manager.";
    };

  };


  ###### implementation

  config = mkIf cfg.enable {

    services.xserver.windowManager.session = singleton
      { name = "dwm";
        start =
          ''
            ${pkgs.dwm}/bin/dwm &
            waitPID=$!
          '';
      };

    environment.systemPackages = [ pkgs.dwm ];

  };

}
