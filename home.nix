{ pkgs, ... }: {
  
  home.username = "sami";
  home.homeDirectory = "/home/sami";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.sl
  ];

  programs.git = {
    enable = true;
    includes = [{ path = "~/.config/nixpkgs/gitconfig"; }];
  };

  programs.fzf = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}