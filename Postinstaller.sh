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
# |or send an e-mail to maxmrphy@gmail.com                                         |
# +--------------------------------------------------------------------------------+
# FEDORA 17, 18, 19 POSTINSTALLER V.1.2.0 32 BITS

time=$(date +"%H")

yad --class="ATENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="

Good day, PostInstallerF is a program that installs everything you need in Fedora"



# ELIMINATING OBSOLETE VERSIONS OF POSTINSTALLERF


grep '/usr/local/bin/' /usr/share/Postdesktopfiles/Configure_Tuning.desktop
if [[ "$?" = 0 ]]; then
rm -f /usr/share/Postdesktopfiles/Configure_Tuning.desktop
fi

grep '/usr/local/bin/' /usr/share/Postdesktopfiles/GnomeShell_Extensions.desktop
if [[ "$?" = 0 ]]; then
rm -f /usr/share/Postdesktopfiles/GnomeShell_Extensions.desktop
fi

grep '/usr/local/bin/' /usr/share/Postdesktopfiles/Install.desktop
if [[ "$?" = 0 ]]; then
rm -f /usr/share/Postdesktopfiles/Install.desktop
fi

grep '/usr/local/bin/' /usr/share/Postdesktopfiles/Shutdown_Logout.desktop
if [[ "$?" = 0 ]]; then
rm -f /usr/share/Postdesktopfiles/Shutdown_Logout.desktop
fi


if test -e /usr/local/bin/Postinstaller.sh; then
echo 'A version has been detected that is obsolete. Will proceed to uninstall'
rm -f /usr/local/bin/Postinstaller.sh
fi

if test -e /usr/local/bin/Postinstaller64.sh; then
rm -f /usr/local/bin/Postinstaller64.sh
fi

if test -e /usr/local/share/updatepostintaller/Postinstaller.sh; then
rm -f /usr/local/share/updatepostintaller/Postinstaller.sh
fi

if test -e /usr/local/share/updatepostintaller/Postinstaller64.sh; then
rm -f /usr/local/share/updatepostintaller/Postinstaller64.sh
fi

if test -e /usr/local/share/updatepostintaller/PostinstallerF.sh; then
rm -f /usr/local/share/updatepostintaller/PostinstallerF.sh
fi

if test -e /usr/local/bin/postinstallerf/; then
rm -R  /usr/local/bin/postinstallerf/
fi

if test -e /usr/share/applications/Postintallerf.desktop; then
rm -f /usr/share/applications/Postintallerf.desktop
fi

if test -e /usr/share/applications/PostIntallerF.desktop; then
rm -f /usr/share/applications/PostIntallerF.desktop
fi

if test -e /usr/local/share/.postinstallerf/installed.log; then
rm -f /usr/local/share/.postinstallerf/installed.log
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

# DIRECTORIES POSTINSTALLERF

if [ -d /usr/share/icons/acciones/ ]; then
echo "The menu icons directory is present"
else
mkdir -p /usr/share/icons/acciones/
fi

if [ -d /usr/bin/postinstallerf/ ]; then
echo "Submenus directory is present"
else
mkdir -p /usr/bin/postinstallerf/
fi

if [ -d /usr/share/Postdesktopfiles ]; then
echo "Shortcuts directory is present"
else
mkdir -p /usr/share/Postdesktopfiles/
fi



# KILLING LOCK YUM
pkill -SIGKILL -u root -o yum

# CHECKING REPOSITORIES 

if [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ] && [ -f /etc/yum.repos.d/rpmfusion-free.repo ]; then
echo "RPM Fusion free and nonfree repo is present"
else

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-16.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-16.noarch.rpm 2>&1 | zenity --progress --title "Checking Repository and Adding RPMFusion" --text="Please wait ...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "17" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-17.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-17.noarch.rpm 2>&1 | zenity --progress --title "Checking Repository and Adding RPMFusion" --text="Please wait ...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm 2>&1 | zenity --progress --title "Checking Repository and Adding RPMFusion" --text="Please wait ...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-19.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-19.noarch.rpm 2>&1 | zenity --progress --title "Checking Repository and Adding RPMFusion" --text="Please wait ...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "20" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-20.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-20.noarch.rpm 2>&1 | zenity --progress --title "Checking Repository and Adding RPMFusion" --text="Please wait ...." --pulsate --auto-close --width=400
fi
 fi

if [ -f /etc/yum.repos.d/russianfedora-free.repo ]; then
echo 'Already Installed'
else
yum -y localinstall http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/fedora/russianfedora-free-release-stable.noarch.rpm 2>&1 | zenity --progress --title "Verifying and Adding 3rd Party Free Community Repos." --text="Please Wait...." --pulsate --auto-close --width=400
fi

if [ -f /etc/yum.repos.d/russianfedora-nonfree.repo ]; then
echo 'Already Installed'
else
yum -y localinstall http://mirror.yandex.ru/fedora/russianfedora/russianfedora/nonfree/fedora/russianfedora-nonfree-release-stable.noarch.rpm 2>&1 | zenity --progress --title "Verifying and Adding 3rd Party Non-Free Community Repos." --text="Please Wait...." --pulsate --auto-close --width=400
fi


if [ -f /etc/yum.repos.d/postinstallerf.repo ]; then
echo 'Postinstallerf Repository is installed'
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


# Installing Basic Dependencies for Postinstallerf

znt=/usr/bin/zenity
cu=/usr/bin/curl
wg=/usr/bin/wget
wavep=/usr/bin/playwave
yadd=/usr/bin/yad
xte=/usr/bin/xterm
wm=/usr/bin/wmctrl
pipeviewer=/usr/bin/pv
w3=/usr/bin/w3m

echo "Running Dependency Checks"

if [ -f $wm ]; then
echo "wmctrl is present"
else
yum -y install wmctrl 2>&1 | zenity --progress --title "Installing dependency : wmctrl" --text="Please Wait...." --pulsate --auto-close --width=400
fi

if [ -f $xte ]; then
echo "xterm is present"
else
yum -y install xterm 2>&1 | zenity --progress --title "Installing dependency : xterm" --text="Please Wait...." --pulsate --auto-close --width=400
fi

if [ -f $yadd ]; then
echo "yad is present"
else
if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then
yum -y localinstall http://kojipkgs.fedoraproject.org//packages/yad/0.19.1/1.fc18/i686/yad-0.19.1-1.fc18.i686.rpm 2>&1 | zenity --progress --title "instalando yad herramientas basicas del programa" --text="Porfavor espere...." --pulsate --auto-close --width=400
else
yum -y install yad 2>&1 | zenity --progress --title "Installing dependency : yad" --text="Please Wait...." --pulsate --auto-close --width=400
fi
fi

if [ -f $znt ]; then
echo "zenity is present"
else
yum -y install zenity 2>&1 | zenity --progress --title "Installing dependency : zenity" --text="Please Wait...." --pulsate --auto-close --width=400
fi

if [ -f $cu ]; then
echo "curl is present"
else
yum -y install curl 2>&1 | zenity --progress --title "Installing dependency : curl" --text="Please Wait...." --pulsate --auto-close --width=400
fi

if [ -f $wg ]; then
echo "wget is present"
else
yum -y install wget 2>&1 | zenity --progress --title "Installing dependency : wget" --text="Please Wait...." --pulsate --auto-close --width=400
fi

if [ -f $wavep ]; then
echo "SDL_mixer is present"
else
yum -y install SDL_mixer 2>&1 | zenity --progress --title "Installing dependency : SDL_mixer" --text="Please Wait...." --pulsate --auto-close --width=400
fi


if [ -f $pipeviewer ]; then
echo "Pipe Viewer is present"
else
yum -y install pv 2>&1 | zenity --progress --title "Installing dependency : Pipe Viewer" --text="Please Wait...." --pulsate --auto-close --width=400
fi

if [ -f $w3 ]; then
echo "w3m is present"
else
yum -y install w3m 2>&1 | zenity --progress --title "Installing dependency : w3m" --text="Please Wait...." --pulsate --auto-close --width=400
fi


wait ${!}


# Cleaning the repository metadata.

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
    yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF is updated" --timeout=5
else
    echo "The files are not equal"
    cp -f /usr/share/updatepostintaller/Postinstaller.sh /usr/bin/ 
    yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF was updated 

    Please Restart PostInstallerF" 
fi

elif [ ""$nuday = $Thu"" ]; then

if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/Postinstaller.sh
echo "Obselete file was removed, updating"
else
echo "File up to date, not updating"
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
    yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF is updated" --timeout=5
else
    echo "The files are not equal"
    cp -f /usr/share/updatepostintaller/Postinstaller.sh /usr/bin/ 
    yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF was updated 
    Please Restart PostInstallerF" 
fi

fi


# UPDATING THE SYSTEM

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Updating" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep2.png" --image-on-top --progress --title "Updating the System" --text="Please wait...." --pulsate --auto-close --width=350


# COMPLETING PENDING INSTALLATION

yum-complete-transaction -y | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Completeing all pending isntallations" --text="Please wait...." --pulsate --auto-close --width=350


# Showing Installed Updates

cat /var/log/yum.log | tail -f | yad --title="Log viewer updates" --window-icon=logviewer --list --button=gtk-close --geometry 600x350 --text="Content of yum updates" --column Previous-Changes


# Verifing the postinstallerf icons.
icon1='/usr/share/icons/sistema.png'
icon2='/usr/share/icons/pinguino.png'
icon3='/usr/share/icons/pincel_rco.png'
icon4='/usr/share/icons/user-trash-full.png'
icon5='/usr/share/icons/camera.png'
icon6='/usr/share/icons/acciones/add.png'
icon7='/usr/share/icons/acciones/conf.png'
icon8='/usr/share/icons/acciones/gnomestension.svg'
icon9='/usr/share/icons/acciones/system-shutdown.svg'
icon010='/usr/share/icons/acciones/topicon.png'
icon011='/usr/share/icons/Postinstaller1.svg'
icon012='/usr/share/icons/icoinstall2.png'
icon013='/usr/share/icons/brightness.png'
icon014='/usr/share/icons/updatep2.png'
icon015='/usr/share/icons/updatep.png'
icon016='/usr/share/icons/trashito.png'

if test -e $icon1; then
	echo "The file $icon1 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/sistema.png
fi

if test -e $icon2; then
	echo "The file $icon2 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/pinguino.png
fi

if test -e $icon3; then
	echo "The file $icon3 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/pincel_rco.png
fi

if test -e $icon4; then
	echo "The file $icon4 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/user-trash-full.png
fi

if test -e $icon5; then
	echo "The file $icon5 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/camera.png
fi

if test -e $icon6; then
	echo "The file $icon6 is here."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/add.png
fi

if test -e $icon7; then
	echo "The file $icon7 is here."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/conf.png
fi

if test -e $icon8; then
	echo "The file $icon8 is here."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/gnomestension.svg
fi

if test -e $icon9; then
	echo "The file $icon9 is here."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/system-shutdown.svg
fi

if test -e $icon010; then
	echo "The file $icon010 is here."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/topicon.png
fi

if test -e $icon011; then
	echo "The file $icon011 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/Postinstaller1.svg
fi

if test -e $icon012; then
	echo "The file $icon012 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/icoinstall2.png
fi

if test -e $icon013; then
	echo "The file $icon013 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/brightness.png
fi

if test -e $icon014; then
	echo "The file $icon014 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/updatep2.png
fi

if test -e $icon015; then
	echo "The file $icon015 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/updatep.png
fi

if test -e $icon016; then
	echo "The file $icon016 is here."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/trashito.png
fi
 

# CHECKING SUBMENUS OF POSTINSTALLERF

if [ -f /usr/bin/PostinstallerF.sh ]; then
echo "PostinstallerF is present"
else
xterm -e 'wget -c -P/usr/bin/ https://raw.github.com/kuboosoft/postinstallerf/master/PostinstallerF.sh'
chmod a+x /usr/bin/PostinstallerF.sh
fi

if [ -f /usr/bin/postinstallerf/addpost.sh ]; then
echo "addpost is present"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/addpost.sh'
chmod a+x /usr/bin/postinstallerf/addpost.sh
fi

if [ -f /usr/bin/postinstallerf/confpost.sh ]; then
echo "confpost is present"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/confpost.sh'
chmod a+x /usr/bin/postinstallerf/confpost.sh
fi

if [ -f /usr/bin/postinstallerf/gnext.sh ]; then
echo "gnext is present"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/gnext.sh'
chmod a+x /usr/bin/postinstallerf/gnext.sh
fi

if [ -f /usr/bin/postinstallerf/Logout.sh ]; then
echo "Logout is present"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/Logout.sh'
chmod a+x /usr/bin/postinstallerf/Logout.sh
fi



# CHECKING POSTINSTALLERF LAUNCHERS

desktop1=/usr/share/Postdesktopfiles/Configure_Tuning.desktop
desktop2=/usr/share/Postdesktopfiles/GnomeShell_Extensions.desktop
desktop3=/usr/share/Postdesktopfiles/Install.desktop
desktop4=/usr/share/Postdesktopfiles/Shutdown_Logout.desktop


if test -e /usr/share/applications/postintallerf.desktop; then
echo 'There is a desktop file for postinstallerf'
else
echo '[Desktop Entry]
Version=1.0.1
Type=Application
Terminal=false
Name=PostIntallerF
Exec=/usr/bin/PostinstallerF.sh
Comment=Install all necessary, after to run first time Fedora
Comment[es]= Instala todo lo que necesitas en Fedora
Icon=/usr/share/icons/Postinstaller1.svg
Categories=GTK;Utility;System;' >> /usr/share/applications/postinstallerf.desktop
fi

if [ -f $desktop1 ]; then
echo "Configure_Tuning"
else
wget -c -P/usr/share/Postdesktopfiles/ http://sourceforge.net/projects/postinstaller/files/desktop/Configure_Tuning.desktop
chmod +x /usr/share/Postdesktopfiles/Configure_Tuning.desktop

if [ -f $desktop2 ]; then
echo "GnomeShell_Extensions"
else
wget -c -P/usr/share/Postdesktopfiles/ http://sourceforge.net/projects/postinstaller/files/desktop/GnomeShell_Extensions.desktop
chmod +x /usr/share/Postdesktopfiles/GnomeShell_Extensions.desktop

if [ -f $desktop3 ]; then
echo "Install is present"
else
wget -c -P/usr/share/Postdesktopfiles/ http://sourceforge.net/projects/postinstaller/files/desktop/Install.desktop
chmod +x /usr/share/Postdesktopfiles/Install.desktop

if [ -f $desktop4 ]; then
echo "Shutdown_Logout is present"
else
wget -c -P/usr/share/Postdesktopfiles/ http://sourceforge.net/projects/postinstaller/files/desktop/Shutdown_Logout.desktop
chmod +x /usr/share/Postdesktopfiles/Shutdown_Logout.desktop
fi
  fi
 fi
fi

# Testing the sounds in postinstallerf.
sound=/usr/bin/postinstallerf/sound21.ogg
if [ -f $sound ]; then
echo "sound is present"
else
wget -c -P/usr/bin/postinstallerf/ http://sourceforge.net/projects/postinstaller/files/data/sound21.ogg
fi

clear

# +--------------------------------------------------------------------------------------------------+
# |HERE BEGINS THE MENU                                                                            |
# +--------------------------------------------------------------------------------------------------+




P_RUN=$(yad --image="/usr/share/icons/acciones/topicon.png" --image-on-top --icons --class="PostInstallerF" --name="PostInstallerF" --window-icon="/usr/share/icons/Postinstaller1.svg" --item-width="182" --read-dir="/usr/share/Postdesktopfiles" --width="435" --height="440" --title="PostInstallerF" --auto-kill --text="\n<b>Double click</b> an item to select an action:" --button="Website:0" --button="Close:1")

if [ $? -eq 0 ]; then
	su $noti3 -c '/usr/bin/firefox http://sourceforge.net/projects/postinstaller/'
else
	echo "Nothing to do"
	fi
	exit 0


#initialising notification
    noti=$(who -u | awk '{print $1}'); echo "noti = $noti"
    noti3=$(loginctl show-session $XDG_SESSION_ID | cut -d= -f2 | tail -n 1); echo "noti3 = $noti3"

    #initialising change directory default log
    changelog="cd /usr/share/.postinstallerf/"


# its others alternative similar initialising other users or notification 
# noti=$(who am i | awk '{print $1}'); echo "noti = $noti"
# username=$(zenity --entry --text="Username"); echo "username = $username"
