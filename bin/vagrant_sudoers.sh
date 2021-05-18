#!/bin/bash
# Add Vagrant's NFS setup commands to sudoers, for `vagrant up` without a password
# Updated to work with Vagrant 1.3.x

# Stage updated sudoers in a temporary file for syntax checking
TMP=$(mktemp)
cat /etc/sudoers > $TMP
cat >> $TMP <<EOF
Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_EXPORTS_ADD_CU = /usr/local/opt/coreutils/libexec/gnubin/tee -a /etc/exports
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports
# ↓この行中に、上に追記したCmnd_Aliasを追記
%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_EXPORTS_ADD_CU, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE
EOF

# Check syntax and overwrite sudoers if clean
visudo -c -f $TMP
if [ $? -eq 0 ]; then
  echo "Adding vagrant commands to sudoers"
  cat $TMP > /etc/sudoers
else
echo "sudoers syntax wasn't valid. Aborting!"
fi

rm -f $TMP
