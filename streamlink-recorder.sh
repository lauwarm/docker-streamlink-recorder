#!/usr/bin/env bash

echo "Saving config file."
twitch configure --client-id "$clientID" --client-secret "$clientSecret"

echo "Waiting for stream to go live."
while [[ true ]]; do

  stream_status=$(twitch api get /streams -q "user_login=${streamName}" 2>&1)
  echo "before token if, stream_status: $stream_status"
  if [[ "$stream_status" =~ "twitch token" || "$stream_status" =~  "Invalid OAuth token" ]]; then
    echo "Token missing, refreshing it.";
    twitch token
    # Try again, now that we have the token, it should work.
    stream_status=$(twitch api get /streams -q "user_login=${streamName}" 2>&1)
  fi

  echo "before jq error? stream_status: $stream_status"
  stream_status=$(echo "$stream_status" | jq --raw-output '.data[0].type')
  echo "after, jq error? stream_status: $stream_status"
  if [[ "$stream_status" == "live" ]]; then
    echo "$streamName stream is: $stream_status"
    streamlink \
      --output "/home/download/{author}/{game}/${streamName}_{time:%Y-%m-%d_%H.%M.%S} {title}.mkv" \
      $streamOptions \
      "$streamLink" \
      "$streamQuality"
  # else
  #   echo "$streamName stream isn't live: $stream_status"
  fi
	sleep 60s
done
