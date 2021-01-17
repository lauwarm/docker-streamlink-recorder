FROM python:3.9.0-buster
LABEL maintainer="lauwarm@mailbox.org"

ENV streamlinkVersion=2.0.0

ADD https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz /opt/
ADD https://raw.githubusercontent.com/back-to/streamlink/277d064051e9166f61df315ae04cc71011a61e98/src/streamlink/plugins/chaturbate.py /home/plugins/

RUN tar -xzf /opt/streamlink-${streamlinkVersion}.tar.gz -C /opt/ && \
	rm /opt/streamlink-${streamlinkVersion}.tar.gz && \
	cd /opt/streamlink-${streamlinkVersion}/ && \
	python setup.py install

RUN mkdir /home/download
RUN mkdir /home/script
COPY ./streamlink-recorder.sh /home/script/

CMD /bin/sh ./home/script/streamlink-recorder.sh ${streamOptions} ${streamLink} ${streamQuality} ${streamName}