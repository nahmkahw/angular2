FROM node:5
MAINTAINER Nahmkahw <nahmkahw@gmail.com>

WORKDIR /project
EXPOSE 4200 49152 80
ENV HOME /project

VOLUME /project

COPY nginx.conf /etc/nginx/sites-enabled/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "events { worker_connections 1024; }" >> /etc/nginx/nginx.conf

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 775 /entrypoint.sh && chmod +x /entrypoint.sh

COPY ./postinstall.sh /postinstall.sh
RUN chmod 775 /postinstall.sh && chmod +x /postinstall.sh

RUN /postinstall.sh

ENTRYPOINT ["/entrypoint.sh"]

