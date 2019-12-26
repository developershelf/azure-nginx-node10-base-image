FROM node:10-slim

# ssh
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "$SSH_PASSWD" | chpasswd 

WORKDIR /app
COPY . .

RUN chmod u+x init.sh
RUN mv sshd_config /etc/ssh/
RUN mv init.sh /usr/local/bin/

# install nginx
RUN apt-get install -y nginx
RUN npm install -g pm2

EXPOSE 2222
EXPOSE 80
CMD [ "init.sh" ]