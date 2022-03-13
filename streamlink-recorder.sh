#!/usr/bin/env bash

twitch configure --client-id "$clientID" --client-secret "$clientSecret"

while [[ true ]]; do

  stream_status=$(twitch api get /streams -q "user_login=${streamName}" | jq '.data[0].type')

  if [[ "$stream_status" =~ "twitch token" ]]; then
    echo "Token missing, refreshing it.";
    twitch token
  fi

  echo "$streamName stream isn't live: $stream_status"
  if [[ "$stream_status" == "live" ]]; then
    echo "$streamName stream is: $stream_status"
    streamlink \
      --output "/home/download/{author}/{game}/${streamName}_{time:%Y-%m-%d_%H.%M.%S} {title}.mkv" \
      $streamOptions \
      "$streamLink" \
      "$streamQuality"
  fi
	sleep 60s
done
