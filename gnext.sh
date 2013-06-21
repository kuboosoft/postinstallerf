#!/bin/bash
#
# +--------------------------------------------------------------------------------+
# | Copyright (C) 2012 Kuboosoft                                                   |
# |                                                                                |
# | Este programa es Software Libre; Puedes distribuirlo y/o                       |
# | modificarlo bajo los términos de la GNU General Public License                 |
# | como está publicada por la Free Software Foundation; cualquier                 |
# | versión 3 de la Licencia, o (opcionalmente) cualquier versión                  |
# | posterior. http://www.gnu.org/licenses/lgpl.html                               |
# |                                                                                |
# | Este programa es distribuido con la esperanza de que sea útil,                 |
# | pero SIN NINGUNA GARANTÍA. Vea la GNU General Public License                   |
# | para más detalles.                                                             |
# +--------------------------------------------------------------------------------+
# | Este código ha sido diseñado,escrito y mantenido por Kuboode y David Vásquez   |
# | Cualquier pregunta, comentario o consejo sobre este código                     |
# | debe dirigirse a:                                                              |
# | http:www.kuboosoft.blogspot.com                                                |
# +--------------------------------------------------------------------------------+
# FEDORA 17, 18 Y 19 gnext 1.2.0

# ACTUALIZACION DE CONFPOST
updater=/usr/share/updatepostintaller/gnext.sh
if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/gnext.sh
echo "se elimino el archivo obsoleto de actualizacion"
else
echo "Aun no se ha descargado el archivo de actualizacion"
fi

if [ -d /usr/share/updatepostintaller/ ]; then
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/gnext.sh'
else
mkdir /usr/share/updatepostintaller/
 wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/gnext.sh 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:Updates [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
fi 

source=/usr/bin/postinstallerf/gnext.sh
update=/usr/share/updatepostintaller/gnext.sh

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
zenity --info --text "Gnome Extensions se encuentra actualizado" --title "PostInstallerF" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/gnext.sh /usr/bin/postinstallerf/ 
zenity --info --text "Gnome Extensions se ha actualizado
Por favor Reinicie Gnome Extensions" --title "PostInstallerF" --timeout=5
fi
 else
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
zenity --info --text "Gnome Extensions is updated" --title "PostInstallerF" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/gnext.sh /usr/bin/postinstallerf/ 
zenity --info --text "Gnome Extensions was updated
Please Restart Gnome Extensions" --title "PostInstallerF" --timeout=5
fi
fi


if [ -f /usr/bin/postinstallerf/gnextnav.py ]; then
echo 'ya se encuentra gnextnav'
else
xterm -e 'wget -c -P/usr/bin/postinstallerf/ https://raw.github.com/kuboosoft/postinstallerf/master/gnextnav.py'
fi

if [ -f /usr/share/pywebkitgtk/defs/webkit-base-types.defs ]; then
echo 'ya existe WebKit-gtk'
else
yum -y install pywebkitgtk | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing WebKit-gtk" --text="Please wait...." --pulsate --auto-close --width=350
fi



# +--------------------------------------------------------------------------------------------------+
# |AQUI INICIA EL MENU                                                                               |
# +--------------------------------------------------------------------------------------------------+

    generateInstallMenu(){ 
            im="yad --image="/usr/share/icons/acciones/gnomestension.svg" --image-on-top --class="Gnome-Extensions" --window-icon="/usr/share/icons/acciones/gnomestension.svg" --list --checklist  --width=800 --height=600 --title \"PostInstallerF for Fedora 32bit and 64bit (Ver 1.2.0)\" --text \"Select items from the list below\" "
            im=$im"--column=\"\" --column \"Application\" --column \"Description\"    --column \"Status\"                           "

 # Building Install Menue

if [ $(echo $LANG | cut -b1-2) = "es" ]; then

        if ! $installed | grep "Gnome Extensions" > /dev/null;
 then

if [ -f /usr/bin/postinstallerf/gnextnav.py ]; then

                    im=$im"FALSE \"Gnome Extensions\"    \"GNOME Shell extensiones son pequeñas piezas de código escrito por los desarrolladores de terceros que modifican la forma de GNOME funciona\" \"ACTIVO  \"  "
else
im=$im"FALSE \"Gnome Extensions\"    \"GNOME Shell extensiones son pequeñas piezas de código escrito por los desarrolladores de terceros que modifican la forma de GNOME funciona\" \"NO ACTIVO  \""
fi
 fi

if ! $installed | grep "Extension-Common" > /dev/null;
 then
if [ -d /usr/share/doc/gnome-shell-extension-common-*/ ]; then
im=$im"FALSE \"Extension-Common\"    \"Extensiones comunes, para Gnome Shell.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Extension-Common\"    \"Extensiones comunes, para Gnome Shell.\" \"NO INSTALADO  \"  "
fi
 fi



 else


if ! $installed | grep "Gnome Extensions" > /dev/null;
 then
if [ -f /usr/bin/postinstallerf/gnextnav.py ]; then
im=$im"FALSE \"Gnome Extensions\"    \"GNOME Shell provides core user interface functions for GNOME, like switching to windows and launching applications.\" \"ACTIVE  \"  "
else
im=$im"FALSE \"Gnome Extensions\"    \"GNOME Shell provides core user interface functions for GNOME, like switching to windows and launching applications.\" \"NO ACTIVE  \""
fi 
 fi

if ! $installed | grep "Extension-Common" > /dev/null;
 then
if [ -d /usr/share/doc/gnome-shell-extension-common-*/ ]; then
im=$im"FALSE \"Extension-Common\"    \"Common extensions for Gnome Shell.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Extension-Common\"    \"Common extensions for Gnome Shell.\" \"NO INSTALLED  \"  "
fi
 fi



fi

    }


chooseInstalls(){
     
            #choosing witch installs/tweaks to run
            echo "Running Choice Menu..."
            choice=`echo $im | sh -`
           
     
if echo $choice | grep "Gnome Extensions" > /dev/null; then
                    Extensions
            fi


if echo $choice | grep "Extension-Common" > /dev/null; then
                    common
            fi


    }
     
     
    ##
    ## Tweak/Install functions
    ##

     
Extensions(){     
            su $noti -c 'python /usr/bin/postinstallerf/gnextnav.py'

su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Gnome Extensions" -i "/usr/share/icons/pinguino.png" -t 5000'

    }



common(){     
            yum -y install gnome-shell-extension-common

su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Extension-Common" -i "/usr/share/icons/pinguino.png" -t 5000'

    }

     
     
    ##
    ## Initialising PostInstallerF
    ##


    installed="cat /usr/share/.postinstallerf/installed.log"
    cd /usr/share/.postinstallerf
     
    #initialising yum install-list
    yumList="yum -y install "
     
    #initialising post-yum job list
    postYum=""
     
    #initialising post-yum job list
    postRoot="exit; "
     
    #initialising notification
    noti=$(logname); echo "noti = $noti"
    noti3=$(loginctl show-session $XDG_SESSION_ID | cut -d= -f2 | tail -n 1); echo "noti3 = $noti3"

    #initialising change directory default log
    changelog="cd /usr/share/.postinstallerf/"


# its others alternative similar initialising other users or notification 
# noti=$(who am i | awk '{print $1}'); echo "noti = $noti"
# username=$(zenity --entry --text="Username"); echo "username = $username"


# running PostInstallerF...
    generateInstallMenu
    chooseInstalls
     
    
     
     
    #runing yum and post-yum commands
    if test ${#yumList} -gt 15; then
            echo "Installing selected packages [yum]..."
            echo $yumList | sh -
            #| zenity --progress --pulsate --auto-close --text "Installing selected packages..."
    fi
    if test ${#postYum} -gt 0; then
            echo "Runing post install scripts..."
            echo $postYum | sh -
    fi
    if test ${#postRoot} -gt 6; then
            echo "Runing post root scripts..."
            echo $postRoot | sh -
    fi
     
    #if there was something to do
    if test ${#choice} -gt 0; then
       /usr/bin/paplay /usr/bin/postinstallerf/sound21.ogg
       su $noti -c 'notify-send "Terminado!" "Todo está completado, visita http://www.kuboosoft.blogspot.com" -i "/usr/share/icons/pinguino.png" -t 10000'
       
            
    fi

     
    exit 0
