FROM python:3.12.2
LABEL maintainer="lauwarm@mailbox.org"

ENV streamlinkCommit=a309e6e9cf621655779c7283dff51686f5d2a22b

#ENV streamlinkVersion=6.7.4
#ENV PATH "${HOME}/.local/bin:${PATH}"

#ADD https://github.com/streamlink/streamlink/releases/download/${streamlinkVersion}/streamlink-${streamlinkVersion}.tar.gz /opt/

#RUN apt-get update && apt-get install gosu

#RUN pip3 install versioningit

#RUN tar -xzf /opt/streamlink-${streamlinkVersion}.tar.gz -C /opt/ && \
#	rm /opt/streamlink-${streamlinkVersion}.tar.gz && \
#	cd /opt/streamlink-${streamlinkVersion}/ && \
#	python3 setup.py install

RUN apt-get update && apt-get install gosu -y && apt-get install python3-pip -y && apt-get install git ca-certificates -y

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

# Use JSON exec form for CMD so the process receives SIGTERM/SIGINT correctly
# and arguments are passed as separate parameters (prevents shell interference).
CMD ["/bin/bash", "/home/script/streamlink-recorder.sh", "${streamOptions}", "${streamLink}", "${streamQuality}", "${streamName}"]
