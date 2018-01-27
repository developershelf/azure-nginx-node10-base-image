FROM node:6-slim AS build-env

# ssh
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "$SSH_PASSWD" | chpasswd 

COPY . .
RUN mv sshd_config /etc/ssh/
RUN mv init.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/init.sh

# install nginx
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y nginx
RUN apt-get install -y --no-install-recommends python make gcc g++ libc-dev;

EXPOSE 2222 80
CMD [ "init.sh" ]