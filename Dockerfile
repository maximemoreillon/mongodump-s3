FROM mongo:8.0

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq curl unzip && \
    curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/awscliv2.zip /tmp/aws && \
    apt-get remove -y -qq unzip && \
    apt-get autoremove -y -qq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

     
# Sanity check at build time: fail the build if either tool is missing.
RUN mongodump --version && aws --version
 
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh
 
ENTRYPOINT ["/usr/local/bin/backup.sh"]
