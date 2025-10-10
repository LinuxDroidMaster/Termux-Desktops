#!/data/data/com.termux/files/usr/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"

# manually set in proot-distro enviroment for the following
# sudo nano /etc/environment
# export PULSE_SERVER=127.0.0.1 
# export XDG_RUNTIME_DIR=${TMPDIR}

# Execute user provided path to executable via x11-app.sh script
./x11-app.sh proot-distro login debian --shared-tmp --user user --env DISPLAY=:\$\$ -- $*

# .bashrc
#alias x=~/scripts/x11-app.sh
#alias p=~/scripts/x11-proot-app.sh
#alias xx="x xfce4-session"
#alias pdc='p cinnamon-session'
#alias pdg='p gnome-shell --x11'
#alias pdk='p startplasma-x11'
#alias pdl='p startlxde'
#alias pdx='p startxfce4'

# some sample commands for x11-app.sh
# x proot-distro login debian --shared-tmp --user user --env DISPLAY=:\$\$ -- $HOME/eclipse/eclipse

# some sample commands for x11-proot-app.sh
# p $HOME/eclipse/eclipse
