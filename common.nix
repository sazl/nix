{
  system.stateVersion = "22.11";

  boot.loader.grub.device = "/dev/vda";

  fileSystems."/" = {
    device = "/dev/vda4";
    fsType = "ext4";
  };

  users = {
    mutableUsers = false;

    users = {
        root = {
          hashedPassword = "$6$kLlieiJm0z/Mp.6w$58E3zIFO/VQygkPpMGX7ahChQeJHP8qTJDNqbjZADhO0qttgQJZWgJLjIVeGQDJclv8EjihOvl0.zKFIknX29.";
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrOQWmyxekrE4dMlFIIk8CHebpkVhooFHoU9pVGShz2 sami@Samis-MBP"
          ];
        };

        sami = {
          hashedPassword = "!";
          isNormalUser = true;
          extraGroups = [ "wheel" "sudo" ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrOQWmyxekrE4dMlFIIk8CHebpkVhooFHoU9pVGShz2 sami@Samis-MBP"
          ];
        };
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "yes";
  };

  services.fail2ban = {
    enable = true;
   
    bantime-increment = {
      enable = true;

      maxtime = "48h";
      factor = "600";
    };
  };

  programs.mosh = { enable = true; };
  programs.htop = { enable = true; };

  networking.hostName = "sami-nixos";

  # Another option would be root on the server
  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];
}