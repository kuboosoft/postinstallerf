#!/bin/bash
#
# +--------------------------------------------------------------------------------+
# | Copyright (C) 2012 Kuboosoft                                                   |
# |                                                                                |
# |This program is free software; You can distribute it and / or                   |
# |modify it under the terms of the GNU General Public License                     |
# |as published by the Free Software Foundation; any                               |
# |version 3 of the License, or (optionally) any version                           |
# |later. http://www.gnu.org/licenses/lgpl.html                                    |
# |This program is distributed in the hope that it will be useful,                 |
# |but WITHOUT ANY WARRANTY. See the GNU General Public License                    |
# |for details.                                                                    |
# +--------------------------------------------------------------------------------+
# |This code is designed, written and maintained by Kuboode and David Vasquez      |
# |This code was translated by Max M                                               |
# |Any questions, comments or advice on this code                                  |
# |should be addressed to:                                                         |
# |http:www.kuboosoft.blogspot.com                                                 |
# +--------------------------------------------------------------------------------+
# FEDORA 17, 18, 19 POSTINSTALLER V.1.2.0 32 BITS

hora=$(date +"%H")


if [ $(echo $LANG | cut -b1-2) = "es" ]; then

if test $hora -lt 12; then

yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Bienvenido a PostInstallerF

Buen dia, PostInstallerF es un programa que instala todo lo necesario en Fedora"


elif test $hora -gt 12 & test $hora -le 18; then

  yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Bienvenido a PostInstallerF

Buena tarde, PostInstallerF es un programa que instala todo lo necesario en Fedora"

else

	yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Bienvenido a PostInstallerF

Buena noche, PostInstallerF es un programa que instala todo lo necesario en Fedora"

fi

else

if test $hora -lt 12; then

yad --class="ATENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="

Good day, PostInstallerF is a program that installs everything you need in Fedora"


elif test $hora -gt 12 & test $hora -le 18; then

	yad --class="ATENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="

Good afternoon, PostInstallerF is a program that installs everything you need in Fedora"

else

	yad --class="ATENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="

Good night, PostInstallerF is a program that installs everything you need in Fedora"

fi
 fi


# DIRECTORY AND LOG FILE

if [ -d /usr/share/.postinstallerf/ ]; then
cd /usr/share/.postinstallerf/
echo "the log directory exists" >> installed.log
else
mkdir -p /usr/share/.postinstallerf/
cd /usr/share/.postinstallerf/
echo "log directory was created" >> installed.log 
fi


# KILLING LOCK YUM
pkill -SIGKILL -u root -o yum

# CHECKING REPOSITORIES  

relea=$(rpm -q --queryformat '%{VERSION}\n' fedora-release); echo "relea=$relea"

if [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ] && [ -f /etc/yum.repos.d/rpmfusion-free.repo ]; then
echo "RPM Fusion free and nonfree repo is present"
else
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$relea.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$relea.noarch.rpm 2>&1 | zenity --progress --title "Checking Repository and Adding RPMFusion" --text="Please wait...." --pulsate --auto-close --width=400
fi

if [ -f /etc/yum.repos.d/russianfedora-free.repo ]; then
echo 'Russian Fedora free is present'
else
yum -y localinstall http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/fedora/russianfedora-free-release-stable.noarch.rpm 2>&1 | zenity --progress --title "Checking Repository and Adding Community 3rd party Free" --text="Please wait...." --pulsate --auto-close --width=400
fi

if [ -f /etc/yum.repos.d/russianfedora-nonfree.repo ]; then
echo 'Russian Fedora non free is present'
else
yum -y localinstall http://mirror.yandex.ru/fedora/russianfedora/russianfedora/nonfree/fedora/russianfedora-nonfree-release-stable.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorios Community 3rd party Non-Free" --text="Por favor espere...." --pulsate --auto-close --width=400
fi


if [ -f /etc/yum.repos.d/postinstallerf.repo ]; then
echo 'postinstallerf repository is installed'
else
echo '[postinstallerf]
name=PostInstallerF
baseurl=http://sourceforge.net/projects/postinstaller/files/fedora/releases/$releasever/$basearch/
        ftp://heanet.dl.sourceforge.net/mirrors/sourceforge/p/po/postinstaller/fedora/releases/$releasever/$basearch/
        http://ftp.jaist.ac.jp/pub/sourceforge/p/po/postinstaller/fedora/releases/$releasever/$basearch/
        ftp://ftp.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/p/po/postinstaller/fedora/releases/releases/$releasever/$basearch/
        http://www.mirrorservice.org/sites/ftp.sourceforge.net/pub/sourceforge/p/po/postinstaller/fedora/releases/$releasever/$basearch/
        http://ftp.pbone.net/mirror/ftp.sourceforge.net/pub/sourceforge/p/po/postinstaller/fedora/releases/$releasever/$basearch/
enable=1
metadata_expire=2d
gpgcheck=0
gpgkey=http://sourceforge.net/projects/postinstaller/files/data/repodata/repomd.xml.key
skip_if_unavailable=1
exclude=ffmpeg ffmpeg-devel ffmpeg-libs


[postinstallerf-source]
name=PostInstallerF-Source
baseurl=http://sourceforge.net/projects/postinstaller/files/SRPM/
        ftp://heanet.dl.sourceforge.net/mirrors/sourceforge/p/po/postinstaller/SRPM/
        http://ftp.jaist.ac.jp/pub/sourceforge/p/po/postinstaller/SRPM/
        ftp://ftp.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/p/po/postinstaller/SRPM/
        http://www.mirrorservice.org/sites/ftp.sourceforge.net/pub/sourceforge/p/po/postinstaller/SRPM/
        http://ftp.pbone.net/mirror/ftp.sourceforge.net/pub/sourceforge/p/po/postinstaller/SRPM/
enabled=0
metadata_expire=2d
gpgcheck=0
gpgkey=http://sourceforge.net/projects/postinstaller/files/data/repodata/repomd.xml.key
skip_if_unavailable=1
exclude=ffmpeg ffmpeg-devel ffmpeg-libs' >> /etc/yum.repos.d/postinstallerf.repo
fi


wait ${!}


# CLEANING THE REPOSITORY METADATA.

updater=/usr/share/updatepostintaller/Postinstaller.sh
source=/usr/bin/Postinstaller.sh
update=/usr/share/updatepostintaller/Postinstaller.sh

nuday=$(date +%u); echo "nuday=$nuday"

time=$(date +%H); echo "time=$time"
time2=$(date +%R); echo "time2=$time2"

setime=08
setimea=16:00
setimeb=12:00
setimec=0

Mon=1
Tue=2
Wed=3
Thu=4
Fri=5
Sat=6
Sun=7

if [ ""$nuday = $Fri"" ] && [ ""$time = $setime"" ]; then
yum clean metadata
elif [ ""$nuday = $Fri"" ] && [ ""$time2 = $setimea"" ]; then
yum clean metadata
elif [ ""$nuday = $Fri"" ] && [ ""$time2 = $setimeb"" ]; then
yum clean metadata
elif [ ""$nuday = $Fri"" ] && [ ""$time = $setimec"" ]; then
yum clean metadata
fi

# LOOKING FOR NEW UPDATES AND INSTALLING POSTINSTALLERF MAIN MENU


if [ ""$nuday = $Tue"" ]; then

if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/Postinstaller.sh
echo "Obselete file was removed, Updating file"
else
echo "Up to date did not update the file"
fi

if [ -d /usr/share/updatepostintaller/ ]; then
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/Postinstaller.sh' 
else
mkdir /usr/share/updatepostintaller/
 wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/Postinstaller.sh 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:Updates  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
fi 


diff -a $source $update
if [ $? -eq 0 ]; then
echo "The files are equal"
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF se encuentra actualizado" --timeout=5
else
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF is updated" --timeout=5
fi
 else
echo "The files are not equal"
cp -f /usr/share/updatepostintaller/Postinstaller.sh /usr/bin/ 
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF se ha actualizado 

 Por favor Reinicie PostInstallerF"
else
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF was updated 

 Please Restart PostInstallerF" 
fi
 fi

elif [ ""$nuday = $Thu"" ]; then

if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/Postinstaller.sh
echo "Obselete file was removed, Updating file"
else
echo "Up to date did not update the file"
fi

if [ -d /usr/share/updatepostintaller/ ]; then
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/Postinstaller.sh' 
else
mkdir /usr/share/updatepostintaller/
 wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/Postinstaller.sh 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:Updates  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
fi 


diff -a $source $update
if [ $? -eq 0 ]; then
echo "The files are equal"
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF se encuentra actualizado" --timeout=5
else
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF is updated" --timeout=5
fi
 else
echo "The files are not equal"
cp -f /usr/share/updatepostintaller/Postinstaller.sh /usr/bin/ 
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF se ha actualizado 

 Por favor Reinicie PostInstallerF"
else
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF was updated 

 Please Restart PostInstallerF" 
fi
 fi
fi


# UPDATING THE SYSTEM

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep2.png" --image-on-top --progress --title "Actualizando el Sistema" --text="Por favor espere...." --pulsate --auto-close --width=350
else
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Updating" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep2.png" --image-on-top --progress --title "Updating the system" --text="Please wait...." --pulsate --auto-close --width=350
fi

# COMPLETING PENDING INSTALLATION

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
yum-complete-transaction -y | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Completando Instalaciones pendientes" --text="Por favor espere...." --pulsate --auto-close --width=350
else
yum-complete-transaction -y | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Completing all installation pending." --text="Please wait...." --pulsate --auto-close --width=350
fi

# SHOWING INSTALLED UPDATES

cat /var/log/yum.log | tail -f | yad --title="Log viewer updates" --window-icon=logviewer --list --button=gtk-close --geometry 600x350 --text="Content of yum updates" --column Previous-Changes


# CHECKING SUBMENUS OF POSTINSTALLERF

if [ -f /usr/bin/PostinstallerF.sh ]; then
echo "PostinstallerF esta presente"
else
xterm -e 'wget -c -P/usr/bin/ https://raw.github.com/kuboosoft/postinstallerf/master/PostinstallerF.sh'
chmod a+x /usr/bin/PostinstallerF.sh
fi

if [ -f /usr/bin/postinstallerf/addpost.sh ]; then
echo "addpost esta presente"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/addpost.sh'
chmod a+x /usr/bin/postinstallerf/addpost.sh
fi

if [ -f /usr/bin/postinstallerf/confpost.sh ]; then
echo "confpost esta presente"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/confpost.sh'
chmod a+x /usr/bin/postinstallerf/confpost.sh
fi

if [ -f /usr/bin/postinstallerf/gnext.sh ]; then
echo "gnext esta presente"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/gnext.sh'
chmod a+x /usr/bin/postinstallerf/gnext.sh
fi

if [ -f /usr/bin/postinstallerf/Logout.sh ]; then
echo "Logout esta presente"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/Logout.sh'
chmod a+x /usr/bin/postinstallerf/Logout.sh
fi


# TESTING THE SOUND IN POSTINSTALLERF.
sound=/usr/bin/postinstallerf/sound21.ogg
if [ -f $sound ]; then
echo "sound esta presente"
else
wget -c -P/usr/bin/postinstallerf/ http://sourceforge.net/projects/postinstaller/files/data/sound21.ogg
fi

clear

# +--------------------------------------------------------------------------------------------------+
# |HERE BEGINS THE MENU                                                                              |
# +--------------------------------------------------------------------------------------------------+




P_RUN=$(yad --image="/usr/share/icons/acciones/topicon.png" --image-on-top --icons --class="PostInstallerF" --name="PostInstallerF" --window-icon="/usr/share/icons/Postinstaller1.svg" --item-width="182" --read-dir="/usr/share/Postdesktopfiles" --width="435" --height="440" --title="PostInstallerF" --auto-kill --text="\n<b>Double click</b> an item to select an action:" --button="Website:0" --button="Close:1")

if [ $? -eq 0 ]; then
	su $noti3 -c '/usr/bin/firefox http://sourceforge.net/projects/postinstaller/' &
else
	echo "Nothing to do"
	fi
	exit 0


#initialising notification

    noti3=$(loginctl show-session $XDG_SESSION_ID | cut -d= -f2 | tail -n 1); echo "noti3 = $noti3"

    #initialising change directory default log
    changelog="cd /usr/share/.postinstallerf/"


# its others alternative similar initialising other users or notification 
# noti=$(who am i | awk '{print $1}'); echo "noti = $noti"
# noti=$(who -u | awk '{print $1}'); echo "noti = $noti"
# username=$(zenity --entry --text="Username"); echo "username = $username"
