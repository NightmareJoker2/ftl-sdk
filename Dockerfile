FROM debian:9

RUN apt-get update -y
RUN apt-get install wget -y
RUN apt-get install -y cmake
RUN apt-get install git -y
RUN apt-get install build-essential -y
RUN apt-get install libssl-dev -y
RUN apt-get install libcurl4-openssl-dev -y
RUN apt-get upgrade ca-certificates -y

RUN useradd ftl-user

RUN mkdir -p /opt/ftl-sdk/vid

RUN chown -R ftl-user:ftl-user /opt/ftl-sdk

WORKDIR /opt/ftl-sdk/vid

RUN wget https://videotestmedia.blob.core.windows.net/ftl/sintel.h264
RUN wget https://videotestmedia.blob.core.windows.net/ftl/sintel.opus

COPY . /opt/ftl-sdk

RUN chown -R ftl-user:ftl-user /opt/ftl-sdk

USER ftl-user

WORKDIR /opt/ftl-sdk

RUN ./build

ENTRYPOINT ["./start-stream"]

