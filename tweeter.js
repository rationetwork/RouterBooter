/**
 * Created by ChrisCheshire on 20/02/15.
 */

'use strict';

var Twitter = require('twitter'),
	twitConfig = require('./twitConfig');

var client = new Twitter(twitConfig);

if(!process.env.CRASHNO)
	process.exit(1);

var message = "Hi @vmbusinesshelp I just had to restart @rationetwork's @vmbusiness modem. This has happened " + process.env.CRASHNO + " times since 15:00 20/02/2015 :-|";

client.post('statuses/update', {status: message},  function(error, tweet, response){
	if(error) return console.error(error);

	//console.log("Tweet successful");
	//console.log(tweet);  // Tweet body.
	//console.log(response);  // Raw response object.
});
