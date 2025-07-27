{ config, pkgs, ... }:
let
  versionInfo = import ./version.nix { inherit pkgs; };
in
{
  # Import optional hardware-specific configuration (if installed)
  imports =
    if (builtins.tryEval <nixos-hardware>).success then [ /etc/nixos/nixos-hardware.nix ] else [ ];

  # Enable OpenGL (3D hardware-accelerated graphics)
  hardware.graphics.enable = true;

  # Some programs need SUID wrappers, can be configured further, or are started
  # in user sessions (gpg is used, e.g., to sign/encrypt mail in Thunderbird).
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable Flatpak (Linux "App Store" for graphical applications)
  services.flatpak.enable = true;
  # Flatpak needs at least one XDG desktop portal implementation
  # https://flatpak.github.io/xdg-desktop-portal/
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal ];
    config.common.default = "*"; # Use any available portal
  };

  # Enable NextDNS (privacy-focused DNS with ad blocking)
  services.nextdns.enable = true;
  # Legacy support for JACK applications (professional audio)
  services.pipewire.jack.enable = true;
  # Enable Power Profiles daemon (laptop battery/performance management)
  services.power-profiles-daemon.enable = true;
  # Enable CUPS to print documents (printer management)
  services.printing.enable = true;
  # OOM killer to prevent system freezes
  services.earlyoom.enable = true;
  # TTY mouse support
  services.gpm.enable = true;

  # Compatibility layer for non-NixOS binaries
  services.envfs.enable = true; # Provides /usr/bin/env and /bin/sh
  programs.nix-ld.enable = true; # Dynamic linker for pre-compiled binaries
  # Register AppImage files as executable (no extraction needed)
  programs.appimage = {
    enable = true;
    binfmt = true; # Auto-run AppImages via binfmt_misc
  };

  # Automatic garbage collection to save disk space
  nix.gc.automatic = true;
  # Use Lix (Nix fork with better error messages and stability)
  nix.package = pkgs.lix;
  # Enable Nix flakes (experimental)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Allow proprietary software (needed for many desktop apps)
  nixpkgs.config.allowUnfree = true;

  # Daily automatic system upgrades via the ricochets channel
  # The channel maintainers ensure updates never break existing configs
  system.autoUpgrade.enable = true;

  # Expose the pinned nixpkgs hash/rev in PATH.
  environment.systemPackages = [
    versionInfo.package
  ];
}
