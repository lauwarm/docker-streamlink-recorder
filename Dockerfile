FROM python:3-alpine 

RUN apk add gcc musl-dev --no-cache \ 
	&& pip install streamlink \ 
	&& apk del gcc musl-dev --no-cache \ 
	&& rm -Rf /tmp/* 

ADD https://gist.githubusercontent.com/lauwarm/5cae7bd36e4f3079a420618c9585e644/raw/a7740e19ffcb9efee88e5640da71dac19a921e67/streamlink-recorder.py /

CMD python ./streamlink-recorder.py ${streamLink} ${streamQuality} ${streamName}
