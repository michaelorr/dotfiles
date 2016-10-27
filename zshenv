if [ -z "$HOSTNAME_ALIAS" ]; then
    if [[ "$(hostname)" = pindrops-mbp-6.* ]]; then
        HOSTNAME_ALIAS="pindrop"
    fi
    if [ "$(hostname)" = Orr.local ]; then
        HOSTNAME_ALIAS="pindrop"
    fi
    if [[ "$(hostname)" = *.att.net ]]; then
        HOSTNAME_ALIAS="pindrop"
    fi
fi

if [ -z "$HOSTNAME_ALIAS" ]; then
    HOSTNAME_ALIAS=$(hostname)
fi

if [ "$HOSTNAME_ALIAS" = tesla ]; then
    HOST_OS="linux"
elif [ "$HOSTNAME_ALIAS" = pindrop ]; then
    HOST_OS="mac"
else
    HOST_OS="linux"
fi
