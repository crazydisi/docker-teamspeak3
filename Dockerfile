# === Copyright
#
# Copyright Dennis Philpot
#

FROM ubuntu
MAINTAINER Dennis Philpot

ENV TS_VERSION 3.0.13.6
ENV TS_BASEURL http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2

ENV PORT_SERVER 9987
ENV PORT_TRANSFER 30033
ENV PORT_QUERY 10011

ENV DB_TYPE SQLite

VOLUME ["/tsdata"]

ADD ${TS_BASEURL} /tmp/
RUN cd /opt && tar -xzf /tmp/teamspeak3-server_linux_amd64-*.tar.bz2

ADD /scripts/ /opt/scripts/
RUN chmod -R 774 /opt/scripts/
ENTRYPOINT ["/opt/scripts/bootstrap.sh"]

EXPOSE ${PORT_SERVER}/udp
EXPOSE ${PORT_TRANSFER}
EXPOSE ${PORT_QUERY}
