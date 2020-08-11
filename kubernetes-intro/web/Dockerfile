FROM nginx:latest
EXPOSE 8000
RUN apt update && apt install -y -q net-tools procps
RUN userdel nginx && \
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx --uid 1001 nginx
RUN chmod 777 /var/cache/nginx && \
    chmod 777 /var/run
RUN mkdir /app && \
    echo "test" > /app/test.html
RUN sed -i -E 's/listen.+;/listen 8000;/g' /etc/nginx/conf.d/*.conf && \
    sed -i -E 's/root.+;/root \/app;/g' /etc/nginx/conf.d/*.conf
USER 1001
