#!/usr/bin/env bash

while [[ true ]]; do
  streamlink --output "/home/download/{author}/{game}/${streamName}_{time:%Y-%m-%d_%H.%M.%S} {title}.mkv" $streamOptions "$streamLink" "$streamQuality"
	sleep 60s
done
