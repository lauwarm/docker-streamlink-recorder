#!/bin/bash 

# For more information visit: https://github.com/downthecrop/TwitchVOD

while [ true ]; do
	Date=$(date +%F-%H%M%S)
	streamlink $streamOptions $streamLink $streamQuality -o /home/download/$streamName"-$Date".mkv
	sleep 60s
done