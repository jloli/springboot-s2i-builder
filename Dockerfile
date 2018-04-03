FROM openshift/base-centos7

# Docker Image Metadata
LABEL io.k8s.description="Builder for Springboot apps" \
      io.k8s.display-name="Springboot apps" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.tags="builder,java,maven" \
      io.openshift.expose-services="8000:http"

# Installs java
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    mkdir -p /opt/s2i/destination

# S2I scripts
COPY assemble /usr/libexec/s2i/

COPY run /usr/libexec/s2i/

COPY usage /usr/libexec/s2i/

RUN chown -R 1001:1001 /opt/app-root

USER 1001

EXPOSE 8000

CMD ["/usr/libexec/s2i/usage"]