#!/usr/bin/env python
# Author: Bill Reed Dec 2014
#=================================================================
# >>> FRINGE-BOSS INSTALLATION <<<
#     User has local administrative privileges
#     Files:  fringe.py fringe.p12 bossy.py
# >>NOTE<<: 
#   BE SURE TO SET THE FOLLOWING VARIABLES:
#   -fringeApp > Python command with full path to fringe.py
#   -fringeKey > Full path to certificate, fringe.p12
#   -textEditor > Full path to a text editor 
#       (i.e. notepad.exe, wordpad.exe, nano, vi, etc.)
# Running the application:
#   Start > Run > cmd > cd c:\path\to\fringe
#   type: python bossy.py
#=================================================================
import os
import sys
import time
xSpacer = '#======================================================#'
xAppName = '# >>>>>>>>>>>>>>>>>>> Fringe <<<<<<<<<<<<<<<<<<<<<<<<< #'
fringeApp = 'python /Volumes/Krulka/PWC/fringe/fringe.py'
fringeKey = '/Volumes/Krulka/PWC/fringe/fringe.p12'
textEditor = 'nano'
os.system('clear')
#=================================================================
# Menu
#=================================================================
ans=True
while ans:
    os.system('clear')
    print (xSpacer)
    print (xAppName)
    print (xSpacer)
    print ("""
Authorization
    1. Authorize (3LO oauth 2.0)

Groups Policy Enforcement Commands
    2. Get All Groups
    3. Review all_groups.csv file
    4. Update Groups Settings

Search and Delete / Welcome Message Removal Commands
    5. Get All Users
    6. Review all_users.csv file
    7. Search Users Messages
    8. Review all_messages.csv file
    9. Get Users Messages Info
    10.Review messages_details.csv file
    11.Delete Messages

    x. Exit/Quit
    """)
    ans=raw_input('Enter your choice [1-11 or x]:')
#=================================================================
# Authorization 
#=================================================================
    if ans=="1":
      authAnswer=raw_input('Enter your email address:')
      print '\n Hi there, '+authAnswer
      print '\n Your default browser will automatically open.'
      print '\n Please login and click Accept.';time.sleep(.5)
      authCmd = fringeApp+' oauth --oauth=client-file --prn='+authAnswer
      os.system(authCmd)
#=================================================================
# Get All Groups
#=================================================================
    elif ans=="2":
      gagCmd = fringeApp+' fringe admin.directory_v1 groups list --prn='+authAnswer+' --customer=my_customer --fields="groups(email)" --output_change_fields="email,groupUniqueId" --output_include_fields="email" --output_filename=all_groups.csv'
      os.system(gagCmd)
#=================================================================
# Open all_groups.csv in text editor
#=================================================================
    elif ans=="3":
      ragCmd = textEditor+' all_groups.csv'
      os.system(ragCmd)
#=================================================================
# Update Groups Settings
#=================================================================
    elif ans=="4":
      upgsCmd = fringeApp+' fringe groupssettings.v1 groups patch --prn='+authAnswer+" --file=all_groups.csv --body="+"{isArchived:'false'}"+" --connections=10"
      os.system(upgsCmd)
#=================================================================
# Get All Users
#=================================================================
    elif ans=="5":
      print("\n Getting all users. This could take a while...");time.sleep(.5)
      gauCmd = fringeApp+' fringe admin.directory_v1 users list --customer=my_customer --fields="users(primaryEmail,id)" --prn='+authAnswer+' --output_filename=all_users.csv --output_change_fields="id,userKey;primaryEmail,prn;" --output_include_fields="id;primaryEmail"'
      os.system(gauCmd)
#=================================================================
# Read all_users.csv in text editor
#=================================================================
    elif ans=="6":
      rauCmd = textEditor+' all_users.csv'
      os.system(rauCmd)
#=================================================================
# Search Users Messages
#=================================================================
    elif ans=="7":
      gQuery=raw_input('Enter a search string (i.e. Gmail Team ):')
      sumCmd = fringeApp+' fringe gmail.v1 users.messages list --userId=me --fields="messages(id)"'+' --output_include_fields="prn;id"'+' --output_filename=all_messages.csv --oauth=service --file=all_users.csv --q="'+gQuery+'"'
      os.system(sumCmd)
#=================================================================
# Read all_messages.csv in text editor
#=================================================================
    elif ans=="8":
      ramCmd = textEditor+' all_messages.csv'
      os.system(ramCmd)
#=================================================================
# Get Users Messages Information
#=================================================================
    elif ans=="9":
      gumiCmd = fringeApp+' fringe gmail.v1 users.messages get --oauth=service --oauth_key='+fringeKey+' --file=all_messages.csv --format=metadata --fields="messages(payload(headers),snippet)" --output_include_fields="id;snippet;Date-1;Subject-1;From-1;To-1;prn" --output_change_fields="Date-1,Date;Subject-1,Subject;From-1,From;To-1,To" --connections=10 --output_file=messages_details.csv --userId=me'
      os.system(gumiCmd)
#=================================================================
# Read messages_details.csv in text editor
#=================================================================
    elif ans=="10":
      rmdCmd = textEditor+' messages_details.csv'
      os.system(rmdCmd)
#=================================================================
# Delete Messages
#=================================================================
    elif ans=="11":
      delmsgsCmd = fringeApp+' fringe gmail.v1 users.messages delete --oauth=service --oauth_key='+fringeKey+' --file=all_messages.csv --userId=me --connections=10'
      os.system(delmsgsCmd)
#=================================================================
# Exit the menu
#=================================================================
    elif ans=="x":
      print('\n Goodbye');time.sleep(.5);os.system('clear')
      ans = None
    else:
       print('\n Not Valid Choice Try again');time.sleep(2)
