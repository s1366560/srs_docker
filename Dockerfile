FROM ubuntu:12.04

#USER root

ADD sources.list /etc/apt/sources.list

RUN \
    apt-get update && \
    apt-get install -y --force-yes --no-install-recommends gcc g++ make patch unzip libpcre3-dev autoconf libtool zlib1g-dev automake
    

ADD srs-2.0-r2.zip /

RUN unzip srs-2.0-r2.zip

RUN \
	mkdir -p /srs-2.0-r2/trunk/objs/ && \
	cp /srs-2.0-r2/trunk/3rdparty/CherryPy-3.2.4.zip /srs-2.0-r2/trunk/objs/ && \
	unzip /srs-2.0-r2/trunk/objs/CherryPy-3.2.4.zip -d /srs-2.0-r2/trunk/objs/ 
	# cd /srs-2.0-r2/trunk/objs/CherryPy-3.2.4/ 
	# python setup.py install

RUN cd /srs-2.0-r2/trunk && ./configure --full && make -j16

COPY srs.conf /srs.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN ls -ln /srs-2.0-r2/trunk/objs

EXPOSE 1935 8080 8936
ENTRYPOINT ["/entrypoint.sh"]