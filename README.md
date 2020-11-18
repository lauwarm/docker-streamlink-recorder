# docker-streamlink-recorder
Automated Dockerfile to record livestreams with streamlink

## Description
This is a Docker Container to record a livestream. It uses the official [Python Image](https://hub.docker.com/_/python) with the Tag *buster*  , installs [streamlink](https://github.com/streamlink/streamlink) and uses the Script [streamlink-recorder.sh](https://raw.githubusercontent.com/lauwarm/docker-streamlink-recorder/python3.8.1_buster_1.3.1/streamlink-recorder.sh) to periodically check if the stream is live.

## Usage
To run the Container:
```bash
$ docker run -v /path/to/vod/folder/:/home/download -e streamLink='' -e streamQuality='' -e streamName='' -e streamOptions='' lauwarm/streamlink-recorder
```

Example:
```bash
$ docker run -v /home/:/home/download -e streamLink='twitch.tv/twitch' -e streamQuality='best' -e streamName='twitch' -e streamOptions='--twitch-disable-hosting' lauwarm/streamlink-recorder
```

## Notes

`/home/download` - the place where the vods will be saved. Mount it to a desired place with `-v` option.

`streamLink` - the url of the stream you want to record.

`streamQuality` - quality options (best, high, medium, low).

`streamName` - name for the stream.

`streamOptions` - streamlink flags (--twitch-disable-hosting, separated by space)

The File will be saved as `streamName-YearMonthDayHourMinuteSecond.mkv`
