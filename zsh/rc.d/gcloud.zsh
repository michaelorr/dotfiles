#!/usr/bin/env zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f $TOOLS/google-cloud-sdk/path.zsh.inc ]; then
    source "$TOOLS/google-cloud-sdk/path.zsh.inc"
else
    echo "Install gcloud or disable the plugin. [mo]"
fi

# The next line enables shell command completion for gcloud.
if [ -f $TOOLS/google-cloud-sdk/completion.zsh.inc ]; then
    source "$TOOLS/google-cloud-sdk/completion.zsh.inc"
fi
