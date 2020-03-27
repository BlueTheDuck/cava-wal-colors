#!/bin/bash

original=$HOME/.config/cava/config
copy=$HOME/.config/cava/walconfig

if [[ "$1" = "-h" ]]; then
	echo "$0 updates '$copy' color setting to use a gradient with the current pywal colors"
	echo "Options: "
	echo "$0 <end>			# Take from 0 to <end> colors from pywal"
	echo "$0 <start> <end>	# Take from <start> to <end>"
	exit
fi

# You can remap pywal colors
if [ $# -eq 0 ]; then
	# Pywal colors [0; 7] will be used
	start=0
	stop=7
elif [ $# -eq 1 ]; then
	# Pywal colors [0; $1] will be used
	start=0
	stop=$1
elif [ $# -eq 2 ]; then
	# Pywal colors [$1; $2] will be used
	start=$1
	stop=$2
fi

. "$HOME/.cache/wal/colors.sh"

if [ ! -f "$HOME/.config/cava/walconfig" ]; then
	# I don't trust my code, so just to be safe, use "walconfig" instead of the default "config" file
	cp $original $copy
fi

touch dyn
echo 'gradient = 1' >> dyn
printf "gradient_count = %s\n" "$(( $stop - $start))" >> dyn
for c in $(seq $start $stop); do
	color="color$c"
	printf "gradient_color_%s = '%s'\n" "$(($c - $start))" ${!color} >> dyn
done		
sed '/^gradient/d ; /\[color\]/rdyn' -i $copy
rm dyn
