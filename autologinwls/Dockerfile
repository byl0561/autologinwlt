FROM alpine:latest
MAINTAINER byl0561@gmail.com
RUN apk add --update curl && rm -rf /var/cache/apk/*
COPY autoLoginWLT.sh /autoLoginWLT/autoLoginWLT.sh
WORKDIR /autoLoginWLT
ENV name 
ENV pass 
ENV port 
ENTRYPOINT ["sh", "/autoLoginWLT/autoLoginWLT.sh"]
