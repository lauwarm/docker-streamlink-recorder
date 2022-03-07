#!/usr/bin/env bash

while [[ true ]]; do

  echo "streamlink --output \"/home/download/{author}/{game}/{time:%Y-%m-%d_%H.%M.%S} {title}.mkv\" \"$streamOptions\" \"$streamLink\" \"$streamQuality\""
  streamlink --output "/home/download/{author}/{game}/{time:%Y-%m-%d_%H.%M.%S} {title}.mkv" "$streamOptions" "$streamLink" "$streamQuality"
	sleep 60s
done
