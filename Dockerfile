FROM python:3.9.12-bullseye
LABEL maintainer="lauwarm@mailbox.org"

#ENV streamlinkVersion=4.0.0
ENV streamlinkCommit=4fd6ad885b9f3aca5ee40b4fca42340d5a3191ff
ENV PATH "${HOME}/.local/bin:${PATH}"

#ADD https://github.com/streamlink/streamlink/archive/refs/tags/${streamlinkVersion}.tar.gz /opt/
#ADD https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz /opt/

RUN apt-get update && apt-get install gosu && apt-get install python3-pip -y

RUN pip3 install --upgrade git+https://github.com/streamlink/streamlink.git@${streamlinkCommit}

RUN  echo 'export PATH="${HOME}/.local/bin:${PATH}"'

#RUN tar -xzf /opt/${streamlinkVersion}.tar.gz -C /opt/ && \
#	rm /opt/${streamlinkVersion}.tar.gz && \
#	cd /opt/streamlink-${streamlinkVersion}/ && \
#	python setup.py install

RUN mkdir /home/download
RUN mkdir /home/script
RUN mkdir /home/plugins

COPY ./streamlink-recorder.sh /home/script/
COPY ./entrypoint.sh /home/script

RUN ["chmod", "+x", "/home/script/entrypoint.sh"]

ENTRYPOINT [ "/home/script/entrypoint.sh" ]

CMD /bin/sh ./home/script/streamlink-recorder.sh ${streamOptions} ${streamLink} ${streamQuality} ${streamName}
