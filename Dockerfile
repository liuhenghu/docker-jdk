FROM 1005663978/jdk8:debian11-tesseract5

ADD wkhtmltox_0.12.6.1-2.bullseye_amd64.deb /tmp/
RUN apt install -y /tmp/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb && \
    rm -f  /tmp/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb

