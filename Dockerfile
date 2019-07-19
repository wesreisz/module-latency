FROM ubuntu:18.04

# Required dependencies: libcurl4 libapr1 libjansson4 libaprutil1
RUN apt update && apt install -y --no-install-recommends libcurl4 libapr1 libjansson4 libaprutil1 ca-certificates nginx

# copy PX Nginx dynamic module to Nginx module folder
COPY ngx_http_pxnginx_module.so /usr/lib/nginx/modules/

COPY nginx.conf /etc/nginx/
COPY section-nginx.conf /opt/proxy_config/section-nginx.conf

CMD ["nginx"]
