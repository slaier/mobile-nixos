{ lib
, fetchFromGitHub
, runCommand
}:

let
  baseFw = fetchFromGitHub {
    owner = "dabao1955";
    repo = "pmos_firmware_xiaomi_raphael";
    rev = "cf9d303adda1cf25dad22cadc192f762f0a06a17";
    sha256 = "sha256-XABMd2m9YHwta5AVjXbkcJP0T3svTXUy/2XRowF+Vpk=";
  };
in runCommand "xiaomi-raphael-firmware" {
  inherit baseFw;
  # We make no claims that it can be redistributed.
  meta.license = lib.licenses.unfree;
} ''
  # adreno
  install -Dm644 "$baseFw"/sm8150/raphael/a6* -t \
    "$out/lib/firmware/qcom/"

  # adsp
  install -Dm644 "$baseFw"/sm8150/raphael/adsp* -t \
    "$out/lib/firmware/qcom/sm8150/xiaomi/raphael/"

  # ath10k
  install -Dm644 "$baseFw"/sm8150/raphael/wlan/ath10k/board-2.bin -t \
    "$out/lib/firmware/ath10k/WCN3990/hw1.0/"
  install -Dm644 "$baseFw"/sm8150/raphael/wlan/ath10k/firmware-5.bin -t \
    "$out/lib/firmware/ath10k/WCN3990/hw1.0/"

  # bluetooth
  install -Dm644 "$baseFw"/sm8150/raphael/crnv21.bin -t \
    "$out/lib/firmware/raphael/"

  # camera
  install -Dm644 "$baseFw"/sm8150/raphael/CAMERA_ICP.elf -t \
    "$out/lib/firmware/"

  # cdsp
  install -Dm644 "$baseFw"/sm8150/raphael/cdsp* -t \
    "$out/lib/firmware/qcom/sm8150/xiaomi/raphael/"

  # ipa
  install -Dm644 "$baseFw"/sm8150/raphael/ipa* -t \
    "$out/lib/firmware/qcom/sm8150/Xiaomi/raphael/"

  # modem
  install -Dm644 "$baseFw"/sm8150/raphael/modem* -t \
    "$out/lib/firmware/qcom/sm8150/xiaomi/raphael/"

  # slpi
  install -Dm644 "$baseFw"/sm8150/raphael/slpi* -t \
    "$out/lib/firmware/qcom/sm8150/xiaomi/raphael"

  # touchscreen
  install -Dm644 "$baseFw"/sm8150/raphael/good* -t \
    "$out/lib/firmware/"

  # venus
  install -Dm644 "$baseFw"/sm8150/raphael/venus.mbn -t \
    "$out/lib/firmware/qcom/sm8150/Xiaomi/raphael/"

  # wlan
  install -Dm644 "$baseFw"/sm8150/raphael/wlanmdsp.mbn -t \
    "$out/lib/firmware/"
''
