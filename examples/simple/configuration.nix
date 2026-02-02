{ pkgs, ... }:
{
  mobile.adbd.enable = true;
  mobile.boot.stage-1.networking.enable = true;
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKAUdxAZHd02htr4UkdmKgZDZqSA15G49rzkTypDNA7P''
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];
}
