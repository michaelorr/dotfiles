if [ -z "$HOSTNAME_ALIAS" ]; then
    if [[ "$(hostname)" = *.cei.cox.com ]]; then
        HOSTNAME_ALIAS="cmghost"
    fi
fi

if [ -z "$HOSTNAME_ALIAS" ]; then
    HOSTNAME_ALIAS=$(hostname)
fi
