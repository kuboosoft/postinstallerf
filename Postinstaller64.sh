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
# FEDORA 17, 18, 19 POSTINSTALLER V.1.2.0 64 BITS

yad --class="ATENTION" --window-icon="/usr/share/icons/acciones/topicon.png"` --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="

Hello, PostInstallerF is a program that installs everything you need in Fedora"


# Removing Obselete Versions of Postinstallerf


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
echo 'Se detecto una version obsoleta, se procedera a desinstalalar'
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


# DIRECTORIO Y ARCHIVO LOG

if [ -d /usr/share/.postinstallerf/ ]; then
cd /usr/share/.postinstallerf/
echo "el directorio log existe" >> installed.log
else
mkdir -p /usr/share/.postinstallerf/
cd /usr/share/.postinstallerf/
echo "no existia directorio log" >> installed.log 
fi

# DIRECTORIOS DE POSTINSTALLERF

if [ -d /usr/share/icons/acciones/ ]; then
echo "El directorio de iconos del menu esta presente"
else
mkdir -p /usr/share/icons/acciones/
fi

if [ -d /usr/bin/postinstallerf/ ]; then
echo "directorio submenus esta presente"
else
mkdir -p /usr/bin/postinstallerf/
fi

if [ -d /usr/share/Postdesktopfiles64/ ]; then
echo "directorio accesos directos esta presente"
else
mkdir -p /usr/share/Postdesktopfiles64/
fi


# MATANDO BLOQUEO DE YUM
pkill -SIGKILL -u root -o yum

# VERIFICANDO REPOSITORIOS Y ACTUALIZANDO EL SISTEMA
if [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ] && [ -f /etc/yum.repos.d/rpmfusion-free.repo ]; then
echo "RPM Fusion free y nonfree repo esta presente"
else

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-16.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-16.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "17" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-17.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-17.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-19.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-19.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "20" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-20.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-20.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=400
fi
 fi

if [ -f /etc/yum.repos.d/russianfedora-free.repo ]; then
echo 'ya esta instalado'
else
yum -y localinstall http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/fedora/russianfedora-free-release-stable.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorios Community 3rd party Free" --text="Por favor espere...." --pulsate --auto-close --width=400
fi

if [ -f /etc/yum.repos.d/russianfedora-nonfree.repo ]; then
echo 'ya esta instalado'
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
 
# INSTALANDO DEPENDENCIAS BASICAS DE POSTINSTALLERF

znt=/usr/bin/zenity
cu=/usr/bin/curl
wg=/usr/bin/wget
wavep=/usr/bin/playwave
yadd=/usr/bin/yad
gl=/sbin/ldconfig
xte=/usr/bin/xterm
wm=/usr/bin/wmctrl
pipeviewer=/usr/bin/pv
w3=/usr/bin/w3m



if [ -f $wm ]; then
echo "wmctrl esta presente"
else
yum -y install wmctrl 2>&1 | zenity --progress --title "instalando wmctrl herramientas basicas del programa" --text="Por favor espere...." --pulsate --auto-close --width=400
fi

if [ -f $xte ]; then
echo "xterm esta presente"
else
yum -y install xterm 2>&1 | zenity --progress --title "instalando xterm herramientas basicas del programa" --text="Por favor espere...." --pulsate --auto-close --width=400
fi

if [ -f $yadd ]; then
echo "yad esta presente"
else
if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then
yum -y localinstall http://kojipkgs.fedoraproject.org//packages/yad/0.19.1/1.fc18/x86_64/yad-0.19.1-1.fc18.x86_64.rpm 2>&1 | zenity --progress --title "instalando yad herramientas basicas del programa" --text="Porfavor espere...." --pulsate --auto-close --width=400
else
yum -y install yad 2>&1 | zenity --progress --title "instalando yad herramientas basicas del programa" --text="Porfavor espere...." --pulsate --auto-close --width=400
fi
fi

if [ -f $znt ]; then
echo "zenity esta presente"
else
yum -y install zenity 2>&1 | zenity --progress --title "instalando zenity herramientas basicas del programa" --text="Por favor espere...." --pulsate --auto-close --width=400
fi

if [ -f $cu ]; then
echo "curl esta presente"
else
yum -y install curl 2>&1 | zenity --progress --title "instalando curl herramientas basicas del programa" --text="Por favor espere...." --pulsate --auto-close --width=400
fi

if [ -f $wg ]; then
echo "wget esta presente"
else
yum -y install wget 2>&1 | zenity --progress --title "instalando wget herramientas basicas del programa" --text="Por favor espere...." --pulsate --auto-close --width=400
fi


if [ -f $wavep ]; then
echo "SDL_mixer esta presente"
else
yum -y install SDL_mixer 2>&1 | zenity --progress --title "instalando SDL_mixer como dependencia basica del programa" --text="Por favor espere...." --pulsate --auto-close --width=400
fi


if [ -f $gl ]; then
echo "glibc esta presente"
else
yum -y install glibc.i686 glibc-devel.i686
fi

if [ -f $pipeviewer ]; then
echo "Pipe Viewer esta presente"
else
yum -y install pv 2>&1 | zenity --progress --title "instalando Pipe Viewer como dependencia basica del programa" --text="Por favor espere...." --pulsate --auto-close --width=400
fi

if [ -f $w3 ]; then
echo "w3m esta presente"
else
yum -y install w3m 2>&1 | zenity --progress --title "instalando w3m como dependencia basica del programa" --text="Por favor espere...." --pulsate --auto-close --width=400
fi


wait ${!}


# LIMPIANDO METADATOS EN REPOSITORIOS

updater=/usr/share/updatepostintaller/Postinstaller64.sh
source=/usr/bin/Postinstaller64.sh
update=/usr/share/updatepostintaller/Postinstaller64.sh

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

# BUSCANDO E INSTALANDO NUEVAS ACTUALIZACIONES MENU PRINCIPAL DE POSTINSTALLERF


if [ ""$nuday = $Tue"" ]; then
if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/Postinstaller64.sh
echo "se elimino el archivo obsoleto de actualizacion"
else
echo "Aun no se ha descargado el archivo de actualizacion"
fi

if [ -d /usr/share/updatepostintaller/ ]; then
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/Postinstaller64.sh'
else
mkdir /usr/share/updatepostintaller/
 wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/Postinstaller64.sh 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:Updates  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
fi 

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF se encuentra actualizado" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/Postinstaller64.sh /usr/bin/ 
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF se ha actualizado

 Por favor Reinicie PostInstallerF" 

fi
else
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF is updated" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/Postinstaller64.sh /usr/bin/ 
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF was updated 

 Please Restart PostInstallerF" 

fi
fi

elif [ ""$nuday = $Thu"" ]; then

if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/Postinstaller64.sh
echo "se elimino el archivo obsoleto de actualizacion"
else
echo "Aun no se ha descargado el archivo de actualizacion"
fi

if [ -d /usr/share/updatepostintaller/ ]; then
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/Postinstaller64.sh'
else
mkdir /usr/share/updatepostintaller/
 wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/Postinstaller64.sh 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:Updates  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
fi 


if [ $(echo $LANG | cut -b1-2) = "es" ]; then
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF se encuentra actualizado" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/Postinstaller64.sh /usr/bin/ 
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF se ha actualizado

 Por favor Reinicie PostInstallerF" 

fi
else
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF is updated" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/Postinstaller64.sh /usr/bin/ 
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="PostInstallerF was updated 

 Please Restart PostInstallerF" 

fi
fi

fi



# ACTUALIZANDO EL SISTEMA

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep2.png" --image-on-top --progress --title "Actualizando el Sistema" --text="Por favor espere...." --pulsate --auto-close --width=350
else
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Updating" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep2.png" --image-on-top --progress --title "Updating the system" --text="Please wait...." --pulsate --auto-close --width=350
fi


# COMPLETANDO INSTALACIONES PENDIENTES

yum-complete-transaction -y | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Completando Instalaciones pendientes" --text="Por favor espere...." --pulsate --auto-close --width=350

# MOSTRAR LAS ULTIMAS ACTUALIZACIONES INSTALADAS

cat /var/log/yum.log | tail -f | yad --title="Log viewer updates" --window-icon=logviewer --list --button=gtk-close --geometry 600x350 --text="Content of yum updates" --column Previous-Changes


# VERIFICANDO ICONOS DE POSTINSTALLERF
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
	echo "El archivo $icon1 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/sistema.png
fi

if test -e $icon2; then
	echo "El archivo $icon2 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/pinguino.png
fi

if test -e $icon3; then
	echo "El archivo $icon3 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/pincel_rco.png
fi

if test -e $icon4; then
	echo "El archivo $icon4 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/user-trash-full.png
fi

if test -e $icon5; then
	echo "El archivo $icon5 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/camera.png
fi

if test -e $icon6; then
	echo "El archivo $icon6 si existe."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/add.png
fi

if test -e $icon7; then
	echo "El archivo $icon7 si existe."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/conf.png
fi

if test -e $icon8; then
	echo "El archivo $icon8 si existe."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/gnomestension.svg
fi

if test -e $icon9; then
	echo "El archivo $icon9 si existe."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/system-shutdown.svg
fi

if test -e $icon010; then
	echo "El archivo $icon010 si existe."
else
wget -c -P/usr/share/icons/acciones/ http://sourceforge.net/projects/postinstaller/files/Icons/topicon.png
fi

if test -e $icon011; then
	echo "El archivo $icon011 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/Postinstaller1.svg
fi

if test -e $icon012; then
	echo "El archivo $icon012 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/icoinstall2.png
fi

if test -e $icon013; then
	echo "El archivo $icon013 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/brightness.png
fi

if test -e $icon014; then
	echo "El archivo $icon014 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/updatep2.png
fi

if test -e $icon015; then
	echo "El archivo $icon015 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/updatep.png
fi

if test -e $icon016; then
	echo "El archivo $icon016 si existe."
else
wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/trashito.png
fi
 

# VERIFICANDO SUBMENUS DE POSTINSTALLERF

if [ -f /usr/bin/PostinstallerF.sh ]; then
echo "PostinstallerF esta presente"
else
xterm -e 'wget -c -P/usr/bin/ https://raw.github.com/kuboosoft/postinstallerf/master/PostinstallerF.sh'
chmod a+x /usr/bin/PostinstallerF.sh
fi

if [ -f /usr/bin/postinstallerf/addpost64.sh ]; then
echo "addpost esta presente"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/addpost64.sh'
chmod a+x /usr/bin/postinstallerf/addpost64.sh
fi


if [ -f /usr/bin/postinstallerf/confpost64.sh ]; then
echo "confpost esta presente"
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/confpost64.sh'
chmod a+x /usr/bin/postinstallerf/confpost64.sh
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



# VERIFICANDO LAZADORES DE POSTINSTALLERF


desktop1=/usr/share/Postdesktopfiles/Configure_Tuning.desktop
desktop2=/usr/share/Postdesktopfiles/GnomeShell_Extensions.desktop
desktop3=/usr/share/Postdesktopfiles/Install.desktop
desktop4=/usr/share/Postdesktopfiles/Shutdown_Logout.desktop

if test -e /usr/share/applications/postintallerf.desktop; then
echo 'existe el acceso directo de postinstallerf'
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
echo "desktop1 esta presente"
else
wget -c -P/usr/share/Postdesktopfiles/ http://sourceforge.net/projects/postinstaller/files/desktop64/Configure_Tuning.desktop
chmod +x /usr/share/Postdesktopfiles/Configure_Tuning.desktop

if [ -f $desktop2 ]; then
echo "desktop2 esta presente"
else
wget -c -P/usr/share/Postdesktopfiles/ http://sourceforge.net/projects/postinstaller/files/desktop/GnomeShell_Extensions.desktop
chmod +x /usr/share/Postdesktopfiles/GnomeShell_Extensions.desktop

if [ -f $desktop3 ]; then
echo "desktop3 esta presente"
else
wget -c -P/usr/share/Postdesktopfiles/ http://sourceforge.net/projects/postinstaller/files/desktop64/Install.desktop
chmod +x /usr/share/Postdesktopfiles/Install.desktop

if [ -f $desktop4 ]; then
echo "desktop4 esta presente"
else
wget -c -P/usr/share/Postdesktopfiles/ http://sourceforge.net/projects/postinstaller/files/desktop/Shutdown_Logout.desktop
chmod +x /usr/share/Postdesktopfiles/Shutdown_Logout.desktop
fi
  fi
 fi
fi

# VERIFICANDO SONIDOS DE POSTINSTALLERF
sound=/usr/bin/postinstallerf/sound21.ogg
if [ -f $sound ]; then
echo "sound esta presente"
else
wget -c -P/usr/bin/postinstallerf/ http://sourceforge.net/projects/postinstaller/files/data/sound21.ogg
fi


clear

# +--------------------------------------------------------------------------------------------------+
# |AQUI INICIA EL MENU                                                                               |
# +--------------------------------------------------------------------------------------------------+




P_RUN=$(yad --image="/usr/share/icons/acciones/topicon.png" --image-on-top --icons --class="PostInstallerF" --name="PostInstallerF" --window-icon="/usr/share/icons/Postinstaller1.svg" --item-width="182" --read-dir="/usr/share/Postdesktopfiles64" --width="435" --height="440" --title="PostInstallerF" --auto-kill --text="\n<b>Double click</b> an item to select an action:" --button="Website:0" --button="Close:1")

if [ $? -eq 0 ]; then
	su $noti3 -c '/usr/bin/firefox http://sourceforge.net/projects/postinstaller/'
else
	echo "nada que hacer"
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
