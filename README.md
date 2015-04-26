# docker-teamspeak3

Ubuntu base image with Teamspeak3 Server running a local SQLite DB.
MySQL support will be there somewehere in the near future (you could help accomplish it if you want :) )

## Features
* Persistent files on the host
  * ts3server.ini
  * ts3server.sqlite
  * query_ip_whitelist.txt
  * query_ip_blacklist.txt
  * licensekey.dat
  * logs

## Usage
  * Get container

  * Build container (optinal)

  * Run container
    * Run without persistent files
    * Run with persistent files
      To run the container with persistent files you need a folder where the data should be stored.
      So please replace [DIRECTORY] with the ABSOLUTE path to the directory
      `docker run --name ts -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v [DIRECTORY]:/tsdata dphilpot/docker-teamspeak3:latest`

      Here is an example:

      `docker run --name ts -d -p 9987:9987/udp -p 30033:30033 -p 10011:10011 -v /tmp/docker-teamspeak3/:/tsdata dphilpot/docker-teamspeak3:latest`

  * Upgrade container

    **Before upgrading make sure you have a backup of your data. I take no responsibility for any damage or lost data!**

    To upgrade the container to the latest version you need to stop and remove the old container.
    I sometimes ran into the problem that the process was not updateing the image so you need to remove the image then too.

  * Additional Infos
    After starting a fresh teamspeak "installation" you need to get the admin secret which is generated.
    Todo so you just need to run the following command

    `docker logs ts`
