#!/bin/bash

# For more information visit: https://github.com/downthecrop/TwitchVOD

#echo "Argument 1: $streamOptions"
#echo "Argument 2: $streamLink"
#echo "Argument 3: $streamQuality"
#echo "Argument 4: $streamName"

IFS=';' read -r -a args <<< "$streamOptions"

while [ true ]; do
	Date=$(date +%Y%m%d-%H%M%S)
	streamlink "${args[@]}" "$streamLink" "$streamQuality" -o /home/download/"$streamName"-"$Date".mkv
	sleep 60s
done
