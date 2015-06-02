#!/bin/bash

read PINGHOST < pingHost
EXPECTCOUNT=4;
WEMONAME="Ratio Wemo";

#Clear ouimeaux's cache of device names
wemo clear;

while true; do
        #Ping and count the instances of the word 'received'
        count=$(ping -c $EXPECTCOUNT $PINGHOST | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')

        if [ "$count" -ne "$EXPECTCOUNT" ] || [ "$count" = "" ]; then
                #failed
                echo "$(date) - Unable to reach $PINGHOST - rebooting..."

                wemo switch "$WEMONAME" off;

                WEMOSTAT=$(wemo -v switch "Ratio Wemo" status);

                if [ "$WEMOSTAT" == "off" ]
                then
                    echo "$(date) - WeMo Switch off, now waiting 5 seconds"

                    sleep 5

                    echo "$(date) - Turning back on..."

                    wemo switch "$WEMONAME" on;

                    WEMOSTAT=$(wemo -v switch "Ratio Wemo" status);

                    if [ "$WEMOSTAT" == "on" ]
                    then
                        echo "$(date) - Turned back on, waiting for the router to reboot..."

                        ##### TWEET AT VIRGIN #####
                        read OLDCRASHNO < crashNo

                        CRASHNO=$(($OLDCRASHNO+1))

                        echo $CRASHNO > crashNo

                        echo "$(date) - Tweeting at virgin for the $CRASHNO time..."

                        CRASHNO=$CRASHNO node tweeter

                        echo "Tweet sent";

                        ##### END TWEET #####
                    else
                        wemo clear;

                        echo "Failed to turn wemo back on, not tweeted or incremented crash number."
                    fi
                else
                    wemo clear;

                    echo "Failed to turn wemo off, connection to wemo failed?"
                fi

                sleep 180
        else
                #passed
                echo "$(date) - $PINGHOST reached"

                #Make sure the switch is on
                wemo switch "$WEMONAME" on
        fi

        sleep 1
done
