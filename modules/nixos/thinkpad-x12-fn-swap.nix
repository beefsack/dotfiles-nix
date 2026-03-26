{ pkgs, ... }:

let
  # Sends a USB control transfer to the X12 Detachable folio keyboard firmware
  # to swap Fn and Ctrl. The firmware stores the setting but resets on disconnect,
  # so a udev rule re-applies it on each connect.
  # Source: https://github.com/manueljaeckle/thinkpad_x12_fn_switcher
  x12FnSwitcher = pkgs.stdenv.mkDerivation {
    name = "x12-fn-switcher";
    src = pkgs.writeText "x12_fn_switcher.c" ''
      #include <stdio.h>
      #include <stdlib.h>
      #include <libusb-1.0/libusb.h>

      #define VENDOR_ID  0x17ef
      #define PRODUCT_ID 0x60fe
      #define HID_REQUEST_SET_REPORT 0x09
      #define HID_REPORT_TYPE_OUTPUT 0x02
      #define INTERFACE 1
      #define TIMEOUT 5000

      int main() {
          libusb_device_handle *handle;
          int res;

          unsigned char data[3] = { 0x09, 0xb4, 0x02 };

          if (libusb_init(NULL) < 0) {
              fprintf(stderr, "Error: Failed to initialize libusb\n");
              return EXIT_FAILURE;
          }

          handle = libusb_open_device_with_vid_pid(NULL, VENDOR_ID, PRODUCT_ID);
          if (!handle) {
              fprintf(stderr, "Error: Keyboard not found\n");
              libusb_exit(NULL);
              return EXIT_FAILURE;
          }

          libusb_set_auto_detach_kernel_driver(handle, 1);

          if (libusb_claim_interface(handle, INTERFACE) < 0) {
              fprintf(stderr, "Error: Failed to claim interface\n");
              libusb_close(handle);
              libusb_exit(NULL);
              return EXIT_FAILURE;
          }

          res = libusb_control_transfer(handle,
                                        LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
                                        HID_REQUEST_SET_REPORT,
                                        (HID_REPORT_TYPE_OUTPUT << 8) | data[0],
                                        INTERFACE, data, sizeof(data), TIMEOUT);

          if (res < 0) {
              fprintf(stderr, "Error while sending: %s\n", libusb_error_name(res));
          }

          libusb_release_interface(handle, INTERFACE);
          libusb_close(handle);
          libusb_exit(NULL);

          return res < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
      }
    '';
    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.libusb1 ];
    unpackPhase = "cp $src x12_fn_switcher.c";
    buildPhase = "gcc x12_fn_switcher.c -o x12_fn_switcher $(pkg-config --cflags --libs libusb-1.0)";
    installPhase = "mkdir -p $out/bin && cp x12_fn_switcher $out/bin/";
  };
in
{
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="60fe", RUN+="${x12FnSwitcher}/bin/x12_fn_switcher"
  '';
}
