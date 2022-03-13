FROM python:3.9.10-slim-bullseye
LABEL maintainer="Adriel"

ENV streamlinkVersion=3.2.0
ENV twitchVersion=1.1.5

# Streamlink
ADD "https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz" /opt/
RUN apt-get update && apt-get install gosu
RUN tar -xzf "/opt/streamlink-${streamlinkVersion}.tar.gz" -C /opt/ && \
	rm "/opt/streamlink-${streamlinkVersion}.tar.gz" && \
	cd "/opt/streamlink-${streamlinkVersion}/" && \
	python setup.py install && \
  rm -r "/opt/streamlink-${streamlinkVersion}/"

# Twitch CLI
ADD "https://github.com/twitchdev/twitch-cli/releases/download/v${twitchVersion}/twitch-cli_${twitchVersion}_Linux_x86_64.tar.gz" /opt/

RUN mkdir "/opt/twitch" && \
  tar -xzf "/opt/twitch-cli_${twitchVersion}_Linux_x86_64.tar.gz" -C /opt/twitch && \
	rm "/opt/twitch-cli_${twitchVersion}_Linux_x86_64.tar.gz" && \
	cd "/opt/twitch/" && \
	mv "/opt/twitch/twitch" "/usr/local/bin/" && \
  rm -r "/opt/twitch/"

RUN mkdir /home/download
RUN mkdir /home/script
RUN mkdir /home/plugins

COPY ./streamlink-recorder.sh /home/script/
COPY ./entrypoint.sh /home/script

RUN ["chmod", "+x", "/home/script/entrypoint.sh"]

ENTRYPOINT [ "/home/script/entrypoint.sh" ]

CMD /bin/bash /home/script/streamlink-recorder.sh "$streamOptions" "$streamLink" "$streamQuality" "$streamName"
