# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

# let
#   unstable = import <nixos-unstable> { };
# in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;
  # networking.interfaces.docker0.useDHCP = true;
  # networking.interfaces.br-60e92623429b.useDHCP = true;
  # networking.interfaces.tun0.useDHCP = true;
  # networking.interfaces.virbr0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.variables = {
    SYS_THEME = "dark";
    VI_CONFIG = "~/.config/nvim/init.vim";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = true;
      xfce.enable = true;
    };
    dpi = 190;
    # dpi = 110; # this is better for the dell 27i 4k screen

    displayManager = {
      defaultSession = "none+leftwm";
      autoLogin = {
        enable = true;
        user = "marcel";
      };
      sessionCommands = ''
         ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
          Xft.dpi:   190
          *.dpi: 190
          marcel.fractionalDpi: 1.90
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

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marcel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    tcpdump
    wget
    firefox
    # kitty
    plocate
    termite
    alacritty
    # unstable.git
    git
    rustup
    cargo
    gcc
    cmake
    openssl
    openssl.dev
    polybar
    pkg-config
    bluez
    zoxide
    starship
    exa
    neofetch
    volumeicon
    sxhkd
    haskellPackages.greenclip
    feh
    rofi
    skim
    pavucontrol
    ponymix
    unzip
    fzf
    fzy
    arandr
    autorandr
    bat
    ripgrep
    lua
    lua53Packages.luarocks
    python3
    delta
    fd
    sad
    gh
    python3
    xsel
    nodejs
    flameshot
    rofi-power-menu
    webcamoid
    bluez
    nixpkgs-fmt
    slack
    docker-compose
    xdotool
    libnotify
    rofimoji
    sysz
    tldr
    nix-prefetch-github
    glow
    element-desktop
    mitmproxy
    xfce.xfce4-notifyd
    sumneko-lua-language-server
    kazam
    mpv
    yt-dlp
    pfetch
    discord
    # chromium
    # dunst
    # update-systemd-resolved
    # openvpn
    # home-manager
    # fish
    # vim
  ];

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
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
    nerdfonts
  ];

  # environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
  services.resolved.enable = true;
  services.openvpn.servers = {
    soysuper = {
      config = '' config /root/nixos/openvpn/soysuper.conf '';
      updateResolvConf = true;
    };
  };

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
