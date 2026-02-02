# Ensure CLI passes down arguments
{ ... }@args:

import ../../lib/eval-with-configuration.nix (args // {
  configuration = [ (import ./configuration.nix) ];
  additionalHelpInstructions = { device }: ''
      $ nix-build examples/simple --argstr device ${device} -A outputs.android-fastboot-images
  '';
})
