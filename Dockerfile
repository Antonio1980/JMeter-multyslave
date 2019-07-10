FROM ubuntu:latest

MAINTAINER <antishipul@gmail.com>
LABEL maintainer=${MAINTAINER}

# JMeter version
ARG JMETER_VERSION=5.1.1
ENV JMETER_VERSION=${JMETER_VERSION}

ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
ENV JAVA_VERSION="11.0.3"

# Set JMeter Home
ENV JMETER_HOME /jmeter/apache-jmeter-${JMETER_VERSION}/
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV MIRROR_HOST https://archive.apache.org/dist/jmeter
ENV JMETER_DOWNLOAD_URL ${MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_DOWNLOAD_URL http://repo1.maven.org/maven2/kg/apc
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext/

# Add JMeter to the Path
ENV PATH ${JMETER_HOME}/bin:${PATH}

USER root

# Install few utilities
RUN apt-get clean && \
    apt-get -y update && \
    apt-get -y -q upgrade && \
    apt-get -qy install --yes \
                default-jdk \
                default-jre \
                software-properties-common htop \
                curl \
                wget \
                telnet \
                vim \
                nmon \
                apt-transport-https \
                apt-utils \
                iputils-ping \
                unzip \
                tar \
                openssh-client \
                tightvncserver \
                software-properties-common \
                openjdk-11-jdk \
                openjdk-11-jre \
                libxml2-dev \
                libxslt-dev \
                zlib1g-dev \
                net-tools

RUN update-ca-certificates --fresh

RUN java -version

# Install JMeter
RUN mkdir /jmeter

COPY apache-jmeter-5.1.1 ${JMETER_HOME}

VOLUME ${JMETER_HOME}

WORKDIR ${JMETER_HOME}
