FROM ubuntu:latest
MAINTAINER Jason M. Mills <jason.mills@integratelecom.com>

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y curl

RUN curl -L https://cpanmin.us | perl - --sudo App::cpanminus

RUN cpanm Mojolicious
RUN cpanm ORLite

ADD MicroCMS.pl /
RUN chmod +x /MicroCMS.pl

ENTRYPOINT ["/MicroCMS.pl"]
