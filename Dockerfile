FROM ruby:2.0.0

ENV SOURCE_DIR /icosmith
ENV EXPOSED_PORT 3000

RUN mkdir -p $SOURCE_DIR

WORKDIR $SOURCE_DIR

RUN apt-get update
RUN apt-get install -y fontforge ttfautohint
RUN rm -rf /var/lib/apt/lists/*

# ttf2eot build
RUN mkdir /build && cd /build && wget --no-check-certificate https://ttf2eot.googlecode.com/files/ttf2eot-0.0.2-2.tar.gz && tar zxvf ttf2eot-0.0.2-2.tar.gz
RUN sed -i.bak "/using std::vector;/ i\#include <cstddef>" /build/ttf2eot-0.0.2-2/OpenTypeUtilities.h
RUN cd /build/ttf2eot-0.0.2-2 && make && cp ttf2eot /usr/local/bin/ttf2eot

## ttfautohint build
RUN apt-get install -y libqt4-core libqt4-dev libqt4-gui qt4-dev-tools
RUN apt-get install -y libfreetype6-dev
RUN cd /build && wget http://downloads.sourceforge.net/project/freetype/ttfautohint/0.97/ttfautohint-0.97.tar.gz && tar zxvf ttfautohint-0.97.tar.gz
RUN cd /build/ttfautohint-0.97 && ./configure --without-doc && make install

EXPOSE $EXPOSED_PORT

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN bundle
ADD . $SOURCE_DIR

CMD ["server"]
ENTRYPOINT ["bundle", "exec", "rails"]
