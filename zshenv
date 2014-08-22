if [ -z "$HOSTNAME_ALIAS" ]; then
    #if [ "$(hostname)" = pindrops-mbp-6.local ]; then
    #    HOSTNAME_ALIAS="pindrop"
    #fi
    if [[ "$(hostname)" = pindrops-mbp-6.* ]]; then
        HOSTNAME_ALIAS="pindrop"
    fi
    if [ "$(hostname)" = Orr.local ]; then
        HOSTNAME_ALIAS="pindrop"
    fi
    if [ "$(hostname)" = orr.att.net ]; then
        HOSTNAME_ALIAS="pindrop"
    fi
fi

if [ -z "$HOSTNAME_ALIAS" ]; then
    HOSTNAME_ALIAS=$(hostname)
fi
