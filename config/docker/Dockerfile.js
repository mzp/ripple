FROM mzpi/bucklescript:1.7.4

WORKDIR /home/opam

RUN git clone https://github.com/ocaml/opam-repository.git && \
      opam update && \
      opam install -y merlin ocp-indent utop ppx_variants_conv && \
      rm -rf /home/opam/opam-repository

ADD . /ripple
WORKDIR /ripple
