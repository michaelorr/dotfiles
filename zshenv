export PATH=$HOME:/usr/local/src:/opt:/var:$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH

if [ -z "$HOSTNAME_ALIAS" ]; then
    if [ "$(hostname)" = "datlmichaelo.cei.cox.com" ]; then
        HOSTNAME_ALIAS="cmghostosx"
    fi
fi

if [ -z "$HOSTNAME_ALIAS" ]; then
    HOSTNAME_ALIAS=$(hostname)
fi
