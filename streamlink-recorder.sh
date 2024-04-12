#!/bin/sh

# For more information visit: https://github.com/downthecrop/TwitchVOD

IFS=';' read -r -a args <<< $streamOptions

while [ true ]; do
	Date=$(date +%Y%m%d-%H%M%S)
	streamlink ${args[@]} $streamLink $streamQuality -o /home/download/$streamName"-$Date".mkv
	sleep 60s
done
