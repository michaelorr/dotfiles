if [ -z "$HOSTNAME_ALIAS" ]; then
    if [[ "$(hostname)" = *.cei.cox.com ]]; then
        HOSTNAME_ALIAS="cmghost"
    fi
    if [[ "$(hostname)" = *.coxinc.com ]]; then
        HOSTNAME_ALIAS="cmghost"
    fi
    if [[ "$(hostname)" = datlmichaelo.* ]]; then
        HOSTNAME_ALIAS="cmghost"
    fi
    if [ "$(hostname)" = DATLMICHAELO.local ]; then
        HOSTNAME_ALIAS="cmghost"
    fi
    if [ "$(hostname)" = morr-Latitude-E7240 ]; then
        HOSTNAME_ALIAS="cmghost"
    fi
fi

if [ -z "$HOSTNAME_ALIAS" ]; then
    HOSTNAME_ALIAS=$(hostname)
fi
