FROM alpine:3.3

MAINTAINER pstauffer@confirm.ch

#
# Install all required dependencies.
#

RUN apk --update upgrade && \
    apk add --update curl && \
    rm -rf /var/cache/apk/*


#
# Add named init script.
#

ADD init.sh /init.sh
RUN chmod 750 /init.sh


#
# Define container settings.
#

USER nobody

WORKDIR /tmp


#
# Start named.
#

CMD ["/init.sh"]
