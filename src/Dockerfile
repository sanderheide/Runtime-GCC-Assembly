# Authors: Fredrik Mørstad & Fredrik Fasteraune & Øyvind Nohr
FROM ubuntu:24.04
RUN apt update && apt upgrade -y && apt install -y build-essential
RUN apt install -y gcc-mips64-linux-gnuabi64 # mips cross-compiler
RUN apt install -y gcc-x86-64-linux-gnu      # x86 cross-compiler (for macs)
RUN apt install -y qemu-user-static          # emulator (contains both mips and x86)
WORKDIR /src
COPY . .
ENTRYPOINT ["/bin/bash"]
