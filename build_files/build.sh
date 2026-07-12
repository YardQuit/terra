#!/bin/bash

set -ouex pipefail

### Copy sysfiles
cp -rv /ctx/sysfiles/* /
chmod +x /etc/cron.daily/*

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# This installs a package from fedora repos
# dnf5 group install --skip-unavailable -y cosmic-desktop

dnf5 install --skip-unavailable -y $(cat /ctx/rpm_packages)
# dnf5 install --skip-unavailable -y $(cat /ctx/rpm_packages_latex)

# Enable copr repositories
dnf5 -y copr enable atim/starship
# dnf5 -y copr enable pennbauman/ports
# dnf5 -y copr enable scottames/ghostty

# Install from copr repositories
dnf5 -y install starship
# dnf5 -y install lf
# dnf5 -y install ghostty

# Disable copr repositories
dnf5 -y copr disable atim/starship
# dnf5 -y copr disable pennbauman/ports
# dnf5 -y copr disable scottames/ghostty

# Install Mega Client
# wget https://mega.nz/linux/repo/Fedora_44/x86_64/megasync-Fedora_44.x86_64.rpm
# dnf5 -y install "$PWD/megasync-Fedora_44.x86_64.rpm"
# rm -f "$PWD/megasync-Fedora_44.x86_64.rpm"

# Install Mega CLI
# wget https://mega.nz/linux/repo/Fedora_44/x86_64/megacmd-Fedora_44.x86_64.rpm
# dnf5 -y install "$PWD/megacmd-Fedora_44.x86_64.rpm"
# rm -f "$PWD/megacmd-Fedora_44.x86_64.rpm"

# Proton Bridge
wget https://github.com/ProtonMail/proton-bridge/releases/download/v3.23.1/protonmail-bridge-3.25.0-1.x86_64.rpm
dnf5 -y install "$PWD/protonmail-bridge-3.23.1-1.x86_64.rpm"
rm -f "$PWD/protonmail-bridge-3.23.1-1.x86_64.rpm"

# Clean
dnf5 -y clean all

#### System Unit File
systemctl enable tuned.service
systemctl enable podman.socket
systemctl enable fstrim.timer
systemctl enable firewalld.service
systemctl enable tailscaled.service

### Change default firewalld zone
cp /etc/firewalld/firewalld-workstation.conf /etc/firewalld/firewalld-workstation.conf.bak
sed -i 's/DefaultZone=FedoraWorkstation/DefaultZone=drop/g' /etc/firewalld/firewalld-workstation.conf

### Yubikey configuration
cp /etc/pam.d/sudo /etc/pam.d/sudo.bak &&
sed -i '/PAM-1.0/a\auth       required     pam_yubico.so mode=challenge-response' /etc/pam.d/sudo

### Create missing dirs
mkdir -p /var/spool/anacron
