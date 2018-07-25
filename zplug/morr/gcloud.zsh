#!/usr/bin/env zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f $CODE/etc/google-cloud-sdk/path.zsh.inc ]; then
    source "$CODE/etc/google-cloud-sdk/path.zsh.inc"
else
    echo "Install gcloud or disable the plugin. [mo]"
fi

# The next line enables shell command completion for gcloud.
if [ -f $CODE/etc/google-cloud-sdk/completion.zsh.inc ]; then
    source "$CODE/etc/google-cloud-sdk/completion.zsh.inc"
fi
