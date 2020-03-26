#!/bin/zsh

lastUrl=""

sender=org.mpris.MediaPlayer2.spotify 
interface=org.freedesktop.DBus.Properties
member=PropertiesChanged
dbus-monitor --profile "interface='$interface',member='$member',type='signal',sender='$sender'" | 
while read -r line; do
	newUrl=$(./get-album-art-url)
	if [[ $newUrl = $oldUrl ]]; then
		echo Not updating
	else
		oldUrl=$newUrl
		./update.sh
	fi
done

