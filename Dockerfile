FROM debian:9

RUN apt-get update -y
RUN apt-get install wget -y
RUN apt-get install -y cmake
RUN apt-get install git -y
RUN apt-get install build-essential -y
RUN apt-get install libssl-dev -y
RUN apt-get install libcurl4-openssl-dev -y
RUN apt-get upgrade ca-certificates -y

RUN apt-get install -y jq curl

RUN useradd ftl-user

RUN mkdir -p /opt/ftl-sdk/vid

RUN chown -R ftl-user:ftl-user /opt/ftl-sdk

WORKDIR /opt/ftl-sdk/vid

ARG VIDEO_URL=https://videotestmedia.blob.core.windows.net/ftl/sintel.h264
RUN wget ${VIDEO_URL}
ARG AUDIO_URL=https://videotestmedia.blob.core.windows.net/ftl/sintel.opus
RUN wget ${AUDIO_URL}

RUN mv *.h264 video.h264
RUN mv *.opus audio.opus

COPY --chown=ftl-user:ftl-user . /opt/ftl-sdk

USER ftl-user

WORKDIR /opt/ftl-sdk

RUN ./scripts/build

ENTRYPOINT ["./start-stream"]

