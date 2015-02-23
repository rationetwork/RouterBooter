#RouterBooter
Primarily designed to reboot Ratio's Virgin Media Business router when it crashes.

Ratio's RouterBooter will periodically ping an IP address. If a response is not received, it will reboot your router via a [Belkin Wemo](http://www.belkin.com/uk/F7C027-Belkin/p/P-F7C027;jsessionid=43F97DD73C01AB575FC3A0C0EEFCBC3C/) into which your Virgin router is plugged. The script then waits for a predetermined amount of time before continuing its checks.

##Installation
Requires [NodeJS](http://nodejs.org/) for the tweeter script. If the tweeter is not required, comment out this line: `CRASHNO=$CRASHNO node tweeter` in `routerBooter.sh`, by adding a hash to the beginning.

Requires [Ouimeaux](http://ouimeaux.readthedocs.org/en/latest/installation.html) to control the Belkin Wemo.

Copy `twitConfig.example.js` to `twitConfig.js` and add your [twitter access keys](https://twittercommunity.com/t/how-to-get-my-api-key/7033)

Copy `pingHost.example` to `pingHost` and replace the contents with your own IP address

Once Ouimeaux and NodeJS are installed, run `npm install` in the root directory to install the twitter module for Node.

Works best on a linux machine (or a [Raspberry Pi](http://www.raspberrypi.org/help/what-is-a-raspberry-pi/), which is what we are using).

**Note:** We have a second internet connection, to which we failover when Virgin goes down. This is the connection that the tweeter uses to tweet. If you don't have an active connection at the time the tweet is attempted, the tweet will fail, but the script will continue to run.

_All of the following commands assume you have a terminal window open at the root directory of this project._

###To run routerBooter in the foreground
`./routerBooter.sh`

###To run routerBooter in the background
`./startRouterBooter.sh`

This will log all output to `routerBooter.log`

##### Viewing output of routerBooter running in the background
`tail -f routerBooter.log`

##Managing background process
###To view routerBooter processes running in the background
`ps aux | grep "routerBooter"`

###To kill a routerBooter
If for whatever reason you need to restart routerBooter running in the background, you can kill the processes via the PID visible after running the above command. The second number shown in each column is the PID.

e.g. `kill -9 1234`