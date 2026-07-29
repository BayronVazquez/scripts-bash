movies=/var/lib/plexmediaserver/Movies
series=/var/lib/plexmediaserver/Series

#############################################################
#            CAMBIA EL PROPIETARIO Y EL GRUPO
#############################################################
chown gorillax:plex "$movies" -R
chown gorillax:plex "$series" -R

#############################################################
#           CAMBIA LOS PERMISOS DE LOS ARCHIVOS
#############################################################

# Movies
chmod 750 "$movies"
chmod 640 "$movies"/*

# Series
chmod 750 "$series"
chmod 750 "$series"/*

cd "$series"

for directorio in $(ls); do
    if [ -d "$directorio" ]; then
        echo "Directorio: $directorio"
	    chmod 640 "$directorio"/*
    fi
done
