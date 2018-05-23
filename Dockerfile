FROM ubuntu:12.04

#USER root

ADD sources.list /etc/apt/sources.list

RUN \
    apt-get update && \
    apt-get install -y --force-yes --no-install-recommends gcc g++ make patch unzip libpcre3-dev autoconf libtool zlib1g-dev automake git && \
    git clone https://github.com/ossrs/srs.git && \
    cd srs && \
    git checkout 3.0release && \
	mkdir -p /srs/trunk/objs/ && \
	cp /srs/trunk/3rdparty/CherryPy-3.2.4.zip /srs/trunk/objs/ && \
	unzip /srs/trunk/objs/CherryPy-3.2.4.zip -d /srs/trunk/objs/ && \
    cd /srs/trunk && ./configure --full && make -j16 && \
    cd /srs/trunk && \
    cp -rL objs/ffmpeg/ /usr/local/ && \
    cp -L objs/srs /usr/local/bin/ && \
    mkdir /data && \
    rm -rf /srs && \
    apt-get remove -y --force-yes --purge --auto-remove gcc g++ make patch unzip libpcre3-dev autoconf libtool zlib1g-dev automake git && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /data