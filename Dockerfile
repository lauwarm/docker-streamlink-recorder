FROM python:3.9.14-slim-bullseye
LABEL maintainer="Adriel"

ENV streamlinkVersion=5.0.1
ENV twitchVersion=1.1.8

# Streamlink
ADD "https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz" /opt/
RUN apt-get update && apt-get -y install gosu jq
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
RUN mkdir -p "/.config/twitch-cli"
RUN chown 1000:1000 "/.config/twitch-cli"

RUN mkdir /home/download
RUN mkdir /home/script
RUN mkdir /home/plugins

COPY ./streamlink-recorder.sh /home/script/
COPY ./entrypoint.sh /home/script

RUN ["chmod", "+x", "/home/script/entrypoint.sh"]

ENTRYPOINT [ "/home/script/entrypoint.sh" ]

CMD /bin/bash /home/script/streamlink-recorder.sh "$streamOptions" "$streamLink" "$streamQuality" "$streamName"
