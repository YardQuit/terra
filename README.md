[![Build container image](https://github.com/YardQuit/terra/actions/workflows/build.yml/badge.svg)](https://github.com/YardQuit/terra/actions/workflows/build.yml)
# Terra

## Purpose

My personal daily drive built from uBlue-os/image-template, utilizing the Fedora Cosmic container image (quay.io/fedora-ostree-desktops/cosmic-atomic:43) featuring the Cosmic Desktop. This setup includes development tools, including packages for Rust, C, Go, and Zig, as well as the Helix, Neovim, and Emacs editor for efficient writing. Furthermore, YubiKey authentication are enabled for sudo access, providing an additional layer of protection.
## Install
### rpm-ostree rebase
Rebase from rpm-ostree:
```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/yardquit/terra:latest
```
Restart your system for the changes take effect:
```bash
systemctl reboot
```

### bootc switch
Rebase from bootc
```bash
sudo bootc switch ghcr.io/yardquit/terra:latest
```

Restart your system for the changes take effect:
```bash
systemctl reboot
```

### YubiKey
Instructions to complete the yubikey registration process.
```bash
# Insert your YubiKey into a compatible USB port on your computer.
ykpamcfg -2
```
Ensure that YubiKey support is enabled and functional in your system settings.
```bash
sudo echo "Testing sudo with YubiKey"
```
