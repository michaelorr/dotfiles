export PATH=$HOME:/usr/local/src:/opt:/var:$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH

if [ -z "$HOSTNAME_ALIAS" ]; then
    if [[ "$(hostname)" = *.cei.cox.com ]]; then
        HOSTNAME_ALIAS="cmghost"
    fi
fi

if [ -z "$HOSTNAME_ALIAS" ]; then
    HOSTNAME_ALIAS=$(hostname)
fi
