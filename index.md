# runit-conversion - Arch Linux without systemd
**WARNING: Installation currently not possible**

libeudev conflicts with systemd-libs on libudev.so, I am working on a solution.

Installation guide:
```
# We have to force-reboot the machine, so save all your stuff and close as many programs as possible!
# It is best if you do the following steps from a tty with nothing else running
# Copying the reboot binary (actually systemctl) and running it after systemd is gone won't work,
# so if anyone knows a way around this, please open a pull request!

yay -Rdd base systemd systemd-sysvcompat
yay -S runit-conversion runit-services eudev shsysusers

# this is ugly as sin
echo e | sudo tee /proc/sysrq-trigger; echo b | sudo tee /proc/sysrq-trigger
```
Now enable your required services by symlinking from `/etc/sv/<service>` to `/var/service`

Two services are active per default: getty-tty1 and udevd.

### elogind
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

### FAQ
- What are the init scripts (stage 1 & 3)? [kisslinux init](https://github.com/kisslinux/init)
- How & where to add a boot/shutdown script? `/usr/lib/init/rc.d/<name>.<boot|pre.shutdown|post.shutdown>`
- How to enable more ttys?
```bash
cd /etc/sv
cp -r getty-tty1 getty-tty<N>
ln -s /etc/sv/getty-tty<N> /var/service
```
