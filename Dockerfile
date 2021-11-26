FROM ubuntu:20.04
RUN apt-get update && apt-get install -y git make gcc libncursesw5 libncursesw5-dev
RUN mkdir /snb
WORKDIR /snb
COPY . .
RUN ls -la
RUN make -j4
