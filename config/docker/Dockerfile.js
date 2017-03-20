FROM mzpi/bucklescript

WORKDIR /home/opam

RUN git clone https://github.com/ocaml/opam-repository.git && \
      opam update && \
      opam install -y merlin ocp-indent && \
      rm -rf /home/opam/opam-repository

WORKDIR /ripple
