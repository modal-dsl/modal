FROM openjdk:11-jre
COPY build/docker /usr/bin/mdal-standalone
RUN ln -s /usr/bin/mdal-standalone/bin/mdal-standalone /bin/mdal
WORKDIR /project
ENTRYPOINT [ "mdal" ]
