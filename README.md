## Usage

Create Volume...

In the example our persistant volume is called electrumx. This is being mapped to the /data directory inside the container.

Coin daemon needs to be running and have the required access from this container to the daemon.

Notes:

If you having trouble with connecting to the daemon then this might be because you have not allowed the IP that you are coming in on.

```
docker run \
  -v electrumx:/data \
  -e DAEMON_URL=http://user:pass@host:port \
  -e COIN=Odin \
  -p 50001:50001 \
  -p 50443:50443 \
imagename
```
If no certs are in the volume then it will be generated.

ElectrumX environment variables 

https://github.com/kyuupichan/electrumx/blob/master/docs/environment.rst






