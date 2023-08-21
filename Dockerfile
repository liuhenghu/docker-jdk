FROM alpine:latest

ADD  locale.md jdk-8u351-linux-x64.tar.gz /usr/local/
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk update --no-cache && apk upgrade --no-cache &&\
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    echo \
        "-----BEGIN PUBLIC KEY-----\
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApZ2u1KJKUu/fW4A25y9m\
        y70AGEa/J3Wi5ibNVGNn1gT1r0VfgeWd0pUybS4UmcHdiNzxJPgoWQhV2SSW1JYu\
        tOqKZF5QSN6X937PTUpNBjUvLtTQ1ve1fp39uf/lEXPpFpOPL88LKnDBgbh7wkCp\
        m2KzLVGChf83MS0ShL6G9EQIAUxLm99VpgRjwqTQ/KfzGtpke1wqws4au0Ab4qPY\
        KXvMLSPLUp7cfulWvhmZSegr5AdhNw5KNizPqCJT8ZrGvgHypXyiFvvAH5YRtSsc\
        Zvo9GI2e2MaZyo9/lvb+LbLEJZKEQckqRj4P26gmASrZEPStwc+yqy1ShHLA0j6m\
        1QIDAQAB\
        -----END PUBLIC KEY-----" | sed 's/   */\n/g' > "/etc/apk/keys/sgerrand.rsa.pub" && \
    wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-2.34-r0.apk" && \
    wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0//glibc-bin-2.34-r0.apk" && \
    wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0//glibc-i18n-2.34-r0.apk" && \
    apk add --force --no-cache glibc-2.34-r0.apk  glibc-bin-2.34-r0.apk glibc-i18n-2.34-r0.apk && \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    (cat /usr/local/locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8 || true) && \
    apk del .build-dependencies && \
    rm  glibc-2.34-r0.apk glibc-bin-2.34-r0.apk  glibc-i18n-2.34-r0.apk && \
    apk add --no-cache curl busybox-extras tzdata && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo Asia/Shanghai > /etc/timezone

ENV LANG=zh_CN.UTF-8 LANGUAGE=zh_CN.UTF-8  JAVA_HOME=/usr/local/jdk1.8.0_351  CLASSPATH=/usr/local/jdk1.8.0_351/lib/  PATH=/usr/local/jdk1.8.0_351/bin:$PATH