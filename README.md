# docker-streamlink-recorder
Automated Dockerfile to record livestreams with streamlink

## Description
This is a Docker Container to record a livestream. It uses [Python 3] (https://www.python.org/) [Alpine] (https://alpinelinux.org/) , installs [streamlink] (https://github.com/streamlink/streamlink) and adds a [Python Script] (https://gist.githubusercontent.com/lauwarm/5cae7bd36e4f3079a420618c9585e644/raw/44d635338a9cbe5c3c32d6be44d357a205641ee2/streamlink-recorder.py) to periodically check if the stream is live.

## Usage
To run the Container:
```bash
$ docker run -v /path/to/vod/folder/:/download -e streamLink='' -e streamQuality='' -e streamName='' lauwarm/streamlink-recorder
```

Example:
```bash
$ docker run -v /home/:/download -e streamLink='twitch.tv/twitch' -e streamQuality='best' -e streamName='twitch' lauwarm/streamlink-recorder
```

## Notes

`/download` - the place where the vods will be saved. Mount it to a desired place with `-v` option.

`streamLink` - the url of the stream you want to record.

`streamQuality` - quality options (best, high, medium, low).

`streamName` - name for the stream.

The File will be saved as `streamName-YearMonthDayHourMinuteSecond.mkv`
