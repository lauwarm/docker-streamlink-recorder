FROM python:3-alpine 

RUN apk add gcc musl-dev --no-cache \ 
	&& pip install streamlink \ 
	&& apk del gcc musl-dev --no-cache \ 
	&& rm -Rf /tmp/* 

ADD https://gist.githubusercontent.com/lauwarm/5cae7bd36e4f3079a420618c9585e644/raw/6b70e4082693c9d6791a581c48905a078ac75a43/streamlink-recorder.py /

CMD python ./streamlink-recorder.py ${streamLink} ${streamQuality} ${streamName}
