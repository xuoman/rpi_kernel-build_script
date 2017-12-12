# rpi_kernel-build_script
kernel build scripts for raspberry pi

see too
[Kernel building - Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/linux/kernel/building.md)

## Usage
## First time
```
git clone --depth=1 https://github.com/raspberrypi/linux
cd linux
```
### Make
make kernel for pi3 on local build.
```
$./make_kernel_pi3.sh
```
For pi, make clean, cross compile
```
$./make_kernel_pi3.sh -cc -c -a pi
```
Other options For make.
These options can't write contiusly.
```
$ ./make_kernel_pi3.sh -h
        -a [arch]               select architecture from pi/pi2/pi3
                                (default pi3)
        -m                      do menuconfig
        -c                      do make clean
        -cc                     cross compile
        -h                      show this help
```

### Install
This script must select the same arch options.
install kernel to own for pi3.
```
$./install_kernel_pi3.sh
```
install kernel to own for pi3.
```
$./install_kernel_pi3.sh
```
specify install path
```
$./install_kernel_pi3.sh -i /home/pi/inst_mod/
```
Other options For install.
These options can't write contiusly.
```sh
$./install_kernel_pi3.sh -h
        -a [arch]               select architecture from pi/pi2/pi3
                                (default pi3)
        -i [path]               install pash
                                (default local install)
        -cc                     cross compile option
        -h                      show this help

```
