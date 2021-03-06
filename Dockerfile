FROM ruby:2.0.0
MAINTAINER Guilherme Garnier <guilherme.garnier@gmail.com>

ENV SOURCE_DIR /icosmith
ENV EXPOSED_PORT 3000

RUN apt-get update && \
  apt-get install -y build-essential fontforge libfreetype6-dev git && \
  rm -rf /var/lib/apt/lists/*

# ttf2eot build
RUN mkdir /build && \
  cd /build && \
  wget --no-check-certificate https://ttf2eot.googlecode.com/files/ttf2eot-0.0.2-2.tar.gz && \
  tar zxvf ttf2eot-0.0.2-2.tar.gz && \
  sed -i.bak "/using std::vector;/ i\#include <cstddef>" /build/ttf2eot-0.0.2-2/OpenTypeUtilities.h && \
  cd /build/ttf2eot-0.0.2-2 && \
  make && \
  cp ttf2eot /usr/local/bin/ttf2eot

## ttfautohint build
RUN cd /build && \
  wget http://downloads.sourceforge.net/project/freetype/ttfautohint/0.95/ttfautohint-0.95.tar.gz && \
  tar zxvf ttfautohint-0.95.tar.gz && \
  cd /build/ttfautohint-0.95 && \
  ./configure --with-qt=no --without-doc && \
  make && \
  make install

# Icosmith build
RUN mkdir -p $SOURCE_DIR
WORKDIR $SOURCE_DIR

RUN cd $SOURCE_DIR && \
  git clone https://github.com/tulios/icosmith . && \
  bundle install

EXPOSE $EXPOSED_PORT

CMD ["rails", "server"]
ENTRYPOINT ["bundle", "exec"]
