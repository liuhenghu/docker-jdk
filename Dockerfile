FROM 1005663978/jdk8:debian11

ADD eng.traineddata chi_sim.traineddata osd.traineddata /usr/share/tesseract-ocr/5/tessdata/
RUN echo "deb https://notesalexp.org/tesseract-ocr5/bullseye/ bullseye main" >> /etc/apt/sources.list &&  \
    apt-get update -y -oAcquire::AllowInsecureRepositories=true &&   \
    apt-get  install -y notesalexp-keyring -oAcquire::AllowInsecureRepositories=true  --allow-unauthenticated &&  \
    apt-get update -y && apt-get  install -y tesseract-ocr 
