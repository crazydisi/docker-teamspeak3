#!/bin/bash
# === Copyright
#
# Copyright Dennis Philpot
#

# Todo
# if SQLite is used check existence of file and link it
#
# if no SQLite is used it should be MySQL
# check if connection can be established
#
# Link files folder
#
# Start Teamspeak3 Server
#

echo "Using /tsdata as data-directory"
DATADIR=/tsdata
#Todo needs to be changed
DB_DL_LINK=https://github.com/dphilpot/docker-teamspeak3/raw/develop/sqlite_db_empty/ts3server.sqlitedb

case "$DB_TYPE" in
   MYSQL )
      echo "Using MYSQL as backend"
      echo "TODO --- YES TODO Cause im no magician :)"
      echo "!!!!! So to state it clear ... we do NOT have any MySQL support yet !!!!!"
      ;;
    * )
      echo "Using SQLite as default backend"

      echo "Check if SQLite Database already exists"
      DB=ts3server.sqlitedb
      if [ -f $DATADIR/$DB ]; then
        echo "DB exists - just create link"
        ln -s $DATADIR/$DB /opt/teamspeak3-server_linux_amd64/ts3server.sqlitedb
      else
        echo "DB doesn't exists ... create empty DB and link it"
        wget -O $DATADIR/$DB $DB_DL_LINK
        ln -s $DATADIR/$DB /opt/teamspeak3-server_linux_amd64/ts3server.sqlitedb
      fi

      echo "Link the files folder (Create if necessary)"
      mkdir -p $DATADIR/files
      if ! [ -L /opt/teamspeak3-server_linux_amd64/files ]; then
        rm -rf /opt/teamspeak3-server_linux_amd64/files
        ln -s $DATADIR/files /opt/teamspeak3-server_linux_amd64/files
      fi

      echo "Check if a ts3server.ini exists or if we need to create a new config file"
      if [ -f $VOLUME/ts3server.ini ]; then
        echo "Found and using file"
        /opt/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh inifile="$DATADIR/ts3server.ini license_accepted=1"
      else
        echo "Creating new $DATADIR/ts3server.ini file with given ports"
        /opt/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh \
          createinifile=1 \
          inifile="$DATADIR/ts3server.ini" \
          licensepath="$DATADIR/" \
          license_accepted=1 \
          query_ip_whitelist="$DATADIR/query_ip_whitelist.txt" \
          query_ip_backlist="$DATADIR/query_ip_blacklist.txt" \
          logpath="$DATADIR/logs/" \
          default_voice_port=$PORT_SERVER \
          filetransfer_port=$PORT_TRANSFER \
          query_port=$PORT_QUERY
      fi
      ;;
 esac
