FROM debian:11

ADD jdk-11.0.18_linux-x64_bin.tar.gz /usr/local/
ADD simhei.ttf simsun.ttc  /usr/share/fonts/truetype/
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&   \
    sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list && \
    apt-get update -y  && apt-get upgrade -y && apt install -y vim curl net-tools telnet inetutils-ping procps less wget locales fontconfig &&  \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone &&  \
    sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen  &&  fc-cache -fv

ENV LANG=zh_CN.UTF-8 LANGUAGE=zh_CN.UTF-8  JAVA_HOME=/usr/local/jdk-11.0.18  CLASSPATH=/usr/local/jdk-11.0.18/lib/  PATH=/usr/local/jdk-11.0.18/bin:$PATH
