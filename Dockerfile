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
