#!/bin/bash

KERNEL=kernel7
MAKECLEAN=0
MENUCONF=0
CCOPT=""
for OPT in "$@"; do
	case "$OPT" in
		"-a" )
			if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "$PROGNAME: option requires an argument -- $1" 1>&2
                exit 1
            fi
			case "$2" in
				"pi" | "pi2" )
					KERNEL=kernel ;;
				"pi3" )
					KERNEL=kernel7 ;;
				* )
					echo "select from pi/pi2/pi3"
					exit 1
					;;
			esac
            shift 2
			;;
		"-m" )
			MENUCONF=1
			shift 1
			;;
		"-c" )
			MAKECLEAN=1
			shift 1
			;;
		"-cc" )
			CCOPT="ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-"
			shift 1
			;;
		"-h" )
			echo "	-a [arch]		select architecture from pi/pi2/pi3"
			echo "				(default pi3)"
			echo "	-m			do menuconfig"
			echo "	-c			do make clean"
			echo "	-cc			cross compile"
			echo "	-h			show this help"
			exit 0
			;;
	esac
done

case "$KERNEL" in
        "kernel" ) make ${CCOPT} bcmrpi_defconfig ;;
        "kernel7" ) make ${CCOPT} bcm2709_defconfig ;;
		* ) exit 1 ;;
esac
if [ "$MENUCONF" != "0" ] ; then
	make menuconfig
fi
if [ "$MAKECLEAN" != "0" ] ; then
	make clean
fi
if [ -f .config ] ; then
	make ${CCOPT} -j4 zImage modules dtbs
else
	echo "config error"
fi
