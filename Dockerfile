FROM 1005663978/jdk11:debian11 AS builder

RUN apt install -y gcc g++ sqlite3 ant swig libgeos-dev libproj-dev cmake && \
    wget https://mirror.ghproxy.com/https://github.com/OSGeo/gdal/releases/download/v3.6.4/gdal-3.6.4.tar.gz && \
    tar -xzf gdal-3.6.4.tar.gz && cd gdal-3.6.4 && cmake -DCMAKE_INSTALL_PREFIX=/usr/local/gdal  && \
    make && make install 


FROM 1005663978/jdk11:debian11

COPY --from=builder /usr/local/gdal /usr/local/gdal

RUN apt install -y  sqlite3 ant swig libgeos-dev libproj-dev  && \
    cp /usr/local/gdal/share/java/gdal-3.6.4.jar  /usr/local/jdk-11.0.18/lib/ && \
    cp /usr/local/gdal/share/java/libgdalalljni.so /usr/local/jdk-11.0.18/lib/server/  && \
    cp -r /usr/local/gdal/bin/* /usr/local/bin/  && \
    cp -r /usr/local/gdal/lib/* /usr/local/lib/


ENV LD_LIBRARY_PATH=/usr/local/lib:$JAVA_HOME/lib/server
