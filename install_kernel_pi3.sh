#!/bin/bash

KERNEL=kernel7
INST_PATH="/"
CCOPT=""
INSTOPT=""
for OPT in "$@"; do
	case "$OPT" in
		"-a" )
			if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "$PROGNAME: option requires an argument -- $1" 1>&2
                exit 1
            fi
			case "$2" in
				"pi" | "pi2" ) KERNEL=kernel ;;
				* ) KERNEL=kernel7 ;;
			esac
            shift 2
			;;
		"-i" )
			if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "$PROGNAME: option requires an argument -- $1" 1>&2
                exit 1
            fi
			INST_PATH="${2}"
			INSTOPT="INSTALL_MOD_PATH=${INST_PATH}"
            shift 2
			;;
		"-cc" )
			CCOPT="ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-"
			shift 1
			;;
		"-h" )
			echo "	-a [arch]		select architecture from pi/pi2/pi3"
			echo "				(default pi3)"
			echo "	-i [path]		install pash"
			echo "				(default local install)"
			echo "	-cc			cross compile option"
			echo "	-h			show this help"
			exit 0
			;;
	esac
done
if [ -n "${CCOPT}" ] && [ "${INST_PATH}" = "/" ] ; then
	echo "you must set install path"
	exit 1
fi

if ! [ -d ${INST_PATH}/boot ] || ! [ -d ${INST_PATH}/boot/overlays ]; then
	mkdir -p ${INST_PATH}/boot/overlays
fi
if ! [ -d ${INST_PATH}/boot/overlays ] ; then
	echo "no such directry"
	exit 1
fi

sudo make ${CCOPT} ${INSTOPT} modules_install
if [ -f ${INST_PATH}/boot/$KERNEL.img ] ; then
	sudo cp ${INST_PATH}/boot/$KERNEL.img ${INST_PATH}/boot/$KERNEL-backup.img
fi
sudo scripts/mkknlimg arch/arm/boot/zImage ${INST_PATH}/boot/$KERNEL.img
sudo cp arch/arm/boot/dts/*.dtb ${INST_PATH}/boot/
sudo cp arch/arm/boot/dts/overlays/*.dtb* ${INST_PATH}/boot/overlays/
sudo cp arch/arm/boot/dts/overlays/README ${INST_PATH}/boot/overlays/
