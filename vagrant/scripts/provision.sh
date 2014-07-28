#!/bin/sh
set -e

# This script should contain custom configuration commands you want to
# run inside the guest each time you run `vagrant up`.

# This should be idempotent as Vagrant can re-provision the box without
# halting or suspending it.

  # FIXME this only exists to overcome a bug datagrok left in his custom box; remove when fixed
  if [ ! -e /root/fixed-statoverride ]; then
    sudo sed -i -e '/puppet/d' /var/lib/dpkg/statoverride
    sudo touch /root/fixed-statoverride
  fi

