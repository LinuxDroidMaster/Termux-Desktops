#!/data/data/com.termux/files/usr/bin/bash
export olddir=$PWD
show_help() {
cat << EOF
Usage: ${0##*/} [-hu] FILE [Args...]
Exec

    -h          Display this help and exit
    -u --update Update mobox before running
EOF
}

update=false

while :; do
    case $1 in
    	"")
    		break
    		;;
        -h|-\?|--help)
            show_help    # Display a usage synopsis
            exit
            ;;
        -u|--update)
            update=true
            ;;
        --)              # End of all options
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)               # Default case: No more options, so break out of the loop
                         # Leaves the rest of the arguments to be passed to wine
        	break
            ;;
    esac

    shift
done

if [ "$#" -eq 0 ]; then
	echo "No input"
    show_help
    exit 1
fi



# [mobox]
. $PREFIX/glibc/opt/package-manager/token
function wget-git-q {
	wget -q --retry-connrefused --tries=0 --header "PRIVATE-TOKEN: $PRIVATE_TOKEN" "https://gitlab.com/api/v4/projects/$PROJECT_ID/repository/files/$1/raw?ref=main" -O $2
	return $?
}


if [ "$update" = true ] ; then
	mv $PREFIX/glibc/opt/package-manager/package-manager $PREFIX/glibc/opt/package-manager/package-manager-bak 
	wget-git-q "package-manager" "$PREFIX/glibc/opt/package-manager/package-manager"
	if [ "$?" = "0" ]; then
		rm $PREFIX/glibc/opt/package-manager/package-manager-bak
		. $PREFIX/glibc/opt/package-manager/package-manager
		sync-all
		sleep 2
	else
		mv $PREFIX/glibc/opt/package-manager/package-manager-bak $PREFIX/glibc/opt/package-manager/package-manager
		echo "Couldn't check for updates"
		sleep 1
		. $PREFIX/glibc/opt/package-manager/package-manager
	fi
fi


# [start-tfm]
cd # This line changes your directory to home. It is specifically problematic because some executables REQUIRE you to be within the executable's directory
mkdir -p /sdcard/Android/data/com.termux/files/Download
mkdir -p /sdcard/moboxtrace

. $PREFIX/glibc/opt/scripts/configs
load_configs

function stop-all {
	pkill -f "app_process / com.termux.x11"
	rm -rf $PREFIX/tmp/pulse-*
	pulseaudio -k &>/dev/null
	unset PULSE_SERVER
	pkill pulseaudio
	rm -rf $PREFIX/tmp/.virgl_test &>/dev/null
	pkill virgl
	rm -rf $PREFIX/tmp/.virgl_test &>/dev/null
}

chmod +x $PREFIX/glibc/bin/box64
chmod +x $WINE_PATH/bin/{wine,wineserver}
patchelf --force-rpath --set-rpath $PREFIX/glibc/lib --set-interpreter $PREFIX/glibc/lib/ld-linux-aarch64.so.1 $PREFIX/glibc/bin/box64
rm -rf $PREFIX/glibc/bin/{wine,wineserver}
ln -sf $WINE_PATH/bin/wine $PREFIX/glibc/bin/wine
ln -sf $WINE_PATH/bin/wineserver $PREFIX/glibc/bin/wineserver

export GLIBC_BIN=$PREFIX/glibc/bin
LD_PRELOAD_SAVED=$LD_PRELOAD
unset LD_PRELOAD



if ! ls $PREFIX/glibc/opt/prefix/start/Registry/2.* &>/dev/null; then
	cp -r $PREFIX/glibc/opt/prefix/start/Registry/2.* $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Registry
fi

rm -rf "$WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start Menu/Install/media foundation (for RE)"

if [ ! -e "$WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start Menu/Install/media foundation (for RE).lnk" ]; then
	cp "$PREFIX/glibc/opt/prefix/start/Install/media foundation (for RE).lnk" "$WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start Menu/Install"
fi

rm -rf $PREFIX/glibc/opt/prefix/start-default

rm -d $PREFIX/glibc/opt/prefix/start/Install/1.* &>/dev/null
rm -d $PREFIX/glibc/opt/prefix/start/Install/2.* &>/dev/null
rm -d $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Install/1.* &>/dev/null
rm -d $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Install/2.* &>/dev/null

if ls $PREFIX/glibc/opt/prefix/start/Install/1.* &>/dev/null && ls $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Install/1.* &>/dev/null; then
	rm -rf $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Install/1.*/* &>/dev/null
	cp $PREFIX/glibc/opt/prefix/start/Install/1.*/* $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Install/1.* &>/dev/null
fi

if ls $PREFIX/glibc/opt/prefix/start/Install/2.* &>/dev/null && ls $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Install/2.* &>/dev/null; then
	rm -rf $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Install/2.*/* &>/dev/null
	cp $PREFIX/glibc/opt/prefix/start/Install/2.*/* $WINEPREFIX/drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Install/2.* &>/dev/null
fi

mkdir -p $WINEPREFIX/moboxmeta
if [ ! -f $WINEPREFIX/moboxmeta/services-fix-applied ]; then
	echo "Applying services fix"
	taskset -c $PRIMARY_CORES $GLIBC_BIN/box64 $GLIBC_BIN/wine regedit $PREFIX/glibc/opt/prefix/fix-services.reg &>/dev/null
	sleep 5
	$GLIBC_BIN/box64 $GLIBC_BIN/wineserver -k &>/dev/null
	touch $WINEPREFIX/moboxmeta/services-fix-applied
fi
if [ ! -f $WINEPREFIX/moboxmeta/fonts-fix-applied ]; then
	echo "Applying fonts fix"
	tar -xf $PREFIX/glibc/opt/prefix/fix-fonts.tar.xz -C $WINEPREFIX/drive_c/windows
	touch $WINEPREFIX/moboxmeta/fonts-fix-applied
fi
if [ ! -f $WINEPREFIX/moboxmeta/dxdlls-fix-applied ]; then
	echo "Applying dlls fix"
	7z x $PREFIX/glibc/opt/prefix/directx.7z -o$WINEPREFIX/drive_c -y &>/dev/null
	taskset -c $PRIMARY_CORES $GLIBC_BIN/box64 $GLIBC_BIN/wine regedit $PREFIX/glibc/opt/prefix/user.reg &>/dev/null
	sleep 5
	$GLIBC_BIN/box64 $GLIBC_BIN/wineserver -k &>/dev/null
	touch $WINEPREFIX/moboxmeta/dxdlls-fix-applied
fi

load_configs

ln -sf $(df -H | grep -o "/storage/....-....") "$WINEPREFIX/dosdevices/f:" &>/dev/null

# cd back to the original directory(OG games require you to be in the same directory as the executable)
cd "$olddir"
#echo $PWD
#echo $olddir
# Run the target app
taskset -c $PRIMARY_CORES $GLIBC_BIN/box64 $GLIBC_BIN/wine "$@"


if [ "$STARTUP_WINEDEVICE_MODE" = "0" ]; then
	$GLIBC_BIN/box64 $GLIBC_BIN/wine taskkill /f /im services.exe &>/dev/null &
fi

export LD_PRELOAD=$LD_PRELOAD_SAVED
