FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends nodejs npm nodejs-legacy

RUN npm install -g coffee-script

RUN npm install -g request

ENV PATH node_modules/.bin:$PATH

ADD bot.coffee /opt/bot/bot.coffee

WORKDIR /opt/bot

CMD ["coffee", "bot.coffee"]
