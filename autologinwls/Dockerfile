FROM centos:latest
MAINTAINER byl0561@gmail.com
COPY autoLoginWLT.sh /autoLoginWLT/autoLoginWLT.sh
WORKDIR /autoLoginWLT
ENV name
ENV pass
ENV port
ENTRYPOINT ["/bin/bash", "/autoLoginWLT/autoLoginWLT.sh"]
