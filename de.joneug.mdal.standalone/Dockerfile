FROM openjdk:11-jre
RUN useradd mdal \
    && mkdir -p /project \
    && chown -R mdal /project
WORKDIR /project
USER mdal
COPY build/docker /usr/bin/mdal
ENTRYPOINT [ "/usr/bin/mdal/bin/mdal-standalone" ]
