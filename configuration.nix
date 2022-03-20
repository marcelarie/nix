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

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  # networking.interfaces.enp2s0f0.useDHCP = true;
  # networking.interfaces.enp5s0.useDHCP = true;

  environment.variables = {
    SYS_THEME = "dark";
    VI_CONFIG = "~/.config/nvim/nix.init.lua";
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "2";
    EDITOR = "nvim";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
      xfce.enable = true;
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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  #sound.enable = false;

  # rtkit is optional but recommended
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;
  #
  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marcel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "plocate" ]; # Enable ‘sudo’ for the user.
  };

  users.extraGroups.networkmanager.members = [ "root" ];
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    sqlite
    xorg.xkill
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.nm-applet.enable = true;

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
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

  services.tlp = {
    enable = true;
  };

  # boot.loader.grub = {
  #   extraConfig = ''
  #     GRUB_CMDLINE_LINUX="amdgpu.backlight=0"
  #     GRUB_GFXMODE=640x480
  #     GRUB_GFXPAYLOAD_LINUX="keep"
  #     GRUB_TERMINAL_OUTPUT="gfxterm"
  #   '';
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
