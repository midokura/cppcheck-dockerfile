FROM ubuntu:18.04 AS cppcheck

RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends \
  git ca-certificates clang make cmake

# Build cppcheck by ourselves as --project=compile_commands.json
# doen't seem working with the ubuntu "cppcheck" package.
WORKDIR /root/cppcheck
RUN git clone --depth=1 https://github.com/danmar/cppcheck --branch 2.1 --single-branch
WORKDIR cppcheck
RUN mkdir build
WORKDIR build
RUN cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_EXE_LINKER_FLAGS=-static ..
RUN make install

FROM scratch
COPY --from=cppcheck /usr/bin/cppcheck /usr/bin/cppcheck
COPY --from=cppcheck /usr/share/Cppcheck /usr/share/Cppcheck
