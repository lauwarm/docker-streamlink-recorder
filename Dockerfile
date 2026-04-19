FROM python:3.14.4-trixie
LABEL maintainer="lauwarm@mailbox.org"

ENV streamlinkCommit=d3828a5e7b7025856d800c231b222ea64004dc37

RUN apt-get update && apt-get install gosu -y && apt-get install python3-pip -y && apt-get install git ca-certificates && apt-get install ffmpeg -y

RUN pip3 install --upgrade git+https://github.com/streamlink/streamlink.git@${streamlinkCommit}

RUN  echo 'export PATH="${HOME}/.local/bin:${PATH}"'

RUN mkdir /home/download
RUN mkdir /home/script
RUN mkdir /home/plugins

ADD https://gist.githubusercontent.com/lauwarm/cb25f85f45b1c210cd51f6bedb2b2f57/raw/77c245bd2fbc921d5f08804b1cfc20c3d28cfb7f/chaturbate.py /home/plugins/

COPY ./streamlink-recorder.sh /home/script/
COPY ./entrypoint.sh /home/script

RUN ["chmod", "+x", "/home/script/entrypoint.sh"]
RUN chmod 644 /home/plugins/chaturbate.py

ENTRYPOINT [ "/home/script/entrypoint.sh" ]

# Use JSON exec form for CMD so the process receives SIGTERM/SIGINT correctly
# and arguments are passed as separate parameters (prevents shell interference).
CMD ["/bin/bash", "/home/script/streamlink-recorder.sh", "${streamOptions}", "${streamLink}", "${streamQuality}", "${streamName}"]
