FROM ubuntu:18.04

RUN echo 'Updating docker file'

# Required dependencies: libcurl4 libapr1 libjansson4 libaprutil1
RUN apt update && apt install -y --no-install-recommends libcurl4 libapr1 libjansson4 libaprutil1 ca-certificates nginx

# copy PX Nginx dynamic module to Nginx module folder
COPY modules/ngx_http_pxnginx_module.so /usr/lib/nginx/modules/

#nginx config
COPY nginx.conf /etc/nginx/
COPY proxy_config/section-nginx.conf /opt/proxy_config/

#platform scripts
COPY *.sh /opt/section/
RUN chmod +x /opt/section/*.sh

RUN ln -sf /proc/$$/fd/1   /var/log/nginx/access.log
RUN ln -sf /proc/$$/fd/2   /var/log/nginx/error.log

CMD ["nginx"]
