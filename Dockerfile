FROM java
MAINTAINER Luo Chunhui "wo@luochunhui.com"

ENV DB_DBNAME books
ENV DB_COLLECTION books
ENV DB_HOST localhost

COPY src/run.sh /run.sh
RUN chmod +x /run.sh

COPY src/samples/echoserver.jar /echoserver.jar

CMD ["/run.sh"]

EXPOSE 10888
