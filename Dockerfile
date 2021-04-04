FROM devopsfaith/krakend
WORKDIR /etc/krakend
COPY config ./
USER root
RUN sh -c "chmod +w /etc/krakend"
EXPOSE 7070