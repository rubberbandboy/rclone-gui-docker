FROM alpine:latest

RUN apk --no-cache add \
  ca-certificates \
  curl \
  fuse \
  unzip
    
RUN cd /tmp && \
  curl https://rclone.org/install.sh | tac | tac | bash && \
  apk del \
  curl \
  unzip && \
  apk --nocache upgrade
  
# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/media"]

EXPOSE 5572/tcp

ENTRYPOINT ["sh", "-c", "/usr/bin/rclone rcd --rc-web-gui --config=/config/rclone.conf --rc-addr=0.0.0.0:5572 --rc-serve"]
