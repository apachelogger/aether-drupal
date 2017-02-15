FROM ubuntu:16.04
MAINTAINER Harald Sitter <sitter@kde.org>
EXPOSE 8787

ADD assets /tmp/assets
ADD god /god

RUN /tmp/assets/bootstrap.sh

CMD god -c /god -D
