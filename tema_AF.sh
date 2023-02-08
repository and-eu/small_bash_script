#!/bin/bash
#set -x

# Constants
pckg="zenity"
file=~/temp_file

# mainmenu window
mainmenu () {
option=$( zenity --list --title="Main Menu" \
--text "Choose a Chapter" \
--radiolist --height=400 --width=200 \
--hide-header --hide-column=2 \
--column "radio" --column "chapter" --column "response" \
FALSE 2 "Chapter 2" \
FALSE 3 "Chapter 3" \
FALSE 4 "Chapter 4" \
FALSE 5 "Chapter 5 (WIP)" \
FALSE 6 "Chapter 6 (WIP)" \
FALSE 7 "Chapter 7 (WIP)" \
FALSE 8 "Chapter 8 (WIP)" \
FALSE 9 "Chapter 9 (WIP)" \
FALSE 10 "Chapter 10 (WIP)" \
FALSE 11 "Chapter 11 (WIP)" \
FALSE 12 "Chapter 12 (WIP)" )

case $option in
2) chapter2;;
3) chapter3;;
4) chapter4;;
5) chapter5;;
6) chapter6;;
7) chapter7;;
8) chapter8;;
9) chapter9;;
10) chapter10;;
11) chapter11;;
12) chapter12;;
esac
}


chapter2 () {
option=$( zenity --list --title="Chapter 2" \
--text "Chapter 2" \
--radiolist --height=400 --width=200 \
--hide-header --hide-column=2 \
--column "radio" --column "number" --column "response" \
FALSE 1 "Shutdown" \
FALSE 2 "Packages" \
FALSE 3 "Go Back" )

case $option in
1) if zenity --question --text="Do you want to shutdown?" --default-cancel 
    then shutdown -h now
    else chapter2
    fi;;
2) chapter2_1;;
3) mainmenu;;
esac
}

chapter2_1 () {
option=$( zenity --list --title="Packages" \
--text "Packages" \
--radiolist --height=400 --width=200 \
--hide-header --hide-column=2 \
--column "radio" --column "number" --column "response" \
FALSE 1 "Update Packages info" \
FALSE 2 "Update Packages" \
FALSE 3 "Update System" \
FALSE 4 "Go Back" )

case $option in
1) echo "$passwd" | sudo -S apt-get update
    sleep 1
    chapter2_1;;
2) echo "$passwd" | sudo -S apt-get -y upgrade
	sleep 1
	chapter2_1;;
3) echo "$passwd" | sudo -S apt-get -y dist-upgrade
	sleep 1
	chapter2_1;;
4) chapter2;;
esac
}

chapter3 () {
option=$( zenity --list --title="Chapter 3" \
--text "Chapter 3" \
--radiolist --height=200 --width=300 \
--hide-header --hide-column=2 \
--column "radio" --column "number" --column "response" \
FALSE 1 "User Management" \
FALSE 2 "Package Management" \
FALSE 3 "Go Back" )

case $option in
1) chapter3_1;;
2) chapter3_2;;
3) mainmenu;;
esac
}

chapter3_1 () {
option=$( zenity --list --title="User Management" \
--text "User Management" \
--radiolist --height=300 --width=300 \
--hide-header --hide-column=2 \
--column "radio" --column "number" --column "response" \
FALSE 1 "Users Information" \
FALSE 2 "Add User" \
FALSE 3 "Del User" \
FALSE 4 "Add Group" \
FALSE 5 "Del Group" \
FALSE 6 "Change password" \
FALSE 7 "Go Back" )

case $option in
1) 	
    zenity --text-info --title="Users" --text "passwd file content:" --height=700 --width=800 --filename=/etc/passwd
    case $? in 
    0)
    ls -l /etc/shadow > ~/temp_file
    zenity --text-info --title="shadow" --text "shadow file location and permisions:" --height=200 --width=600 --filename=$file
        case $? in
        0) user=$(zenity --entry --title="User Info" --text="Insert user to know his info:" --entry-text "User")
        if [ -z "$user" ]
        then
            zenity --error --text="No user name inserted."
            chapter3_1
        fi
        echo "$user id is:" > ~/temp_file
        id "$user" >> ~/temp_file
        echo "-----------------------------------------------------" >> ~/temp_file
        echo "finger $user output is:" >> ~/temp_file
        finger "$user" >> ~/temp_file
        zenity --text-info --title="shadow" --text "shadow file location and permisions:" --height=400 --width=600 --filename=$file
        chapter3_1
        case $? in
        0) chapter3_1;;
        1) chapter3_1;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
        exit 1;;
        esac
        ;;
        1) chapter3_1;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
            exit 1;;
        esac 
    ;;
    1) chapter3_1;;
    -1) zenity --error --text="Divided by 0, the univers will explode."
        exit 1;;
    esac
    rm ~/temp_file
;;
2)
    zenity --info --text="The action will continue in terminal."
    echo "Insert user name:"
    read -r name
    sleep .5
    echo "adduser $name"
    sudo adduser "$name"
    chapter3_1
;;
3)
    user=$(zenity --entry --title="User Info" --text="Insert user name and click ok." )
    if [ -z "$user" ]
    then
        zenity --error --text="No user name inserted or you pressed Cancel. Click OK to continue."
        chapter3_1
    fi
    echo "User $user deleted:" > ~/temp_file
    echo "$passwd" | sudo -S deluser "$user" >> ~/temp_file
    zenity --text-info --title="User" --height=400 --width=600 --filename=$file
    case $? in
        0) chapter3_1;;
        1) chapter3_1;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
        exit 1;;
    esac
;;
4)
    grup=$(zenity --entry --title="Group" --text="Insert group name and click ok." )
    if [ -z "$grup" ]
    then
        zenity --error --text="No group name inserted or you pressed Cancel. Click OK to continue."
        chapter3_1
    fi
    echo "Group $grup added:" > ~/temp_file
    echo "$passwd" | sudo -S addgroup "$grup" >> ~/temp_file
    zenity --text-info --title="Group" --height=400 --width=600 --filename=$file
    case $? in
        0) chapter3_1;;
        1) chapter3_1;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
        exit 1;;
    esac
;;
5)
    grup=$(zenity --entry --title="Group" --text="Insert group name and click ok." )
    if [ -z "$grup" ]
    then
        zenity --error --text="No group name inserted or you pressed Cancel. Click OK to continue."
        chapter3_1
    fi
    echo "Group $grup deleted:" > ~/temp_file
    echo "$passwd" | sudo -S delgroup "$grup" >> ~/temp_file
    zenity --text-info --title="Group" --height=400 --width=600 --filename=$file
    case $? in
        0) chapter3_1;;
        1) chapter3_1;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
            exit 1;;
    esac
;;
6)
    echo "If you change the password of the curent user the script will not work properly.
The action will continue in terminal." > ~/temp_file
    zenity --text-info --title="Password" --height=200 --width=600 --filename=$file
    case $? in
        0)
            echo "Changing Password"
            echo "--------------------------------"
            sleep .5
            echo -ne "Insert user: "
            read -r user
            sleep .5
            echo "Type a password for user $user:"
            sudo passwd "$user"
            chapter3_1;;
        1) chapter3_1;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
            exit 1;;
    esac
;;
7) chapter3;;
esac
}

chapter3_2 () {
option=$( zenity --list --title="Package Management" \
--text "Package Management" \
--radiolist --height=300 --width=300 \
--hide-header --hide-column=2 \
--column "radio" --column "number" --column "response" \
FALSE 1 "List package content" \
FALSE 2 "Search package by pattern" \
FALSE 3 "Search package by included file" \
FALSE 4 "APT" \
FALSE 5 "Update alternatives" \
FALSE 6 "Go Back" )

case $option in
1)
    dpckg=$(zenity --entry --title="Package" --text="Insert package name to show it's content and click ok." )
    if [ -z "$dpckg" ]
    then
        zenity --error --text="No package name inserted or you pressed Cancel. Click OK to continue."
        chapter3_2
    fi
    echo "Package $dpckg content:" > ~/temp_file
    dpkg -L "$dpckg" >> ~/temp_file
    zenity --text-info --title="Package" --height=800 --width=800 --filename=$file
    case $? in
        0) chapter3_2;;
        1) chapter3_2;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
            exit 1;;
    esac
;;
2)
    dpckg=$(zenity --entry --title="Package" --text="Insert pattern for package search and click ok." )
    if [ -z "$dpckg" ]
    then
        zenity --error --text="No text inserted or you pressed Cancel. Click OK to continue."
        chapter3_2
    fi
    echo "Packages that mach $dpckg:" > ~/temp_file
    dpkg -l "$dpckg" >> ~/temp_file
    echo "In carte este gresit, dpkg -l nu foloseste regex si un simplu pattern"
    zenity --text-info --title="Package" --height=800 --width=800 --filename=$file
    case $? in
        0) chapter3_2;;
        1) chapter3_2;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
            exit 1;;
    esac
;;
3)
    dpckg=$(zenity --entry --title="Package" --text="Insert file for package search and click ok." )
    if [ -z "$dpckg" ]
    then
        zenity --error --text="No text inserted or you pressed Cancel. Click OK to continue."
        chapter3_2
    fi
    echo "Packages that that contain the file $dpckg:" > ~/temp_file
    dpkg -S "$dpckg" >> ~/temp_file
    zenity --text-info --title="Package" --height=800 --width=800 --filename=$file
    case $? in
        0) chapter3_2;;
        1) chapter3_2;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
            exit 1;;
    esac
;;
4) chapter3_2_4;;
5) chapter3_2_5;;
6) chapter3;;
esac
}

cmd_to_window () {
    foo=$(zenity --entry --title="Input" --text="$1" )
    if [ -z "$foo" ]
    then
        zenity --error --text="No text inserted or you pressed Cancel. Click OK to continue."
        $3
    fi
    {
    echo "$4"
    echo "Response for command $2 $foo:"
    echo "$passwd" | sudo -S $2 $foo
    } > ~/temp_file
    zenity --text-info --title="Response for command $2 $foo:" --height=800 --width=800 --filename=$file
    case $? in
        0) $3;;
        1) $3;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
            exit 1;;
    esac
}

send_cmd () {
    {
    echo $3
    echo "$passwd" | sudo -S $1 
    } > ~/temp_file
    zenity --text-info --title="Output of command $1 is:" --height=800 --width=800 --filename=$file
    case $? in
        0) $2;;
        1) $2;;
        -1) zenity --error --text="Divided by 0, the univers will explode."
            exit 1;;
    esac
}

chapter3_2_4 () {
option=$( zenity --list --title="APT" \
--text "APT" \
--radiolist --height=400 --width=500 \
--hide-header --hide-column=2 \
--column "radio" --column "number" --column "response" \
FALSE 1 "List sourches" \
FALSE 2 "Update packages list" \
FALSE 3 "Search for package in local list" \
FALSE 4 "Info about a package" \
FALSE 5 "Install Package" \
FALSE 6 "UnInstall Package" \
FALSE 7 "Cache clean" \
FALSE 8 "List of Packages in cache" \
FALSE 9 "List package's repositories" \
FALSE 10 "Update packages without installing/removing packages" \
FALSE 11 "Update packages with installing/removing packages" \
FALSE 12 "Go Back" )

case $option in
1) send_cmd 'cat /etc/apt/sources.list' chapter3_2_4  ;;
2) send_cmd 'apt-get update' chapter3_2_4  ;;
3) cmd_to_window 'Insert package name.' "apt-cache search" chapter3_2_4  ;;
4) cmd_to_window 'Insert package name.' "apt-cache show" chapter3_2_4  ;;
5) cmd_to_window 'Insert package name.' "apt-get install" chapter3_2_4  ;;
6) cmd_to_window 'Insert package name.' "apt-get remove --purge" chapter3_2_4  ;;
7) send_cmd 'apt-get clean' chapter3_2_4  ;;
8) send_cmd 'apt-cache dump' chapter3_2_4  ;;
9) cmd_to_window 'Insert package name.' "apt-cache policy" chapter3_2_4  ;;
10) send_cmd 'apt-get -y upgrade' chapter3_2_4  ;;
11) send_cmd 'apt-get -y dist-upgradee' chapter3_2_4  ;;
12) chapter3_2;;
esac
}

chapter3_2_5 () {
option=$( zenity --list --title="Update alternatives" --text "Update alternatives" \
--radiolist --height=400 --width=500 \
--hide-header --hide-column=2 \
--column "radio" --column "number" --column "response" \
FALSE 1 "List info about a group" \
FALSE 2 "List group targets" \
FALSE 3 "Interactive option change" \
FALSE 0 "Go Back" )

case $option in
1) cmd_to_window 'Insert command name.' 'update-alternatives --display' chapter3_2_5  ;;
2) cmd_to_window 'Insert command name.' 'update-alternatives --list' chapter3_2_5  ;;
3) cmd_to_window 'Insert command name.' 'update-alternatives --config' chapter3_2_5  ;;
0) chapter3_2;;
esac
}

chapter4 () {
option=$( zenity --list --title="Chapter 4" --text "Chapter 4" \
--radiolist --height=400 --width=500 \
--hide-header --hide-column=2 \
--column "radio" --column "number" --column "response" \
FALSE 1 "Print Working Direcotry" \
FALSE 2 "PATH" \
FALSE 3 "Symbolic Links" \
FALSE 4 "Check file's Type" \
FALSE 5 "cd (file explorer)" \
FALSE 6 "cat List file content" \
FALSE 7 "ls List folder content" \
FALSE 8 "Create New" \
FALSE 9 "File/folder management" \
FALSE 10 "Arhive" \
FALSE 11 "Interactive option change" \
FALSE 12 "Find" \
FALSE 13 "Locate" \
FALSE 14 "Whereis" \
FALSE 15 "Which" \
FALSE 16 "Type (command)" \
FALSE 17 "File's Type" \
FALSE 18 "Interactive option change" \
FALSE 0 "Go Back" )

case $option in
1) send_cmd "pwd" chapter4 "This command prints the working directory" ;;
2) send_cmd "$PATH" chapter4 "With this command, the list of common paths where executable programs are found is displayed (These programs can be executed without specifying the path to them)." ;;
3) zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment." ;;
4) cmd_to_window "Insert full path of the file you want to check." "file" chapter4 "This command prints the file type." ;;
5) file_explorer ;;
6) cmd_to_window "Insert full path of the file you want to read." "cat" chapter4 "This command prints the content of teh file." ;;
7) cmd_to_window "Insert full path of the folder." "ls -lah" chapter4  ;;
8|9|10|11|12|13|14|15|16|17|18) zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment." 
chapter4
;;
0) chapter3_2;;
esac
}

file_explorer () {
start_dir="/"
while true; do
  items=$(ls -1a "$start_dir" | awk -v start_dir="$start_dir" '
  BEGIN{FS="\n";}
  {if (system("test -L \"" start_dir "/" $1 "\"") == 0) printf $1 "\nLink\n"; 
  else if (system("test -d \"" start_dir "/" $1 "\"") == 0) printf $1 "\nDirectory\n";
  else printf $1 "\nFile\n";}')

  selected_item=$(echo "$items" | zenity --list \
    --title="File Explorer" \
    --text="Select a folder, file, or link:" \
    --column="Items" \
    --column="Type" \
    --width=600 \
    --height=900)

  if [ $? -ne 0 ]; then
    chapter4
  fi

  if [ "$selected_item" == ".." ]; then
    start_dir=$(dirname "$start_dir")
  elif [ -d "$start_dir/$selected_item" ]; then
    start_dir="$start_dir/$selected_item"
  fi
done
}

chapter6 () {
    zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment."
    mainmenu
}

chapter7 () {
    zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment."
    mainmenu
}

chapter8 () {
    zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment."
    mainmenu
}

chapter9 () {
    zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment."
    mainmenu
}

chapter10 () {
    zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment."
    mainmenu
}

chapter11 () {
    zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment."
    mainmenu
}

chapter12 () {
    zenity --info --text="Due to employee shortage and budget constrains, this feature is postponed for next product increment."
    mainmenu
}

pause (){
 read -r -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

# Helper spinner 
spinner() {
  local i sp n
  sp='/-\|'
  n=${#sp}
  printf ' '
  while sleep 0.1; do
    printf "\b${sp:i++%n:1}"
  done
}

# Start-----------------------------------------------------------------------------------------------------------------

# check if root
if [ $EUID -ne 0 ]
then
    if dpkg -s $pckg &>/dev/null
    then
    {
    echo "This script requires account password to run privileged commands (sudo)." 
    echo "If you don't agree press Cancel and run the script as root." 
    echo "To continue press OK."
    echo "© Floroiu Andrei Iulian 2023" 
    } > ~/temp_file
    zenity --text-info --title="Intro" --height=200 --width=800 --filename=$file
        case $? in
            1) exit 0;;
            -1) zenity --error --text="Divided by 0, the univers will explode."
                exit 1;;
        esac
    passwd=$( zenity --password --title="Login" --text "Write your password" )
        if [ -z "$passwd" ]
        then
            zenity --error --text="No text inserted or you pressed Cancel. Click OK to exit."
            exit 0
        fi
    else
    echo "You don't have super user writes."
    read -r -s -p "Write your acount password: " passwd
    echo
        if [ -z "$passwd" ]
        then
            echo " you didn't enter any text. Exiting."
            exit 0
        fi
    fi
fi

# check if zenity is installed
if dpkg -s $pckg &>/dev/null 
then
    echo "$pckg is installed, script will continue." &>/dev/null
else
    echo "This script needs zenity package to run."
    echo "Do you want to install it (Y/n):"
    read -r answare;
    case $answare in
        y) 
        echo "$passwd" | sudo -S apt-get update &>/dev/null;
        echo "Installing $pckg please be patient."
        spinner &
        pid=$!
        echo "$passwd" | sudo -S apt-get install -y $pckg &>/dev/null;
        kill $pid
        wait $pid 2>/dev/null
                
        if dpkg -s $pckg &>/dev/null
        then
            echo
            echo "Finished installing $pckg, script will continue."
        else
            echo
            echo "The install encountered an error."
            exit 1
        fi
        ;;
        n)
        echo "Exiting."
        exit 0;;
        *)
        echo "Wrong option."
        exit 1;;
    esac

fi

mainmenu

# Clean up
if [ -f "$file" ]
then
    rm $file
fi

#set +x