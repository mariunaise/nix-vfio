{ config, pkgs, callPackage, nixpkgs-unstable, ...  }:

{
	environment.systemPackages = with pkgs;  [
	# Text Editors
	vim
	neovim
	micro

	# Web Browsers
	chromium
	epiphany
	tor-browser-bundle-bin
	firefox
	brave

	# Download and Network Tools
	wget
	wireguard-tools
	x2goclient
	mosh
	browsh
	nmap
	wireshark
	sshfs
	unstable.eduvpn-client
	unstable.protonvpn-gui

	# System Information and Utilities
	neofetch
	light
	glow
	gparted

	# Document Viewing and Editing
	okular
	inkscape
	gimp
	ghostscript
	ghostscript_headless
	# Version Control
	git

	# Development and Programming	
	gcc
	texlive.combined.scheme-full
	vscodium
	poetry
	nodejs
	ruby
	bundler
	jekyll
	fish
	go

	# Network Management
	networkmanagerapplet
	wakeonlan
	protonvpn-cli

	# Audio Control
	pamixer
	pavucontrol

	# Power Management
	tlp

	# Email Clients
	thunderbird
	evolution

	# Multimedia Playback and Editing
	vlc
	ffmpeg
	audacity
	ardour
	unstable.noisetorch

	# Database and Data Tools
	sqlite
	sqlitebrowser
	influxdb2

	# Messaging and Communication
	telegram-desktop
	unstable.discord
	zoom-us
	signal-desktop

	# Security and Cryptography
	gnupg
	unstable.vscode
	hashcat
	openssl
	john
	social-engineer-toolkit
	
	# Privacy Tools
	unstable.openttd
	trezor-suite
	
	# Gaming
	unstable.minecraft
	prismlauncher
	fabric-installer

	# Miscellaneous
	spotify
	xorg.xhost
	micro
	aircrack-ng

	# VIRT
	virt-manager
	pciutils
	#qemu-audio-pa	

	# Note: Some programs may fit multiple categories, and categorization can be subjective.
];
}
