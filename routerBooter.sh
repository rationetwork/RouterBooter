#!/bin/bash

read PINGHOST < pingHost
EXPECTCOUNT=4;
WEMONAME="Ratio Wemo";

#Clear ouimeaux's cache of device names
wemo clear;

while true; do
        #Ping and count the instances of the word 'received'
        count=$(ping -c $EXPECTCOUNT $PINGHOST | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')

        if [ $count -eq 0 ]; then
                #failed
                echo "$(date) - Unable to reach $PINGHOST - rebooting..."

                wemo switch "$WEMONAME" off

                echo "$(date) - WeMo Switch off, now waiting 5 seconds"

                sleep 5

                echo "$(date) - Turning back on..."

                wemo switch "$WEMONAME" on

                echo "$(date) - Turned back on, waiting for the router to reboot..."

                ##### TWEET AT VIRGIN #####
                read OLDCRASHNO < crashNo

                CRASHNO=$(($OLDCRASHNO+1))

                echo $CRASHNO > crashNo

                echo "$(date) - Tweeting at virgin for the $CRASHNO time..."

                CRASHNO=$CRASHNO node tweeter

                ##### END TWEET #####

                sleep 180
        else
                #passed
                echo "$(date) - $PINGHOST reached"

                #Make sure the switch is on
                wemo switch "$WEMONAME" on
        fi

        sleep 5
done
