em-twitter-client
=================

It provides a simple api to access twitter rest api using event machine. This has provided us with really fast and efficient way of retriving twitter data.

The current api is based on pages of information and will retrieve 
It is based on em-http-request and event-machine.

There are some usage examples in the examples folder.

The current implementation blocks for each api call to finish. Ie. 5 pages of user_timeline is fetched asynchronously but it waits for the call to complete.

That's sort of what we needed, but the complete async api is coming soon as well. 

Will hopefully publish the gem then as well, when that is done. 