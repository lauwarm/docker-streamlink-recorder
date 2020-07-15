FROM python:3.8.1-buster
MAINTAINER lauwarm <lauwarm@mailbox.org>

ENV streamlinkVersion=1.3.1

ADD https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz /opt/
ADD https://raw.githubusercontent.com/back-to/streamlink/277d064051e9166f61df315ae04cc71011a61e98/src/streamlink/plugins/chaturbate.py /home/plugins/

RUN tar -xzf /opt/streamlink-${streamlinkVersion}.tar.gz -C /opt/ && \
	rm /opt/streamlink-${streamlinkVersion}.tar.gz && \
	cd /opt/streamlink-${streamlinkVersion}/ && \
	python setup.py install

RUN mkdir /home/download
COPY ./streamlink-recorder.sh /home/

CMD /bin/sh ./home/streamlink-recorder.sh ${streamOptions} ${streamLink} ${streamQuality} ${streamName}