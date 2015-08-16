FROM library/ubuntu:trusty
MAINTAINER bob
USER root
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ethereum/ethereum
RUN add-apt-repository ppa:ethereum/ethereum-dev
RUN apt-get update
RUN apt-get -y install ethereum solc


RUN apt-get install -y git-core
RUN apt-get install -y python-pip python-dev libyaml-dev libssl-dev
RUN git clone https://github.com/ethereum/pyrlp
WORKDIR pyrlp
RUN git checkout develop
RUN pip install -e .
RUN git clone https://github.com/ethereum/pydevp2p
WORKDIR pydevp2p
RUN pip install -e .
RUN git clone https://github.com/ethereum/pyethereum
WORKDIR pyethereum
RUN git checkout develop
RUN pip install -e .
RUN git clone https://github.com/ethereum/pyethapp
WORKDIR pyethapp
RUN pip install -e .

RUN pip install ethereum-serpent 
RUN apt-get install -y vim curl

RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
RUN echo 'set tabstop=4'  >> ~/.vimrc
RUN echo 'set expandtab'  >> ~/.vimrc
RUN echo 'execute pathogen#infect()'  >> ~/.vimrc
RUN echo 'syntax on'  >> ~/.vimrc
RUN echo 'filetype plugin indent on' >> ~/.vimrc

RUN cd ~/.vim/bundle && git clone https://github.com/tomlion/vim-solidity.git
RUN apt-get install -y libzmq-dev 
RUN pip install jupyter
RUN apt-get -y install ethminer 

RUN \
  mkdir -p /goroot && \
  curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1

# Set environment variables.
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

RUN go get -u github.com/ipfs/go-ipfs/cmd/ipfs

RUN apt-get -y install wget
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc


RUN npm install -g embark-framework grunt-cli
RUN apt-get install -y screen 
WORKDIR /data

