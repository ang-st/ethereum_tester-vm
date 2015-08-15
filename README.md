### ethereum_tester-vm
Docker file for a quick testing setup for ethereum 

to build:
````
docker build -t "ether_test" .
```

to run a proper shell :
````
docker run -t -i --entrypoint=/bin/bash -v $PWD/storage/:/data ether_test
```


come with ipython, geth, eth, pyethereum
