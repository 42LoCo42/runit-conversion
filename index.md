# runit-conversion - Arch Linux without systemd
Installation guide:
```
# Switch to a TTY and do this:
yay -S runit-conversion runit-services
# runit-conversion will replace systemd-sysvcompat
# Then type Ctrl+Alt+Del to reboot the machine. reboot/shutdown -r won't work at this stage!
```
Now enable your required services by symlinking from `/etc/sv/<service>` to `/var/service`

Two services are active per default: getty-tty1 and udevd (which is really systemd-udevd and the only hard dependency on systemd).

### FAQ
- What are the init scripts (stage 1 & 3)? [kisslinux init](https://github.com/kisslinux/init)
- How & where to add a boot/shutdown script? `/etc/rc.d/<name>.<boot|pre.shutdown|post.shutdown>`
- How to enable more ttys?
```bash
cd /etc/sv
cp -r getty-tty1 getty-tty<N>
ln -s /etc/sv/getty-tty<N> /var/service
```

### NO LONGER REQUIRED - elogind
The PKGBUILD for elogind in the AUR is broken. To use it, apply
[this](https://gist.github.com/42LoCo42/5007d7a7a7a870742e67b16363b3effb)
patch, for example like so:
```bash
git clone https://aur.archlinux.org/elogind
cd elogind
curl -LO https://gist.githubusercontent.com/42LoCo42/5007d7a7a7a870742e67b16363b3effb/raw/20b90e2257603d6649648d7ef7d8c8cfbe826d98/elogind-paths.patch
patch < elogind-paths.patch
makepkg -si
```
I have [contacted](https://aur.archlinux.org/pkgbase/elogind/#comment-825753) the package maintainer about this issue.
