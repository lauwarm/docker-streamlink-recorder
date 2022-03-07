#!/usr/bin/env bash

while [[ true ]]; do
  trap "echo Exited!; exit;" SIGINT SIGTERM # allow you to ctl+c while inside a whileloop
  streamlink --output "/home/download/{author}/{game}/{time:%Y-%m-%d_%H.%M.%S} {title}.mkv" "$streamOptions" "$streamLink" "$streamQuality"
	sleep 60s
done
