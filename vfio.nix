let
	# RTX 3070 TI
	gpuIDs = [
		"10de:2482" # Graphics part
		"10de:228b" # Audio part
	];
in { pgks, lib, config, ... }: {
	options.vfio.enable = with lib;
	  mkEnableOption "Put machine in gayming mode";

	config = let cfg = config.vfio;
	in {
		boot = {
			initrd.kernelModules = [
				"vfio_pci"
				"vfio"
				"vfio_iommu_type1"
				"vfio_virqfd"

				"nvidia"
				"nvidia_modeset"
				"nvidia_uvm"
				"nvidia_drm"
			];

			kernelParams = [
				# enable IOMMU
				"intel_iommu=on"
				"pcie_aspm=off"
				"kvm-intel"
				"i915.force_probe=4680"
			] ++ lib.optional cfg.enable
			  # yoink the GPU
			  ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs );
		};
		hardware.opengl.enable = true;
		virtualisation.spiceUSBRedirection.enable = true;
	};
}
