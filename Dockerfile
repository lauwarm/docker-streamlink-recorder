FROM python:3.12.2
LABEL maintainer="lauwarm@mailbox.org"

ENV streamlinkCommit=abf230fe69c373c262fff69797e946fb03a21e15

#ENV streamlinkVersion=6.4.2
#ENV PATH "${HOME}/.local/bin:${PATH}"

#ADD https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz /opt/

#RUN apt-get update && apt-get install gosu

#RUN pip3 install versioningit

#RUN tar -xzf /opt/streamlink-${streamlinkVersion}.tar.gz -C /opt/ && \
#	rm /opt/streamlink-${streamlinkVersion}.tar.gz && \
#	cd /opt/streamlink-${streamlinkVersion}/ && \
#	python3 setup.py install

RUN apt-get update && apt-get install gosu && apt-get install python3-pip -y

RUN pip3 install --upgrade git+https://github.com/streamlink/streamlink.git@${streamlinkCommit}

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

CMD /bin/bash ./home/script/streamlink-recorder.sh ${streamCliOptions} ${streamPluginOptions} ${streamLink} ${streamQuality} ${streamName}
