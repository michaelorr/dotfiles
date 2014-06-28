# FIXME this only exists to overcome a bug datagrok left in his custom box
# remove once fixed

'''
if [ ! -e /root/fixed-statoverride ]; then
    sudo sed -i -e '/puppet/d' /var/lib/dpkg/statoverride
    sudo touch /root/fixed-statoverride
fi
'''

# look for jellydoughnut and symlink into omz plugins

'''
if [ -d ~/mnt/jellydoughnut ]; then 
    plugin_loc=~/mnt/jellydoughnut/lib/med/med.plugin.zsh
elif [ -d ~/src/jellydoughnut ]; then
    plugin_loc=~/src/jellydoughnut/lib/med/med.plugin.zsh
fi
'''
'''
if [ ! -z "$plugin_loc" ]; then
    if [ ! -d ~/.dot/oh-my-zsh/custom/plugins/med ]; then
        mkdir -p ~/.dot/oh-my-zsh/custom/plugins/med
        ln -s -f $plugin_loc ~/.dot/oh-my-zsh/custom/plugins/med/med.plugin.zsh
    fi
fi
'''
