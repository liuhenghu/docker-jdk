FROM debian:11

ADD jdk-8u351-linux-x64.tar.gz /usr/local/
ADD simhei.ttf simsun.ttc  /usr/share/fonts/truetype/
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list &&   \
    sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list && \
    apt-get update -y  && apt-get upgrade -y && apt install -y vim curl net-tools telnet inetutils-ping procps less wget locales fontconfig &&  \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone &&  \
    sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen && locale-gen  &&  fc-cache -fv

ADD eng.traineddata chi_sim.traineddata osd.traineddata /usr/share/tesseract-ocr/5/tessdata/
RUN echo "deb https://notesalexp.org/tesseract-ocr5/bullseye/ bullseye main" >> /etc/apt/sources.list &&  \
    apt-get update -y -oAcquire::AllowInsecureRepositories=true &&   \
    apt-get  install -y notesalexp-keyring -oAcquire::AllowInsecureRepositories=true  --allow-unauthenticated &&  \
    apt-get update -y && apt-get  install -y tesseract-ocr 

ENV LANG=zh_CN.UTF-8 LANGUAGE=zh_CN.UTF-8  JAVA_HOME=/usr/local/jdk1.8.0_351  CLASSPATH=/usr/local/jdk1.8.0_351/lib/  PATH=/usr/local/jdk1.8.0_351/bin:$PATH