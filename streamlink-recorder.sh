#!/usr/bin/env bash

while [[ true ]]; do

  echo "Starting streamlink streamOptions $streamOptions streamLink: $streamLink streamQuality: $streamQuality"
  streamlink --output "/home/download/{author}/{game}/{time:%Y-%m-%d_%H.%M.%S} {title}.mkv" "$streamOptions" "$streamLink" "$streamQuality"
	sleep 60s
done
