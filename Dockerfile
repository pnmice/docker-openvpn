FROM alpine:3.15

ENV OVPN_DATA=/openvpn
ENV EASYRSA=/usr/share/easy-rsa
ENV EASYRSA_PKI=${OVPN_DATA}/pki
ENV EASYRSA_VARS_FILE /usr/share/easy-rsa/vars
ENV EASYRSA_BATCH=true

RUN apk add --no-cache --update \
        openvpn=2.5.4-r0 \
        iptables=1.8.7-r1 \
        bash=5.1.8-r0 \
        easy-rsa=3.0.8-r0 \
        openvpn-auth-pam=2.5.4-r0 \
        google-authenticator=1.09-r1 \
        curl=7.80.0-r0 && \
	ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
	rm -rf /var/cache/apk/*
COPY openvpn.conf /etc/openvpn/openvpn.conf
COPY bin /usr/local/bin/
COPY docker-start.sh /usr/local/bin/
COPY vars /usr/share/easy-rsa

CMD ["docker-start.sh"]
