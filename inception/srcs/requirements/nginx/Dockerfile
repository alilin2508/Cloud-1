FROM alpine:3.18

ARG COUNTRY
ARG STATE
ARG LOCALITY
ARG ORGANIZATION
ARG ORG_UNIT
ARG DOMAIN_NAME

RUN apk update && apk upgrade && apk add	\
		openssl	\
		nginx	\
		curl	\
		vim		\
		sudo	\
		envsubst

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/${DOMAIN_NAME}.key -out /etc/nginx/ssl/${DOMAIN_NAME}.crt -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/CN=$DOMAIN_NAME"

RUN rm -f /etc/nginx/conf.d/default.conf
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN envsubst '$DOMAIN_NAME' < /etc/nginx/nginx.conf > /etc/nginx/nginxtmp.conf
RUN rm /etc/nginx/nginx.conf && mv /etc/nginx/nginxtmp.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
