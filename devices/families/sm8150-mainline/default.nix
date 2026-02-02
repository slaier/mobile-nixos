{ config, lib, pkgs, ... }:

{

  mobile.hardware = {
    soc = "qualcomm-sm8150";
  };

  mobile.boot.stage-1 = {
    compression = "xz";
    kernel.package = (pkgs.callPackage ./kernel { });
  };

  # Note: on devices it's highly likely no firmware is required during stage-1.
  # DRM *should* work fine without firmware.
  # Modems and such will pick them back up in stage-2.
  # Even though, we're eagerly adding firmware files that fit.
  # This is a workaround for non-modular kernels wanting to load the adsp firmware during stage-1.
  mobile.boot.stage-1.firmware = [
    (pkgs.runCommand "initrd-firmware" {} ''
      fw_dest=$out/lib/firmware
      fw_src=${config.mobile.device.firmware}/lib/firmware
      install -Dm644 $fw_src/qcom/{a630_sqe.fw,a640_gmu.bin} -t $fw_dest/qcom/
      install -Dm644 $fw_src/qcom/a640_zap.mbn -t $fw_dest/qcom/sm8150/xiaomi/raphael/
    '')
  ];


  mobile.system.type = "android";
  mobile.system.android = {
    # Assumed all SM8150 devices can boot with the same options.
    bootimg.flash = {
      offset_base = "0x00000000";
      offset_kernel = "0x00008000";
      offset_ramdisk = "0x00000000";
      offset_second = "0x00000000";
      offset_tags = "0x00000100";
      pagesize = "4096";
    };
    appendDTB = lib.mkDefault [
      "dtbs/qcom/sm8150-${config.mobile.device.name}.dtb"
    ];
  };

  mobile.usb.mode = "gadgetfs";
  # The identifiers used here serve as a compatible well-known identifier.
  mobile.usb.idVendor = lib.mkDefault "18D1"; # Google
  mobile.usb.idProduct = lib.mkDefault "D001"; # "Nexus 4"

  mobile.usb.gadgetfs.functions = {
    adb = "ffs.adb";
    mass_storage = "mass_storage.0";
    rndis = "rndis.usb0";
  };
}
