FROM centos:7

RUN yum update -y
RUN yum install -y wget
RUN wget https://download.alfresco.com/release/community/4.2.f-build-00012/alfresco-community-4.2.f-installer-linux-x64.bin
RUN chmod a+x alfresco-community-4.2.f-installer-linux-x64.bin && \
 ./alfresco-community-4.2.f-installer-linux-x64.bin \
    --mode unattended \
    --installer-language en \
    --jdbc_url jdbc:postgresql://localhost/alfresco \
    --jdbc_driver org.postgresql.Driver \
    --jdbc_database alfresco \
    --jdbc_username admin \
    --jdbc_password admin \
    --postgres_port 5432 \
    --tomcat_server_domain 127.0.0.1 \
    --tomcat_server_port 8080 \
    --tomcat_server_shutdown_port 8005 \
    --tomcat_server_ssl_port 8443 \
    --tomcat_server_ajp_port 8009 \
    --alfresco_ftp_port 21 \
    --alfresco_rmi_port 50500 \
    --alfresco_admin_password admin \
    --alfresco_sharepoint_port 7070 \
    --libreoffice_port 8100 && \
    rm alfresco-community-4.2.f-installer-linux-x64.bin

EXPOSE 8080

WORKDIR /opt/alfresco-4.2.f

ENTRYPOINT ["sh", "-c", "./alfresco.sh start && tail -f tomcat/logs/catalina.out"]
