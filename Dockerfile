FROM 621151048552.dkr.ecr.us-east-1.amazonaws.com/ubuntu
RUN /usr/local/bin/meteor --version
ENV METEOR_ALLOW_SUPERUSER=1
COPY .env /usr/src/
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN ls -ls
RUN meteor npm install --production
RUN export TOOL_NODE_FLAGS=--max-old-space-size=3000
RUN chmod -R 700 /usr/src/app/.meteor/local 
RUN meteor build --server-only --allow-superuser --directory /usr/src/build/ 
WORKDIR /usr/src/build/bundle/
RUN ls -la
WORKDIR /usr/src/build/bundle/programs/server/

RUN npm install --production
WORKDIR /usr/src/
RUN . /usr/src/.env

EXPOSE 7005

EXPOSE 27017

WORKDIR /usr/src/build/bundle/
RUN ls
CMD ["sh", "-c", ". /usr/src/.env && node main.js"]
