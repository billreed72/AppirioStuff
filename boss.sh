#!/bin/bash
# Author: Bill Reed Nov 2014
#=============================================================================
# >>> FRINGE-BOSS INSTALLATION <<<
#
#  [Environment]
#     Mac OS X Yosemite; Version 10.10.1 (14B25)
#     Python 2.7.6
#     GNU bash, version 3.2.53(1)-release (x86_64-apple-darwin14)
#     User has local administrative privileges
#     Folder: /Volumes/Krulka/PWC/fringe/
#     Files:  fringe.py fringe.p12 boss.sh
#
#   [Make Boss executable]
#     chmod +x /Volumes/Krulka/PWC/fringe/boss.sh
#       It will now run with dot-slash. i.e. "./boss.sh"
#       Adding an alias to /Users/billreed/.bash_profile like:
#         alias boss='bash /Volumes/Krulka/PWC/fringe/boss.sh'
#         would let you execute boss.sh from any folder by
#         typing "boss" at the terminal prompt.
#
#       >>NOTE<<: 
#                 BE SURE TO SET THE FOLLOWING VARIABLES:
#                 -fringeApp > Python command with full path to fringe.py
#                 -fringeKey > Full path to certificate, fringe.p12
#
#   [Install Dependencies]
#     For Mac:  sudo port install cowsay figlet toilet python-setuptools 
#               sudo easy_install --upgrade google-api-python-client
#=================================================================
# VARIABLES: MODIFY VARIABLES AS NEEDED
#=================================================================
dt=$(date '+%F_%H%M%S')
appBanner="Fringe"
fringeApp="python /Volumes/Krulka/PWC/fringe/fringe.py"
fringeKey="/Volumes/Krulka/PWC/fringe/fringe.p12" # not currently in use
#=================================================================
# MAIN Menu
#=================================================================
function mainMenu {
  mainAnswer=""
  while [ "$mainAnswer" != "x" ];do
    tput clear;tput sgr0;tput cup 40;appName
    tput cup 5 17;tput setab 7;tput setaf 1;echo 'Main Menu';tput sgr0
    tput cup 7 17;echo '1. Authorize'
    tput cup 8 17;echo '2. Groups Policy Enforcement'
    tput cup 9 17;echo '3. Search and Delete / Welcome Message Removal'
    tput cup 10 17;echo 'x. Exit'
    tput cup 11 17;tput bold;read -p "Enter your choice [1-2 or x]:" mainAnswer; tput sgr0
    tput clear
      if [ "$mainAnswer" = "1" ]; then authMenu
      elif [ "$mainAnswer" = "2" ]; then gpeMenu
      elif [ "$mainAnswer" = "3" ]; then sadMenu
      elif [ "$mainAnswer" = "x" ]; then tput sgr0;exitFringe5
      elif [ "$mainAnswer" = "X" ]; then tput sgr0;exitFringe5
      fi
    tput sgr0
  done }
#=================================================================
# Authorization Menu
#=================================================================
function authMenu {
  authAnswer=""
  while [ "$authAnswer" != "x" ];do
    tput clear;tput sgr0;tput cup 40;appName
    tput cup 5 17;tput rev;echo 'Authorization Commands';tput sgr0
    tput cup 7 17;echo '1. 3LO oauth 2.0'
    tput cup 8 17;echo '2. Reserved'
    tput cup 9 17;echo 'x. Main Menu'
    tput bold;tput cup 10 17;read -p "Enter your choice [1-2 or x]:" authAnswer
      if [ "$authAnswer" = "1" ]; then 3loauth2
      elif [ "$authAnswer" = "2" ]; then cowsay "These aren't the droids you're looking for...";sleep 2
      elif [ "$authAnswer" = "x" ]; then mainMenu
      fi
    tput sgr0
  done }
#=================================================================
# Groups Policy Enforcement Menu
#=================================================================
function gpeMenu {
  gpeAnswer=""
  while [ "$gpeAnswer" != "x" ];do
    tput clear;tput sgr0;tput cup 40;appName
    tput cup 5 17;tput rev;echo 'Groups Policy Enforcement Commands';tput sgr0
    tput cup 7 17;echo '1. Get All Groups'
    tput cup 8 17;echo '2. Review all_groups.csv file.'
    tput cup 9 17;echo '3. Update Groups Settings'
    tput cup 10 17;echo 'x. Main Menu'
    tput bold;tput cup 11 17;read -p "Enter your choice [1-3 or x]:" gpeAnswer
      if [ "$gpeAnswer" = "1" ]; then cowsay "Hang on while I get all your Groups... This shouldn't take too long...";sleep 1;getAllGroups
      elif [ "$gpeAnswer" = "2" ]; then nano all_groups.csv
      elif [ "$gpeAnswer" = "3" ]; then cowsay "Hang on while I update all your Group's settings... This might take a while...";sleep 1;updateGroupsSettings
      elif [ "$gpeAnswer" = "x" ]; then mainMenu
      elif [ "$gpeAnswer" = "X" ]; then mainMenu
      fi
    tput sgr0
  done }
#=================================================================
# SAD Welcome Msg Removal Menu
#=================================================================
function sadMenu {
  sadAnswer=""
  while [ "$sadAnswer" != "x" ];do
    tput clear;tput sgr0;tput cup 40;appName
    tput cup 5 17;tput rev;echo 'Search and Delete / Welcome Message Removal Commands';tput sgr0
    tput cup 7 17;echo '1. Get All Users'
    tput cup 8 17;echo '2. Review all_users.csv file.'
    tput cup 9 17;echo '3. Search Users Messages'
    tput cup 10 17;echo '4. Review all_messages.csv file.'
    tput cup 11 17;echo '5. Get Users Messages Info'
    tput cup 12 17;echo "6. Review messages_details.csv file."
    tput cup 13 17;echo '7. Delete Messages'
    tput cup 14 17;echo 'x. Main Menu'
    tput bold;tput cup 15 17;read -p "Enter your choice [1-4 or x]:" sadAnswer
      if [ "$sadAnswer" = "1" ]; then cowsay 'Hang on while I get all those users... This may take a while...';sleep 1;getAllUsers
      elif [ "$sadAnswer" = "2" ]; then nano all_users.csv
      elif [ "$sadAnswer" = "3" ]; then cowsay 'Hang on while I searching messages... This may take a while...';sleep 1;searchMessages
      elif [ "$sadAnswer" = "4" ]; then nano all_messages.csv
      elif [ "$sadAnswer" = "5" ]; then cowsay "Hang on while I get the users' message information... This may take a while...";sleep 1;getUsersMessagesInfo
      elif [ "$sadAnswer" = "6" ]; then nano messages_details.csv
      elif [ "$sadAnswer" = "7" ]; then cowsay 'Hang on while I delete meessages... This may take a while...';sleep 1;deleteMessages
      elif [ "$sadAnswer" = "x" ]; then mainMenu
      elif [ "$sadAnswer" = "X" ]; then mainMenu
      fi
    tput sgr0
  done }
#=================================================================
# Application Name FUNCTIONS
#=================================================================
function appName {
  toilet -f block -F metal:border $appBanner -t;tput sgr0
  }
function appNameX {
  echo $appBanner;tput sgr0
  }
#=================================================================
# Authorization FUNCTIONS
#=================================================================
function 3loauth2 {
  tput cup 12 8;echo "===================================================================================="
  tput cup 13 8;echo "#            >>>>>>>>>>>>>>> Credential Setup <<<<<<<<<<<<<<<<<<<<                 #"
  tput cup 14 8;echo "#==================================================================================#"
  tput cup 15 8;echo "# 1. To skip reauthorization browse to the Goolge Developer Console:               #"
  tput cup 16 8;echo "#    https://console.developers.google.com; [Project] > APIs & Auth > Credentials  #"
  tput cup 17 8;echo "#                                                                                  #"
  tput cup 18 8;echo "# 2. If you haven't done so already, Download the p12 certificate file.            #"
  tput cup 18 8;echo "#    Save the file as fringe.p12 in the same directory where fringe.py is located  #"
  tput cup 20 8;echo "#                                                                                  #"
  tput cup 21 8;echo "#   NOTE: The certificate file will authorize this application against your        #"
  tput cup 22 8;echo "#         Google Apps instance for life of the certificate                         #"
  tput cup 23 8;echo "===================================================================================="
  tput cup 24 8;read -p "Enter your email address: " gAppsFringeUser
  tput cup 25 8;cowsay "Hi $gAppsFringeUser, I'm going to open your default browser. Please login, then click Accept.";$fringeApp oauth --oauth=client-file --prn=$gAppsFringeUser;countdown "00:00:05" 'This message will be displaed for'
  }
#=================================================================
# Groups Policy Enforcement FUNCTIONS
#=================================================================
function getAllGroups {
  $fringeApp fringe admin.directory_v1 groups list --prn=$gAppsFringeUser --customer=my_customer --fields="groups(email)" --output_change_fields="email,groupUniqueId" --output_include_fields="email" --output_filename=all_groups.csv;countdown "00:00:05" 'This message will be displaed for'
  }
#=================================================================
function updateGroupsSettings {
  $fringeApp fringe groupssettings.v1 groups patch --prn=$gAppsFringeUser --file=all_groups.csv --body="{isArchived:'false'}" --connections=10
  }
#=================================================================
# SAD Welcome Msg Removal FUNCTIONS
#=================================================================
function getAllUsers {
  $fringeApp fringe admin.directory_v1 users list --customer=my_customer --fields="users(primaryEmail,id)" --prn=$gAppsFringeUser --output_filename=all_users.csv --output_change_fields="id,userKey;primaryEmail,prn;" --output_include_fields="id;primaryEmail"
  }
#=================================================================
function searchMessages {
  gQuery=""
  tput cup 25;read -p "Enter a search string (i.e. Gmail Team):" gQuery;tput sgr0
  $fringeApp fringe gmail.v1 users.messages list --userId=me --fields="messages(id)" --output_include_fields="prn;id" --output_filename=all_messages.csv --oauth=service --file=all_users.csv --q="$gQuery"
  }
#=================================================================
function getUsersMessagesInfo {
  $fringeApp fringe gmail.v1 users.messages get --oauth=service --oauth_key=$fringeKey --file=all_messages.csv --format=metadata --fields="messages(payload(headers),snippet)" --output_include_fields="id;snippet;Date-1;Subject-1;From-1;To-1;prn" --output_change_fields="Date-1,Date;Subject-1,Subject;From-1,From;To-1,To" --connections=10 --output_file=messages_details.csv --userId=me
  } 
#=================================================================
function deleteMessages {
  $fringeApp fringe gmail.v1 users.messages delete --oauth=service --oauth_key=$fringeKey --file=all_messages.csv --userId=me --connections=10
  }
#=================================================================
# Countdown Timer
#=================================================================
function countdown {
  local OLD_IFS="${IFS}"
  IFS=":"
  local ARR=( $1 ) ; shift
  IFS="${OLD_IFS}"
  local PREFIX="$*" ; [ -n "${PREFIX}" ] && PREFIX="${PREFIX} > "
  local SECONDS=$((  (ARR[0] * 60 * 60) + (ARR[1] * 60) + ARR[2]  ))
  local START=$(date +%s)
  local END=$((START + SECONDS))
  local CUR=$START
  while [[ $CUR -lt $END ]]
  do
    CUR=$(date +%s)
    LEFT=$((END-CUR))
    printf "\r%s%02d:%02d:%02d" \
      "${PREFIX}" $((LEFT/3600)) $(( (LEFT/60)%60)) $((LEFT%60))
    sleep 1
  done
  echo "        "
  }
#=================================================================
function exitFringe5 {
  toilet -f mono12 -F metal:border -t "Game Over";sleep .5;tput sgr0;sleep .5;clear;break
}
#=================================================================
mainMenu
