{ config, lib, pkgs, ... }:

{
  imports = [
    ../families/sm8150-mainline
  ];

  mobile.device.name = "xiaomi-raphael";
  mobile.device.identity = {
    name = "Xiaomi raphael";
    manufacturer = "Xiaomi";
  };
  mobile.device.supportLevel = "supported";

  mobile.hardware = {
    ram = 1024 * 8;
    screen = {
      width = 1080; height = 2340;
    };
  };

  mobile.device.firmware = pkgs.callPackage ./firmware {};

  mobile.system.android.device_name = "XiaomiRaphael";
}
