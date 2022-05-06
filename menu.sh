#! /bin/bash

## PARAMETERS FOR QMENU
## GRUVBOX COLORS
col_bg0="#282828";
col_bg1="#3c3836";
col_bg2="#504945";
col_bg3="#665c54";
col_bg4="#7c6f64";

col_fg0="#fbf1c7";
col_fg1="#ebdbb2";
col_fg2="#d5c4a1";
col_fg3="#bdae93";
col_fg4="#a89984";
## Pale
col_red="#cc241d";
col_green="#98971a";
col_yellow="#d79921";
col_blue="#458588";
col_purple="#b16286";
col_aqua="#689d6a";
## Bright
col_0red="#fb4934";
col_0green="#b8bb26";
col_0yellow="#fabd2f";
col_0blue="#83a598";
col_0purple="#d3869b";
col_0aqua="#8ec07c";

# Aesthetic parameters
FONT="iosevika:pixelsize=16:antialias=true:autohint=true"
NB=$col_bg0
NF=$col_fg0
SB=$col_bg0
SF=$col_0blue
PR="q to exit"
params="-fn $FONT -nb $NB -nf $NF -sb $SB -sf $SF"

MENU_PATH=${1:-/home/$USER/.qmenu}
appendix=()



function test_run {
	workpath=$MENU_PATH
	for dir in ${appendix[@]}; do
		workpath+="/$dir"
	done

	unset -v contents
	unset -v options
	contents=($(ls $workpath))

	for item in "${contents[@]}"; do
		options+="$item\n"
	done
	options+=back

	choice="$(echo -e $options | dmenu $params -p 'q to exit')"

#	echo $choice

	# Emergency exit:
	if [ "$choice" = "q" ]
	then
		exit 1
	fi

	# Pressing back TODO
	if [ "$choice" = "back" ]
	then
		if [ ${#appendix[@]} == 0 ]
		then
			return 1
		else
			unset appendix[-1]
			return 0
		fi
	fi

	# Check directory or command
	if [ -d $workpath/$choice ]
	then
		appendix+=("$choice")
		return 0
	else
		command=$(cat $workpath/$choice)
		$command
	fi
}

#test_run
while test_run; do :; done


#LEGACY

function menu_run 
{
#	declare -A opts
#	opts=$1	

	unset -v optstring
	for key in "${!opts[@]}"
	do
		optstring+="$key\n"
	done
	optstring+="back"
	choice="$(echo -e $optstring | dmenu $params)"
	if [ "$choice" = "back" ]
	then
		return 1
	fi
	${opts[$choice]}
}


function test_menu
{
	unset -v opts
	declare -A opts
	opts[vasya]='xsetroot -name Vasya'
	opts[petya]='xsetroot -name Petya'
	
	menu_run
	main_menu
}


### PRIMARY MENU
function main_menu
{
	unset -v opts
	declare -A opts
	opts["some test features menu"]='test_menu'
	opts["open qmenu directory"]='st -e ranger /home/m4x0n/.qmenu'

	menu_run
}

function main
{	
	main_menu
#	while main_menu; do :; done
}
