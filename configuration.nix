# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  dpi = 250;
  fr_dpi = "2.50";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  programs.dconf.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.kernelPackages = pkgs.linuxPackages_5_16;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "quiet" "button.lid_init_state=open" "vt.global_cursor_default=0" ];

  systemd.services.systemd-udev-settle.enable = false;
  # systemd.services.NetworkManager-wait-online.enable = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  networking.useDHCP = false;
  # networking.interfaces.enp2s0f0.useDHCP = true;
  # networking.interfaces.enp5s0.useDHCP = true;

  environment.variables = {
    SYS_THEME = "dark";
    VI_CONFIG = "~/.config/nvim/nix.init.lua";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "2";
    EDITOR = "nvim";
    XCURSOR_SIZE = "64";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    OPENSSL_DIR = "${pkgs.openssl.dev}";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    desktopManager = {
      xterm.enable = true;
      # xfce.enable = true;
    };
    dpi = dpi;
    # dpi = 110; # this is better for the dell 27i 4k screen

    displayManager = {
      defaultSession = "none+leftwm";
      autoLogin = {
        enable = true;
        user = "marcel";
      };
      sessionCommands = ''
         ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
          Xft.dpi: ${builtins.toString(dpi)}
          *.dpi: ${builtins.toString(dpi)}
          marcel.fractionalDpi: ${fr_dpi}
          Xcursor.size: 32
        EOF
      '';
      # setupCommands = ''
      #     ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --auto --output HDMI-0 --auto --scale 2x2 --right-of DP-0
      # '';
    };
    windowManager.leftwm = {
      enable = true;
    };
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  services.auto-cpufreq.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.illum.enable = true;

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marcel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "plocate" ]; # Enable ‘sudo’ for the user.
  };

  users.extraGroups.networkmanager.members = [ "root" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    bind
    bluez
    xsel
    cmake
    gcc
    openssl
    xdotool
    dmenu
    cowsay
    sqlite
    xorg.xkill
    direnv
  ];

  programs.nm-applet.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    # mplus-outline-fonts
    dina-font
    proggyfonts
    gohufont
    nerdfonts
  ];

  services.locate = with pkgs; {
    enable = true;
    locate = plocate;
    interval = "hourly";
    localuser = null;
  };

  networking.extraHosts = '' '';

  services.logind.lidSwitch = "suspend";
  services.lorri.enable = true;

  services.tlp = {
    enable = true;
    # settings = { };
  };

  # services.xserver.synaptics.enable = true;
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      middleEmulation = true;
      tapping = true;
      naturalScrolling = true;
    };
  };

  system.stateVersion = "22.05";

}
