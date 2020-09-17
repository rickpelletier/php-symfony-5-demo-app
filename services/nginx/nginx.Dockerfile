FROM nginx

COPY image-files/ /

RUN chmod +x /docker-entrypoint.sh

CMD ["nginx", "-g", "daemon off;"]