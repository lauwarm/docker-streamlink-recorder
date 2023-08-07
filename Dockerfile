FROM python:3.12.0a4-bullseye
LABEL maintainer="lauwarm@mailbox.org"

#ENV streamlinkCommit=1ead72dd1e50afb90a141cc65c0bdbe143fe6f50
ENV streamlinkVersion=6.0.1
ENV PATH "${HOME}/.local/bin:${PATH}"

ADD https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz /opt/

RUN apt-get update && apt-get install gosu

RUN pip3 install versioningit

RUN tar -xzf /opt/streamlink-${streamlinkVersion}.tar.gz -C /opt/ && \
	rm /opt/streamlink-${streamlinkVersion}.tar.gz && \
	cd /opt/streamlink-${streamlinkVersion}/ && \
	python3 setup.py install

#RUN apt-get update && apt-get install gosu && apt-get install python3-pip -y

#RUN pip3 install --user -U --upgrade git+https://github.com/streamlink/streamlink.git@${streamlinkCommit}

RUN  echo 'export PATH="${HOME}/.local/bin:${PATH}"'

RUN mkdir /home/download
RUN mkdir /home/script
RUN mkdir /home/plugins

#RUN git clone https://github.com/Damianonymous/streamlink-plugins.git
#RUN cp /streamlink-plugins/*.py /home/plugins/

COPY ./streamlink-recorder.sh /home/script/
COPY ./entrypoint.sh /home/script

RUN ["chmod", "+x", "/home/script/entrypoint.sh"]

ENTRYPOINT [ "/home/script/entrypoint.sh" ]

CMD /bin/sh ./home/script/streamlink-recorder.sh ${streamOptions} ${streamLink} ${streamQuality} ${streamName}
