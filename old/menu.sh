#! /bin/bash

source "/home/$USER/.qmenu/parameters.sh"
source "/home/$USER/.qmenu/menus.sh"

function test 
{
	optarray=(
		"Option number 1" 
		"Option number 2" 
		"Option number 3"
	)

	for ((i = 0; i < ${#optarray[@]}; i++))
	do
		optstring+="${optarray[$i]}\n"
	done
	echo -e $optstring | dmenu $params
}

function test2 
{
	declare -A opts
	opts[vasya]='xsetroot -name Vasya'
	opts[petya]='xsetroot -name Petya'
	

	unset -v optstring
	for key in "${!opts[@]}"
	do
		optstring+="$key\n"
	done
	optstring+="Back"
	choice="$(echo -e $optstring | dmenu $params)"
	if [ "$choice" = "Back" ]
	then
		return 1
	fi
	${opts[$choice]}
}

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

main
