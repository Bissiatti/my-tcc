FROM nagadomi/torch7:latest

RUN apt update -y && apt upgrade -y && apt install libvips -y 

RUN apt install wget -y && apt install unzip -y

RUN luarocks install lua-vips