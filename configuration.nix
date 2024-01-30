# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs,callPackage, nixpkgs-unstable , lanzaboote , ... }:

{
	imports = [ ./hardware-configuration.nix ./packs.nix ./virt.nix ./vfio.nix ];

# Use the systemd-boot EFI boot loader.
boot = {
	loader.systemd-boot.enable = false;
	loader.efi.canTouchEfiVariables = true;
	lanzaboote = {
		enable = true;
		pkiBundle = "/etc/secureboot";
	};
};

# Secure Boot stuff
boot.bootspec.enable = true;

# Enable IOMMU Grouping
boot.kernelParams = [ "intel_iommu=on" ];

networking.hostName = "radiant"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
networking.firewall.checkReversePath = false;
nixpkgs.config.allowUnfree = true;
# Set your time zone.
time.timeZone = "Europe/Amsterdam";

# Enable docker shit
virtualisation.docker.enable = true;

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

nixpkgs.overlays = [ (final: prev: {
	unstable = import nixpkgs-unstable {
		system = "x86_64-linux";
		config.allowUnfree = true;
	};	
}) ];

nix = {
	settings = {
		auto-optimise-store = true;
		experimental-features = [ "nix-command" "flakes" ];
	};
	registry = {
		"nixpkgs".to = {
			type = "path";
			path = pkgs.path;
		};
		"n".to = {
			type = "path";
			path = pkgs.path;
		};
		"u".to = {
			type = "path";
			path = pkgs.unstable.path;
		};
	};
};

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";
console = {
	font = "Lat2-Terminus16";
	keyMap = "de";
#    useXkbConfig = true; # use xkbOptions in tty.
};
environment.pathsToLink = [ "/libexec" ];

services.xserver.videoDrivers = ["nvidia"];

# Configure keymap in X11
services.xserver.layout = "de";
services.xserver.xkbOptions = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
services.printing.enable = true;
services.printing.drivers = [ pkgs.cnijfilter2 ];

# Enable sound.
sound.enable = true;
hardware.pulseaudio.enable = true;
hardware.bluetooth.enable = true;

# Disable powermanagement
services.power-profiles-daemon.enable = false;
# Enable tlp service

# Enable stuff for pgp to work
services.pcscd.enable = true;
programs.gnupg.agent = {
	enable = true;
	pinentryFlavor = "curses";
	enableSSHSupport = true;
};

programs.fish.enable = true;

# Define a user account. Don't forget to set a password with 'passwd'.
users.users.mya = {
	isNormalUser = true;
	extraGroups = [ "wheel" "video" "networkmanager" "docker"];
	shell = pkgs.fish;
};

# Install Steam
programs.steam = {
	enable = true;
};

hardware.opengl = {
	enable = true;
	driSupport = true;
	driSupport32Bit = true;
};

# Install nerdfont FiraCode

fonts.packages = with pkgs; [
	(nerdfonts.override { fonts = [ "FiraCode" ]; })
];

# Enable the OpenSSH daemon.
services.openssh.enable = true;

# Specialisation for VFIO option
specialisation."VFIO".configuration = {
	system.nixos.tags = [ "STONKS MODE" ];
	vfio.enable = true;
};

# Specialisation for GNOME Desktop Manager bro keine Ahnung wie ich das nur bei der VFIO variante deaktivieren kann :((
specialisation."GNOME".configuration = {
	services.xserver = {
		enable = true;
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
		system.nixos.tags = [ "GNOME MODE" ];
	};
};

# Virtualisation Stuff

virtualisation.libvirtd = {
	enable = true;
	qemu.ovmf.enable = true;
	qemu.runAsRoot = false;
	onBoot = "ignore";
	onShutdown = "shutdown";
};

# Prevent kernel from choosing the RTX as boot information card because of convenience
#boot.postBootCommands = "
#      modprobe -r nvidiafb
#      modprobe -r nouveau
# 
#      echo 0 > /sys/class/vtconsole/vtcon0/bind
#      echo 0 > /sys/class/vtconsole/vtcon1/bind
#      echo efi-framebuffer.0 > /sys/bus/platform/drivers/efiframebuffer/unbind
# 
#      DEVS='0000:01:00.0 0000:01:00.1'
# 
#      for DEV in $DEVS; do
#        echo 'vfio-pci' > /sys/bus/pci/devices/$DEV/driver_override
#      done
#      modprobe -i vfio-pci
#    ";


system.stateVersion = "23.05"; # Did you read the comment?
}

