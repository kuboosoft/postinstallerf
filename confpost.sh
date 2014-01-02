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
# FEDORA 17, 18 y 19 CONFPOST 1.2.0 32 BITS

# ACTUALIZACION DE CONFPOST
updater=/usr/share/updatepostintaller/confpost.sh
if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/confpost.sh
echo "se elimino el archivo obsoleto de actualizacion"
else
echo "Aun no se ha descargado el archivo de actualizacion"
fi

if [ -d /usr/share/updatepostintaller/ ]; then
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/confpost.sh'
else
mkdir /usr/share/updatepostintaller/
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/confpost.sh' 
fi 

source=/usr/bin/postinstallerf/confpost.sh
update=/usr/share/updatepostintaller/confpost.sh

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
zenity --info --text "Configure se encuentra actualizado" --title "PostInstallerF" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/confpost.sh /usr/bin/postinstallerf/ 
zenity --info --text "Configure se ha actualizado
Por favor Reinicie Configure" --title "PostInstallerF" --timeout=5
fi
 else
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
zenity --info --text "Configure is updated" --title "PostInstallerF" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/confpost.sh /usr/bin/postinstallerf/ 
zenity --info --text "Configure was updated
Please Restart Configure" --title "PostInstallerF" --timeout=5
fi
fi



# +--------------------------------------------------------------------------------------------------+
# |AQUI INICIA EL MENU                                                                               |
# +--------------------------------------------------------------------------------------------------+

    generateInstallMenu(){ 
            im="yad --image="/usr/share/icons/acciones/conf.png" --image-on-top --class="Configure-Tuning" --window-icon="/usr/share/icons/acciones/conf.png" --list --radiolist  --width=800 --height=600 --title \"PostInstallerF for Fedora 32bit (Ver 1.2.0)\" --text \"Select items from the list below\" "
            im=$im"--column=\"\" --column \"Application\" --column \"Description\"    --column \"Status\"  		     "

 # Building Install Menue

            # Building Install Menue

if [ $(echo $LANG | cut -b1-2) = "es" ]; then


if ! $installed | grep "Activar sudo" > /dev/null; then

SER=$(grep "$noti3 ALL=(ALL) ALL" /etc/sudoers) > /dev/null
	if [[ "$?" != 0 ]]; then

                    im=$im"FALSE \"Activar sudo\"    \"Permite a un administrador del sistema delegar autoridad a ciertos usuarios la capacidad de ejecutar comandos como root u otro usuario\" \"[$noti3] NO AGREGADO  \"  "
else
                    im=$im"FALSE \"Activar sudo\"    \"Permite a un administrador del sistema delegar autoridad a ciertos usuarios la capacidad de ejecutar comandos como root u otro usuario\" \"[$noti3] AGREGADO  \"  "
fi
            fi

if ! $installed | grep "Activar Touchpad" > /dev/null; then

if [ -f /etc/X11/xorg.conf.d/50-synaptics.conf ]; then

                    im=$im"FALSE \"Activar Touchpad\"    \"Habilita el Touchpad desde el arranque\" \"ACTIVO  \"  "
else
                    im=$im"FALSE \"Activar Touchpad\"    \"Habilita el Touchpad desde el arranque\" \"NO ACTIVO  \"  "
fi
            fi


if ! $installed | grep "Control de brillo" > /dev/null; then

vacio=$(ls -a /sys/class/backlight/ | wc -w); echo vacio=$vacio

if [ $vacio -eq 2 ]; then

                    im=$im"FALSE \"Control de brillo\"    \"Cambia la intensidad de brillo de tu monitor o pantalla de tu laptop\" \"NO ACTIVO  \"  "
else
im=$im"FALSE \"Control de brillo\"    \"Cambia la intensidad de brillo de tu monitor o pantalla de tu laptop\" \"ACTIVO  \"  "
fi

            fi

if ! $installed | grep "Periodo de gracia sudo" > /dev/null; then

enablesu="Defaults:ALL timestamp_timeout=0"
krozker=$(grep "Defaults:ALL timestamp_timeout=0" /etc/sudoers); echo "krozker = $krozker"
disablesu=""

if [ "$krozker" = "$enablesu" ]; then 
im=$im"FALSE \"Periodo de gracia sudo\"    \"Credenciales para permitir/no permitir al usuario ejecutar sudo de nuevo por un período de tiempo sin necesidad de autenticación.\" \"NO ACTIVADO  \"  "
elif [ "$krozker" = "$disablesu" ]; then
im=$im"FALSE \"Periodo de gracia sudo\"    \"Credenciales para permitir/no permitir al usuario ejecutar sudo de nuevo por un período de tiempo sin necesidad de autenticación.\" \"ACTIVADO  \"  "
fi
 fi

           
if ! $installed | grep "Cambiar Mozilla Firefox a español" > /dev/null; then

if [ -f /usr/bin/firefox ]; then

                    im=$im"FALSE \"Cambiar Mozilla Firefox a español\"    \"Cambia el lenguage de Firefox actual a español, desde la version 12\" \"ACTIVO  \"  "
else
                    im=$im"FALSE \"Cambiar Mozilla Firefox a español\"    \"Cambia el lenguage de Firefox actual a español, desde la version 12\" \"NO ACTIVO  \"  "
fi
            fi


if ! $installed | grep "Eliminar Kernels Antiguos" > /dev/null; then

if [ -f /usr/bin/yum ]; then

                    im=$im"FALSE \"Eliminar Kernels Antiguos\"    \"Limpia kernels obsoletos\" \"ACTIVO  \"  "
else
                    im=$im"FALSE \"Eliminar Kernels Antiguos\"    \"Limpia kernels obsoletos\" \"NO ACTIVO  \"  "
fi
            fi



if ! $installed | grep "Completar Instalaciones pendientes" > /dev/null; then

if [ -f /usr/bin/yum ]; then

                    im=$im"FALSE \"Completar Instalaciones pendientes\"    \"Continua instalaciones no completadas por errores del sistema\" \"ACTIVO  \"  "
else
im=$im"FALSE \"Completar Instalaciones pendientes\"    \"Continua instalaciones no completadas por errores del sistema\" \"NO ACTIVO  \"  "
fi

            fi


if ! $installed | grep "Informacion del Sistema" > /dev/null; then
                    im=$im"FALSE \"Informacion del Sistema\"    \"Muestra la informacion del sistema\" \"ACTIVO  \"  "

            fi


if ! $installed | grep "Cinnamon" > /dev/null; then
if [ -x /usr/share/doc/cinnamon* ]; then
                    im=$im"FALSE \"Cinnamon\"    \"Shell para Gnome 3, Diseño tradicional, funciones avanzadas y fáciles de usar, potente y flexible\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Cinnamon\"    \"Shell para Gnome 3, Diseño tradicional, funciones avanzadas y fáciles de usar, potente y flexible\" \"NO INSTALADO  \"  "
fi

            fi


if ! $installed | grep "Plasma-wallpaper-dreamdesktop" > /dev/null; then
if [ -f /usr/lib/kde4/dreamdesktop.so ]; then
                    im=$im"FALSE \"Plasma-wallpaper-dreamdesktop\"    \"Un innovador fondo de escritorio animado para KDE.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Plasma-wallpaper-dreamdesktop\"    \"Un innovador fondo de escritorio animado para KDE.\" \"NO INSTALADO  \"  "
fi

            fi


if ! $installed | grep "Jocky" > /dev/null; then
if [ -f /usr/bin/jocky-gtk ] || [ -f /usr/bin/jocky-kde ]; then
                    im=$im"FALSE \"Jocky\"    \"Una utilidad de gran alcance y práctico para la instalación de drivers propietarios de hardware\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Jocky\"    \"Una utilidad de gran alcance y práctico para la instalación de drivers propietarios de hardware\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Entorno de escritorio GNOME/SHELL" > /dev/null; then
if [ "`ps -e | grep gdm`" ]; then
                    im=$im"FALSE \"Entorno de escritorio GNOME/SHELL\"    \"GNOME es un entorno de escritorio e infraestructura de desarrollo para GNU/Linux; compuesto enteramente de software libre.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Entorno de escritorio GNOME/SHELL\"    \"GNOME es un entorno de escritorio e infraestructura de desarrollo para GNU/Linux; compuesto enteramente de software libre.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Entorno de escritorio KDE" > /dev/null; then
if [ -x /usr/share/doc/kdesdk* ]; then
                    im=$im"FALSE \"Entorno de escritorio KDE\"    \"KDE es un proyecto de software libre para la creación de un entorno de escritorio\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Entorno de escritorio KDE\"    \"KDE es un proyecto de software libre para la creación de un entorno de escritorio\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Entorno de escritorio XFCE" > /dev/null; then
if [ -x /usr/share/doc/xfce?-panel ]; then
                    im=$im"FALSE \"Entorno de escritorio XFCE\"    \"Xfce es un entorno de escritorio ligero para sistemas tipo UNIX\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Entorno de escritorio XFCE\"    \"Xfce es un entorno de escritorio ligero para sistemas tipo UNIX\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Entorno de escritorio LXDE" > /dev/null; then
if [ -x /usr/share/doc/lxde-common* ]; then
                    im=$im"FALSE \"Entorno de escritorio LXDE\"    \"LXDE es un entorno de escritorio de código abierto y la solución de escritorio en ahorro de energía y velocidad extrema.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Entorno de escritorio LXDE\"    \"LXDE es un entorno de escritorio de código abierto y la solución de escritorio en ahorro de energía y velocidad extrema.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Entorno de escritorio MATE" > /dev/null; then
if [ -x /usr/share/doc/mate-desktop* ]; then
                    im=$im"FALSE \"Entorno de escritorio MATE\"    \"MATE es un ambiente de escritorio derivado del código base, actualmente descontinuado, de GNOME 2.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Entorno de escritorio MATE\"    \"MATE es un ambiente de escritorio derivado del código base, actualmente descontinuado, de GNOME 2.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Entorno de escritorio Razor-qt" > /dev/null; then
if [ -f /usr/bin/razor-desktop ]; then
                    im=$im"FALSE \"Entorno de escritorio Razor-qt\"    \"Razor-qt es un avanzado entorno de escritorio fácil de usar y rápido basado en las tecnologías de Qt.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Entorno de escritorio Razor-qt\"    \"Razor-qt es un avanzado entorno de escritorio fácil de usar y rápido basado en las tecnologías de Qt.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Desactivacion o Activacion de SELinux" > /dev/null; then

enable="SELINUX=enforcing"
disable="SELINUX=disabled"
seconfig=$(sed -n '7p' /etc/selinux/config); echo "seconfig = $seconfig"
if [ $seconfig = $enable ]; then
                    im=$im"FALSE \"Desactivacion o Activacion de SELinux\"    \"Desactiva o Activa SELinux, una característica de seguridad de Linux que provee una variedad de políticas de seguridad, incluyendo controles de acceso \" \"SELINUX ACTIVADO  \"  "

elif [ $seconfig = $disable ]; 
then
im=$im"FALSE \"Desactivacion o Activacion de SELinux\"    \"Desactiva o Activa SELinux, una característica de seguridad de Linux que provee una variedad de políticas de seguridad, incluyendo controles de acceso \" \"SELINUX NO ACTIVADO  \"  "
fi

            fi

if ! $installed | grep "Frozen Kernel" > /dev/null; then

enable="exclude=kernel*"; echo "enable = $enable"
krozker=$(grep "exclude=kernel*" /etc/yum.conf); echo "krozker = $krozker"
disable=""
if [[ $krozker = $enable ]]; then 
echo 'kernel congelado'
                    im=$im"FALSE \"Frozen Kernel\"    \"Desactiva o Activa las actualizaciones del kernel \" \"KERNEL CONGELADO  \"  "

elif [[ $krozker = $disable ]]; then
echo 'kernel no congelado'
im=$im"FALSE \"Frozen Kernel\"    \"Desactiva o Activa las actualizaciones del kernel \" \"KERNEL NO CONGELADO  \"  "

fi
            fi


if ! $installed | grep "Grub Customizer" > /dev/null; then
if [ -f /usr/bin/grub-customizer ]; then
                    im=$im"FALSE \"Grub Customizer\"    \"Es una interfaz gráfica para configurar grub2/burg, sin perder el comportamiento dinámico.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Grub Customizer\"    \"Es una interfaz gráfica para configurar grub2/burg, sin perder el comportamiento dinámico.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Compat wireless" > /dev/null; then
 
 if [ -f /etc/yum.repos.d/compat-wireless.repo ]; then
im=$im"FALSE \"Compat wireless\"    \"Drivers mejorados para tarjetas wifi, con el que se puede obtener soporte para tarjetas no soportadas por el kernel o aumentar la potencia.\" \"INSTALADO  \"  "
 elif [ -d /lib/modules/?.*.fc17.i686.PAE/ ]; then
                    im=$im"FALSE \"Compat wireless\"    \"Drivers mejorados para tarjetas wifi, con el que se puede obtener soporte para tarjetas no soportadas por el kernel o aumentar la potencia.\" \"NO COMPATIBLE  \"  "
 else
im=$im"FALSE \"Compat wireless\"    \"Drivers mejorados para tarjetas wifi, con el que se puede obtener soporte para tarjetas no soportadas por el kernel o aumentar la potencia.\" \"NO INSTALADO  \"  "

 fi
            fi


if ! $installed | grep "Ver errores del sistema" > /dev/null; then
                    im=$im"FALSE \"Ver errores del sistema\"    \"Muestra el contenido del archivo de registro especificado y marcarcando algunas cadenas especiales \" \"ACTIVO  \"  "
            fi

if ! $installed | grep "Activar/Desactivar Repositorios" > /dev/null; then
                    im=$im"FALSE \"Activar/Desactivar Repositorios\"    \"Activa o desactiva repositorios marcar un repo para activar, desmarcar para disactivar \" \"ACTIVO  \"  "
            fi

if ! $installed | grep "Instalar Nvidia drivers" > /dev/null; then
PKGSINSTALLED=$(rpm -qa *kmod-nvidia*)
	if [[ -n "$PKGSINSTALLED" ]]; then
im=$im"FALSE \"Instalar Nvidia drivers\"    \"Instalar Nvidia drivers facilmente [Experimental] \" \"INSTALADO  \"  "
else
                    im=$im"FALSE \"Instalar Nvidia drivers\"    \"Instalar Nvidia drivers facilmente [Experimental] \" \"NO INSTALADO  \"  "
            fi
fi


if ! $installed | grep "Instalar Ati drivers" > /dev/null; then
ATIINSTALLED=$(rpm -qa *kmod-catalyst*)
	if [[ -n "$ATIINSTALLED" ]]; then
im=$im"FALSE \"Instalar Ati drivers\"    \"Instalar Ati drivers facilmente [Experimental] \" \"INSTALADO  \"  "
else
                    im=$im"FALSE \"Instalar Ati drivers\"    \"Instalar Ati drivers facilmente [Experimental] \" \"NO INSTALADO  \"  "
            fi
fi


if ! $installed | grep "ACTUALIZAR SISTEMA" > /dev/null; then
                    im=$im"FALSE \"ACTUALIZAR SISTEMA\"    \"Actualiza el sistema completamente [Corrige algunos errores de actualización]\" \"ACTIVO  \"  "
            fi


if ! $installed | grep "Reset PostInstallerF" > /dev/null; then
                    im=$im"FALSE \"Reset PostInstallerF\"    \"Reinicia el registro de los programas instalados via PostInstallerF\" \"ACTIVO  \"  "
            fi


if ! $installed | grep "Desinstalar PostInstallerF" > /dev/null; then
                    im=$im"FALSE \"Desinstalar PostInstallerF\"    \"Elimina por completo PostInstallerF, por favor envianos tus sugerencias\" \"ACTIVO  \"  "
            fi

  else
echo 'english default'


if ! $installed | grep "Enable sudo" > /dev/null; then

SER=$(grep "$noti3 ALL=(ALL) ALL" /etc/sudoers) > /dev/null
	if [[ "$?" != 0 ]]; then

                    im=$im"FALSE \"Enable sudo\"    \"Allows a system administrator to delegate authority to give certain users (or groups of users) the ability to run some (or all) commands as root or another user\" \"[$noti3] NO ADDED  \"  "
else
                    im=$im"FALSE \"Enable sudo\"    \"Allows a system administrator to delegate authority to give certain users (or groups of users) the ability to run some (or all) commands as root or another user\" \"[$noti3] ADDED  \"  "
fi
            fi


if ! $installed | grep "Activate Touchpad" > /dev/null; then

if [ -f /etc/X11/xorg.conf.d/50-synaptics.conf ]; then

                    im=$im"FALSE \"Activate Touchpad\"    \"Enables the Touchpad from start\" \"ACTIVATED  \"  "
else
                    im=$im"FALSE \"Activate Touchpad\"    \"Enables the Touchpad from start\" \"NO ACTIVATED  \"  "
fi
            fi


if ! $installed | grep "Brightness control" > /dev/null; then


vacio=$(ls -a /sys/class/backlight/ | wc -w); echo vacio=$vacio

if [ $vacio -eq 2 ]; then

                    im=$im"FALSE \"Brightness control\"    \"Changes the brightness of your monitor or your laptop screen\" \"NO ACTIVO  \"  "
else
im=$im"FALSE \"Brightness control\"    \"Changes the brightness of your monitor or your laptop screen\" \"ACTIVO  \"  "
fi

            fi


if ! $installed | grep "Grace period sudo" > /dev/null; then

enablesu="Defaults:ALL timestamp_timeout=0"
krozker=$(grep "Defaults:ALL timestamp_timeout=0" /etc/sudoers); echo "krozker = $krozker"
disablesu=""

if [ "$krozker" = "$enablesu" ]; then 
im=$im"FALSE \"Grace period sudo\"    \"Credentials to allow/disallow the user to run sudo again for a period of time without authentication.\" \"NO ACTIVATED  \"  "
elif [ "$krozker" = "$disablesu" ]; then
im=$im"FALSE \"Grace period sudo\"    \"Credentials to allow/disallow the user to run sudo again for a period of time without authentication..\" \"ACTIVATED  \"  "
fi
 fi

           
if ! $installed | grep "Change to Spanish Mozilla Firefox" > /dev/null; then

if [ -f /usr/bin/firefox ]; then

                    im=$im"FALSE \"Change to Spanish Mozilla Firefox\"    \"Change the language to Spanish Current Firefox from version 12\" \"ACTIVO  \"  "
else
                    im=$im"FALSE \"Change to Spanish Mozilla Firefox\"    \"Change the language to Spanish Current Firefox from version 12\" \"NO ACTIVO  \"  "
fi
            fi


if ! $installed | grep "Remove old kernels" > /dev/null; then

if [ -f /usr/bin/yum ]; then

                    im=$im"FALSE \"Remove old kernels\"    \"Clean obsolete kernels\" \"ACTIVATED  \"  "
else
                    im=$im"FALSE \"Remove old kernels\"    \"Clean obsolete kernels\" \"NO ACTIVATED  \"  "
fi
            fi



if ! $installed | grep "Complete uncompleted installations" > /dev/null; then

if [ -f /usr/bin/yum ]; then

                    im=$im"FALSE \"Complete uncompleted installations\"    \"Complete uncompleted installations, for system errors\" \"ACTIVED  \"  "
else
im=$im"FALSE \"Complete uncompleted installations\"    \"Complete uncompleted installations, for system errors\" \"NO ACTIVATED  \"  "
fi

            fi


if ! $installed | grep "System information" > /dev/null; then
                    im=$im"FALSE \"System information\"    \"Displays system information\" \"ACTIVATED  \"  "

            fi


if ! $installed | grep "Cinnamon" > /dev/null; then
if [ -f /usr/bin/cinnamon ]; then
                    im=$im"FALSE \"Cinnamon\"    \"Cinnamon is a fork of GNOME Shell, initially developed by Linux Mint.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Cinnamon\"    \"Cinnamon is a fork of GNOME Shell, initially developed by Linux Mint.\" \"NO INSTALLED  \"  "
fi

            fi


if ! $installed | grep "Plasma-wallpaper-dreamdesktop" > /dev/null; then
if [ -f /usr/lib/kde4/dreamdesktop.so ]; then
                    im=$im"FALSE \"Plasma-wallpaper-dreamdesktop\"    \"An innovative animated desktop wallpaper for KDE.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Plasma-wallpaper-dreamdesktop\"    \"An innovative animated desktop wallpaper for KDE.\" \"NO INSTALLED  \"  "
fi

            fi


if ! $installed | grep "Jocky" > /dev/null; then
if [ -f /usr/bin/jocky-gtk ] || [ -f /usr/bin/jocky-kde ]; then
                    im=$im"FALSE \"Jocky\"    \"Jockey provides a user interface for configuring third-party drivers, such as the Nvidia and ATI fglrx X.org and various Wireless LAN kernel modules. \" \"INSTALLED  \"  "
else
im=$im"FALSE \"Jocky\"    \"Jockey provides a user interface for configuring third-party drivers, such as the Nvidia and ATI fglrx X.org and various Wireless LAN kernel modules. \" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Desktop environment GNOME/SHELL" > /dev/null; then
if [ "`ps -e | grep gdm`" ]; then
                    im=$im"FALSE \"Desktop environment GNOME/SHELL\"    \"GNOME is a desktop environment and graphical user interface that runs on top of a computer operating system.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Desktop environment GNOME/SHELL\"    \"GNOME is a desktop environment and graphical user interface that runs on top of a computer operating system.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Desktop environment KDE" > /dev/null; then
if [ -x /usr/share/doc/kdesdk* ]; then
                    im=$im"FALSE \"Desktop environment KDE\"    \"KDE is a powerful graphical desktop environment for Unix workstations\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Desktop environment KDE\"    \"KDE is a powerful graphical desktop environment for Unix workstations\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Desktop environment XFCE" > /dev/null; then
if [ -x /usr/share/doc/xfce?-panel ]; then
                    im=$im"FALSE \"Desktop environment XFCE\"    \"Xfce is a lightweight desktop environment for UNIX-like operating systems.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Desktop environment XFCE\"    \"Xfce is a lightweight desktop environment for UNIX-like operating systems.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Desktop environment LXDE" > /dev/null; then
if [ -x /usr/share/doc/lxde-common* ]; then
                    im=$im"FALSE \"Desktop environment LXDE\"    \"LXDE is a free and open source desktop environment for Unix and other POSIX compliant platforms, such as Linux or BSD.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Desktop environment LXDE\"    \"LXDE is a free and open source desktop environment for Unix and other POSIX compliant platforms, such as Linux or BSD.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Desktop environment MATE" > /dev/null; then
if [ -x /usr/share/doc/mate-desktop* ]; then
                    im=$im"FALSE \"Desktop environment MATE\"    \"The MATE Desktop Environment is a fork of GNOME 2 that aims to provide an attractive and intuitive desktop to Linux.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Desktop environment MATE\"    \"The MATE Desktop Environment is a fork of GNOME 2 that aims to provide an attractive and intuitive desktop to Linux.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Desktop environment Razor-qt" > /dev/null; then
if [ -f /usr/bin/razor-desktop ]; then
                    im=$im"FALSE \"Desktop environment Razor-qt\"    \"Razor-qt is an advanced, easy-to-use, and fast desktop environment based on Qt technologies.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Desktop environment Razor-qt\"    \"Razor-qt is an advanced, easy-to-use, and fast desktop environment based on Qt technologies.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Disable or enable de SELinux" > /dev/null; then

enable="SELINUX=enforcing"
disable="SELINUX=disabled"
seconfig=$(sed -n '7p' /etc/selinux/config); echo "seconfig = $seconfig"
if [ $seconfig = $enable ]; then
                    im=$im"FALSE \"Disable or enable de SELinux\"    \"Disable o Enable SELinux,  is a Linux feature that provides the mechanism for supporting access control security policies. \" \"SELINUX ACTIVATED  \"  "

elif [ $seconfig = $disable ]; 
then
im=$im"FALSE \"Disable or enable de SELinux\"    \"Disable o Enable SELinux,  is a Linux feature that provides the mechanism for supporting access control security policies. \" \"SELINUX NO ACTIVATED  \"  "
fi

            fi

if ! $installed | grep "Frozen Kernel" > /dev/null; then

enable="exclude=kernel*"; echo "enable = $enable"
krozker=$(grep "exclude=kernel*" /etc/yum.conf); echo "krozker = $krozker"
disable=""
if [[ $krozker = $enable ]]; then 
echo 'kernel congelado'
                    im=$im"FALSE \"Frozen Kernel\"    \"Disable or Enable kernel FROZEN \" \"KERNEL CONGELADO  \"  "

elif [[ $krozker = $disable ]]; then
echo 'kernel no congelado'
im=$im"FALSE \"Frozen Kernel\"    \"Disable or Enable kernel updates \" \"KERNEL UNFROZEN  \"  "

fi
            fi


if ! $installed | grep "Grub Customizer" > /dev/null; then
if [ -f /usr/bin/grub-customizer ]; then
                    im=$im"FALSE \"Grub Customizer\"    \"Graphical interface to configure the GRUB2/BURG settings and menuentries. \" \"INSTALLED  \"  "
else
im=$im"FALSE \"Grub Customizer\"    \"Graphical interface to configure the GRUB2/BURG settings and menuentries.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Compat wireless" > /dev/null; then
 
 if [ -f /etc/yum.repos.d/compat-wireless.repo ]; then
im=$im"FALSE \"Compat wireless\"    \"Package which contains the development and stable versions of the in-kernel wireless drivers. \" \"INSTALLED  \"  "
 elif [ -d /lib/modules/?.*.fc17.i686.PAE/ ]; then
                    im=$im"FALSE \"Compat wireless\"    \"Package which contains the development and stable versions of the in-kernel wireless drivers.\" \"NO COMPATIBLE  \"  "
 else
im=$im"FALSE \"Compat wireless\"    \"Package which contains the development and stable versions of the in-kernel wireless drivers.\" \"NO INSTALLED  \"  "

 fi
            fi


if ! $installed | grep "See system errors" > /dev/null; then
                    im=$im"FALSE \"See system errors\"    \"Displays the contents of the specified log file, and mark some special strings \" \"ACTIVATED  \"  "
            fi

if ! $installed | grep "Enable/Disable Repositories" > /dev/null; then
                    im=$im"FALSE \"Enable/Disable Repositories\"    \"Enable/disable repositories, check a repo to enable, uncheck to disable \" \"ACTIVATED  \"  "
            fi

if ! $installed | grep "Install Nvidia drivers" > /dev/null; then
PKGSINSTALLED=$(rpm -qa *kmod-nvidia*)
	if [[ -n "$PKGSINSTALLED" ]]; then
im=$im"FALSE \"Install Nvidia drivers\"    \"Install Nvidia drivers easily [Experimental] \" \"INSTALLED  \"  "
else
                    im=$im"FALSE \"Install Nvidia drivers\"    \"Install Nvidia drivers easily [Experimental] \" \"NO INSTALLED  \"  "
            fi
fi


if ! $installed | grep "Install Ati drivers" > /dev/null; then
ATIINSTALLED=$(rpm -qa *kmod-catalyst*)
	if [[ -n "$ATIINSTALLED" ]]; then
im=$im"FALSE \"Install Ati drivers\"    \"Install Ati drivers easily [Experimental] \" \"INSTALLED  \"  "
else
                    im=$im"FALSE \"Install Ati drivers\"    \"Install Ati drivers easily [Experimental] \" \"NO INSTALLED  \"  "
            fi
fi


if ! $installed | grep "UPDATE SYSTEM" > /dev/null; then
                    im=$im"FALSE \"UPDATE SYSTEM\"    \"Update the system completely [It'll fix some errors]\" \"ACTIVE  \"  "
            fi


if ! $installed | grep "Reset PostInstallerF" > /dev/null; then
                    im=$im"FALSE \"Reset PostInstallerF\"    \"Restart the registry, of the programs installed via PostInstallerF\" \"ACTIVATED  \"  "
            fi


if ! $installed | grep "Uninstall PostInstallerF" > /dev/null; then
                    im=$im"FALSE \"Uninstall PostInstallerF\"    \"Completely eliminates PostInstallerF, please send us your suggestions\" \"ACTIVATED  \"  "
            fi


fi


    }


chooseInstalls(){
     
            #choosing witch installs/tweaks to run
            echo "Running Choice Menu..."
            choice=`echo $im | sh -`


if echo $choice | grep "Activar sudo" > /dev/null; then
                    sudouser
            fi

if echo $choice | grep "Enable sudo" > /dev/null; then
                    sudouser
            fi

if echo $choice | grep "Activar Touchpad" > /dev/null; then
                    touchp
            fi

if echo $choice | grep "Activate Touchpad" > /dev/null; then
                    touchp
            fi


if echo $choice | grep "Control de brillo" > /dev/null; then
                    bright
            fi


if echo $choice | grep "Brightness control" > /dev/null; then
                    bright
            fi

if echo $choice | grep "Periodo de gracia sudo" > /dev/null; then
                    graciasudo
            fi

if echo $choice | grep "Grace period sudo" > /dev/null; then
                    graciasudo
            fi           
     
if echo $choice | grep "Cambiar Mozilla Firefox a español" > /dev/null; then
                    firefoxes
            fi


if echo $choice | grep "Change to Spanish Mozilla Firefox" > /dev/null; then
                    firefoxes
            fi


if echo $choice | grep "Eliminar Kernels Antiguos" > /dev/null; then
                    kernelold
            fi

if echo $choice | grep "Remove old kernels" > /dev/null; then
                    kernelold
            fi


if echo $choice | grep "Completar Instalaciones pendientes" > /dev/null; then
                    pendientes
            fi

if echo $choice | grep "Complete uncompleted installations" > /dev/null; then
                    pendientes
            fi


if echo $choice | grep "System information" > /dev/null; then
                    infosystem
            fi

if echo $choice | grep "Informacion del Sistema" > /dev/null; then
                    infosystem
            fi

if echo $choice | grep "Cinnamon" > /dev/null; then
                    cinnamon
            fi

if echo $choice | grep "Plasma-wallpaper-dreamdesktop" > /dev/null; then
                    dreamd
            fi

if echo $choice | grep "Jocky" > /dev/null; then
                    jocky
            fi

if echo $choice | grep "Entorno de escritorio GNOME" > /dev/null; then
                    gnodesk
            fi

if echo $choice | grep "Desktop environment GNOME/SHELL" > /dev/null; then
                    gnodesk
            fi


if echo $choice | grep "Entorno de escritorio KDE" > /dev/null; then
                    kdesk
            fi

if echo $choice | grep "Desktop environment KDE" > /dev/null; then
                    kdesk
            fi


if echo $choice | grep "Entorno de escritorio XFCE" > /dev/null; then
                    xfdesk
            fi

if echo $choice | grep "Desktop environment XFCE" > /dev/null; then
                    xfdesk
            fi


if echo $choice | grep "Entorno de escritorio LXDE" > /dev/null; then
                    lxdesk
            fi

if echo $choice | grep "Desktop environment LXDE" > /dev/null; then
                    lxdesk
            fi


if echo $choice | grep "Entorno de escritorio MATE" > /dev/null; then
                    mat
            fi

if echo $choice | grep "Desktop environment MATE" > /dev/null; then
                    mat
            fi

if echo $choice | grep "Entorno de escritorio Razor-qt" > /dev/null; then
                    razor
            fi

if echo $choice | grep "Desktop environment Razor-qt" > /dev/null; then
                    razor
            fi

if echo $choice | grep "Desactivacion o Activacion de SELinux" > /dev/null; then
                    SLinux
            fi

if echo $choice | grep "Disable or enable de SELinux" > /dev/null; then
                    SLinux
            fi

if echo $choice | grep "Frozen Kernel" > /dev/null; then
                    frozen
            fi

if echo $choice | grep "Grub Customizer" > /dev/null; then
                    grubcus
            fi

if echo $choice | grep "Compat wireless" > /dev/null; then
                    compatw
            fi

if echo $choice | grep "Ver errores del sistema" > /dev/null; then
                    errors
            fi

if echo $choice | grep "See system errors" > /dev/null; then
                    errors
            fi

if echo $choice | grep "Activar/Desactivar Repositorios" > /dev/null; then
                    reposi
            fi


if echo $choice | grep "Enable/Disable Repositories" > /dev/null; then
                    reposi
            fi

if echo $choice | grep "Instalar Nvidia drivers" > /dev/null; then
                    nvidia
            fi

if echo $choice | grep "Install Nvidia drivers" > /dev/null; then
                    nvidia
            fi

if echo $choice | grep "Instalar Ati drivers" > /dev/null; then
                    ativide
            fi

if echo $choice | grep "Install Ati drivers" > /dev/null; then
                    ativide
            fi

if echo $choice | grep "ACTUALIZAR SISTEMA" > /dev/null; then
                    actualizar
            fi

if echo $choice | grep "UPDATE SYSTEM" > /dev/null; then
                    actualizar
            fi

if echo $choice | grep "Reset PostInstallerF" > /dev/null; then
                    cleanlog
            fi

if echo $choice | grep "Desinstalar PostInstallerF" > /dev/null; then
                    delpost
            fi

if echo $choice | grep "Uninstall PostInstallerF" > /dev/null; then
                    delpost
            fi


    }
     
     
    ##
    ## Tweak/Install functions
    ##


sudouser(){
SER=$(grep "$noti3 ALL=(ALL) ALL" /etc/sudoers) > /dev/null
	if [[ "$?" != 0 ]]; then

zenity --question --title="Add you to sudoers list?" --text="Adding yourself to sudoers will enable you to perform operations as root. Do you want PostInstallerF to add $noti3 to the sudoers list?" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then
echo "$noti3 ALL=(ALL) ALL" >> /etc/sudoers
su $noti -c 'notify-send "PostInstallerF" "$noti3 fue incluido al grupo sudo" -i "/usr/share/icons/sistema.png" -t 5000'
	else
echo "Cuando tu quieras, aqui estaremos para agregarte al archivo sudoers..."
fi

else
zenity --question --title="Do you want remove $noti3 from sudoers file?" --text="$noti3 already in sudoers file" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then
sed -i "s/[$noti3 ALL=(ALL) ALL]//g" /etc/sudoers
else
echo 'cuando quiera podra eliminar el corriente usuario del archivo sudoers'
fi
fi

    }

touchp(){

if [ -f /etc/X11/xorg.conf.d/50-synaptics.conf ]; then
echo 'ya existe'
su $noti -c 'notify-send "PostInstallerF" "Ya se encuentra activado el Touchpad" -i "/usr/share/icons/user-trash-full.png" -t 5000'
else
echo "Section  "InputClass"
Identifier  "touchpad catchall"
Driver  "synaptics"
MatchIsTouchpad  "on"

####################################
## The lines that you need to add ##
# Enable left mouse button by tapping
Option  "TapButton1"  "1"
# Enable vertical scrolling
Option  "VertEdgeScroll"  "1"
# Enable right mouse button by tapping lower right corner
Option "RBCornerButton" "3"
####################################

MatchDevicePath  "/dev/input/event*"
EndSection " >> /etc/X11/xorg.conf.d/50-synaptics.conf

su $noti -c 'notify-send "PostInstallerF" "Se ha activado el Touchpad" -i "/usr/share/icons/user-trash-full.png" -t 5000'

fi
          

    }


bright(){

#+--------------------------------------------------------------------------------------+
#| VARIABLES E ICONOS BRIGHTNESS CONTROL                                                |
#+--------------------------------------------------------------------------------------+

var="root"
var2=$(whoami); echo "var2 = $var2"
carpeta="0"
vacio=$(ls -a /sys/class/backlight/ | wc -w); echo vacio=$vacio

# ICONOS
if [ -f /usr/share/icons/brightness.png ]; then
echo 'ya existe el icono'
else
xterm -e 'wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/brightness.png'
fi

#+--------------------------------------------------------------------------------------+
#| VERIFICACION PREVIA EJECUCION BRIGHTNESS CONTROL                                     |
#+--------------------------------------------------------------------------------------+

if [ $vacio -eq 2 ]; then
echo 'el directorio esta vacio'
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="No es compatible con tu configuración, nada que hacer"
else
echo 'existen directorios o archivos en /sys/class/backlight/'

#+--------------------------------------------------------------------------------------+
#| MENU BRIGHTNESS CONTROL                                                              |
#+--------------------------------------------------------------------------------------+

if [ -f /sys/devices/virtual/backlight/*_screen/brightness ]; then

value=$(cat /sys/devices/virtual/backlight/*_screen/brightness)

kubb=$(find /sys/class/backlight/*screen/brightness); echo "kubb = $kubb"

value_max=$(cat /sys/devices/virtual/backlight/*_screen/max_brightness)

if [ $(echo $LANG | cut -b1-2) = "pt" ]
then
  title_text="Controle de brilho"
  scale_text="Ajuste de intensidade (1 a $value_max)"
elif [ $(echo $LANG | cut -b1-2) = "es" ]
then
  title_text="Control de brillo"
  scale_text="Ajuste de intensidad (1 a $value_max)"
else
  title_text="Brightness control"
  scale_text="Intensity adjustment (1 to $value_max)"
fi

new_value=$(yad --image="/usr/share/icons/brightness.png" --window-icon="/usr/share/icons/brightness.png" --image-on-top --scale --title "$title_text" --text "$scale_text" --min-value 0 --max-value $value_max --value $value --step 1)

#echo -n $new_value > /sys/devices/virtual/backlight//brightness

echo -n $new_value > $kubb

fi

##########################################################################################

if [ -f /sys/devices/virtual/backlight/*_backlight/brightness ]; then

value=$(cat /sys/devices/virtual/backlight/*_backlight/brightness)

kubb=$(find /sys/class/backlight/*backlight/brightness); echo "kubb = $kubb"

value_max=$(cat /sys/devices/virtual/backlight/*_backlight/max_brightness)

if [ $(echo $LANG | cut -b1-2) = "pt" ]
then
  title_text="Controle de brilho"
  scale_text="Ajuste de intensidade (1 a $value_max)"
elif [ $(echo $LANG | cut -b1-2) = "es" ]
then
  title_text="Control de brillo"
  scale_text="Ajuste de intensidad (1 a $value_max)"
else
  title_text="Brightness control"
  scale_text="Intensity adjustment (1 to $value_max)"
fi

new_value=$(yad --image="/usr/share/icons/brightness.png" --window-icon="/usr/share/icons/brightness.png" --image-on-top --scale --title "$title_text" --text "$scale_text" --min-value 0 --max-value $value_max --value $value --step 1)

#echo -n $new_value > /sys/devices/virtual/backlight//brightness

echo -n $new_value > $kubb
fi


##########################################################################################

if [ -f /sys/class/backlight/acpi_video0/brightness ]; then

value=$(cat /sys/class/backlight/acpi_video0/brightness)

value_max=$(cat /sys/class/backlight/acpi_video0/max_brightness)

if [ $(echo $LANG | cut -b1-2) = "pt" ]
then
  title_text="Controle de brilho"
  scale_text="Ajuste de intensidade (1 a $value_max)"
elif [ $(echo $LANG | cut -b1-2) = "es" ]
then
  title_text="Control de brillo"
  scale_text="Ajuste de intensidad (1 a $value_max)"
else
  title_text="Brightness control"
  scale_text="Intensity adjustment (1 to $value_max)"
fi

new_value=$(yad --image="/usr/share/icons/brightness.png" --window-icon="/usr/share/icons/brightness.png" --image-on-top --scale --title "$title_text" --text "$scale_text" --min-value 0 --max-value $value_max --value $value --step 1)

echo -n $new_value > /sys/class/backlight/acpi_video0/brightness
fi

##########################################################################################

if [ -f /sys/class/backlight/acpi_video1/brightness ]; then

value=$(cat /sys/class/backlight/acpi_video1/brightness)

value_max=$(cat /sys/class/backlight/acpi_video1/max_brightness)

if [ $(echo $LANG | cut -b1-2) = "pt" ]
then
  title_text="Controle de brilho"
  scale_text="Ajuste de intensidade (1 a $value_max)"
elif [ $(echo $LANG | cut -b1-2) = "es" ]
then
  title_text="Control de brillo"
  scale_text="Ajuste de intensidad (1 a $value_max)"
else
  title_text="Brightness control"
  scale_text="Intensity adjustment (1 to $value_max)"
fi

new_value=$(yad --image="/usr/share/icons/brightness.png" --window-icon="/usr/share/icons/brightness.png" --image-on-top --scale --title "$title_text" --text "$scale_text" --min-value 0 --max-value $value_max --value $value --step 1)

echo -n $new_value > /sys/class/backlight/acpi_video1/brightness
fi

##########################################################################################

if [ -f /sys/devices/virtual/backlight/psb-bl/brightness ]; then

value=$(cat /sys/devices/virtual/backlight/psb-bl/brightness)

value_max=$(cat /sys/devices/virtual/backlight/psb-bl/max_brightness)

if [ $(echo $LANG | cut -b1-2) = "pt" ]
then
  title_text="Controle de brilho"
  scale_text="Ajuste de intensidade (1 a $value_max)"
elif [ $(echo $LANG | cut -b1-2) = "es" ]
then
  title_text="Control de brillo"
  scale_text="Ajuste de intensidad (1 a $value_max)"
else
  title_text="Brightness control"
  scale_text="Intensity adjustment (1 to $value_max)"
fi

new_value=$(yad --image="/usr/share/icons/brightness.png" --window-icon="/usr/share/icons/brightness.png" --image-on-top --scale --title "$title_text" --text "$scale_text" --min-value 0 --max-value $value_max --value $value --step 1)

#echo -n $new_value > /sys/devices/virtual/backlight//brightness

echo -n $new_value > /sys/class/backlight/psb-bl/brightness

fi


##########################################################################################

if [ -f /sys/devices/virtual/backlight/eeepc/brightness ]; then

value=$(cat /sys/devices/virtual/backlight/eeepc/brightness)

value_max=$(cat /sys/devices/virtual/backlight/eeepc/max_brightness)

if [ $(echo $LANG | cut -b1-2) = "pt" ]
then
  title_text="Controle de brilho"
  scale_text="Ajuste de intensidade (1 a $value_max)"
elif [ $(echo $LANG | cut -b1-2) = "es" ]
then
  title_text="Control de brillo"
  scale_text="Ajuste de intensidad (1 a $value_max)"
else
  title_text="Brightness control"
  scale_text="Intensity adjustment (1 to $value_max)"
fi

new_value=$(yad --image="/usr/share/icons/brightness.png" --window-icon="/usr/share/icons/brightness.png" --image-on-top --scale --title "$title_text" --text "$scale_text" --min-value 0 --max-value $value_max --value $value --step 1)

#echo -n $new_value > /sys/devices/virtual/backlight//brightness

echo -n $new_value > /sys/class/backlight/eeepc/brightness

fi


 fi


}


graciasudo(){

enablesu="Defaults:ALL timestamp_timeout=0"
krozker=$(grep "Defaults:ALL timestamp_timeout=0" /etc/sudoers); echo "krozker = $krozker"
disablesu=""

if [ -f /etc/sudoers.bak ]; then
echo 'el backup ya fue creado'
else
cp -f /etc/sudoers /etc/sudoers.bak
fi

if [ "$krozker" = "$enablesu" ]; then 
zenity --question --title="PostInstallerF" --text="Do you want enable Grace period Again?" --ok-label "Yes" --cancel-label "No"

if [[ $? -eq 0 ]]; then
sed -i '/Defaults:ALL timestamp_timeout=0/d' /etc/sudoers
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/Postinstaller1.svg" --image="/usr/share/icons/acciones/topiconubu.png" --image-on-top --info --title="PostInstallerF" --text="Se ha activado el Período de gracia sudo"
else
echo 'Cuando quieras puedes activar de nuevo el periodo de gracia sudo'
fi

elif [ "$krozker" = "$disablesu" ]; then
zenity --question --title="PostInstallerF" --text="Do you want disable Grace period Again?" --ok-label "Yes" --cancel-label "No"

if [[ $? -eq 0 ]]; then
echo "Defaults:ALL timestamp_timeout=0" >> /etc/sudoers
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/Postinstaller1.svg" --image="/usr/share/icons/acciones/topiconubu.png" --image-on-top --info --title="PostInstallerF" --text="Se ha desactivado el Período de gracia sudo"
else
echo 'Cuando usted quiera podra desactivar el periodo de gracia sudo'
fi

fi

    }

firefoxes(){
#
# Cambiar lenguaje a español de Firefox
#

#VARIABLES

loca=$(locale | sed -n '1p'); echo "loca = $loca"
loca2=""
loca3="LANG=es_MX.utf8"
loca4=" LANG=es_ES.utf8 "
loca5="LANG=es_AR.utf8"
loca6="LANG=es_CL.utf8"

CADENA2=$(firefox -v | awk '{print $3}'); echo "CADENA2 = $CADENA2"


# COMPARACIONES

# MEXICO
if [ $loca != $loca3 ]; 
then
echo "No sos de mexico"
else
su $noti -c "/usr/bin/firefox ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$CADENA2/linux-i686/xpi/es-MX.xpi"
fi
 

# ESPAÑA
if [ $loca != $loca4 ]; 
then
echo "no sos de españa"
else
su $noti -c "/usr/bin/firefox ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$CADENA2/linux-i686/xpi/es-ES.xpi"
fi
 

# ARGENTINA
if [ $loca != $loca5 ]; 
then
echo "no sos de argentina"
else
su $noti -c "/usr/bin/firefox ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$CADENA2/linux-i686/xpi/es-AR.xpi"
fi
 
             
# CHILE
if [ $loca != $loca6 ]; 
then
echo "no sos de chile"
else
su $noti -c "/usr/bin/firefox ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$CADENA2/linux-i686/xpi/es-CL.xpi"
fi
 
                 
# NINGUNO

if [ $loca != $loca3 ] && [ $loca != $loca4 ] && [ $loca != $loca5 ] && [ $loca != $loca6 ]; 
then
su $noti -c "/usr/bin/firefox ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$CADENA2/linux-i686/xpi/es-MX.xpi"
fi
          


su $noti -c 'notify-send "PostInstallerF" "Completado Cambiar Mozilla Firefox a español" -i "/usr/share/icons/pinguino.png" -t 5000'

    }


kernelold(){

            package-cleanup --oldkernels  --count=2 -y | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/trashito.png" --image-on-top --progress --title "Eliminando Kernels Antiguos" --text="Por favor espere...." --pulsate --auto-close --width=350

su $noti -c 'notify-send "PostInstallerF" "Completada la eliminacion de Kernels Antiguos" -i "/usr/share/icons/user-trash-full.png" -t 5000'


    }


pendientes(){
            yum-complete-transaction -y | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Completando Instalaciones pendientes" --text="Por favor espere...." --pulsate --auto-close --width=350

su $noti -c 'notify-send "PostInstallerF" "Completado Instalaciones pendientes" -i "/usr/share/icons/pinguino.png" -t 5000'

    }


infosystem(){
            zenity --info --title="Informacion del Sistema" --text="Distribucion: 
$(cat /etc/fedora-release)\n\nKernel: $(uname -s -r)\n\nArchitecture: 
$(uname -i)\n\nRAM: $(cat /proc/meminfo | grep MemTotal | cut -c10-)\n\nGraphics Card: 
$(/sbin/lspci | grep VGA)\n\nGraphics Drivers: 
$(glxinfo | grep renderer)\n\nSound Card: 
$(lspci | grep -i audio)\n\nNetwork: 
$(lspci | grep -i network)\n\nUptime: 
$(uptime)" --ok-label="Ok"


su $noti -c 'notify-send "PostInstallerF" "Completado informacion del sistema" -i "/usr/share/icons/sistema.png" -t 5000'


    }



cinnamon(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]; then
xterm -e 'wget -c -P/etc/yum.repos.d/ http://repos.fedorapeople.org/repos/leigh123linux/cinnamon/fedora-cinnamon.repo'
yum -y install cinnamon | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Cinnamon" --text="Por favor espere...." --pulsate --auto-close --width=350
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "15" ]; then
xterm -e 'wget -c -P/etc/yum.repos.d/ http://repos.fedorapeople.org/repos/leigh123linux/cinnamon/fedora-cinnamon.repo'
yum -y install cinnamon | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Cinnamon" --text="Por favor espere...." --pulsate --auto-close --width=350
else
yum -y install cinnamon | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Cinnamon" --text="Por favor espere...." --pulsate --auto-close --width=350
fi

if [ -f /usr/bin/cinnamon ]; then
$changelog
echo "Cinnamon" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Cinnamon" -i "/usr/share/icons/sistema.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="Por alguna razon Cinnamon no esta instalado, vuelva a intentar "
fi


    }


dreamd(){

yum -y install plasma-wallpaper-dreamdesktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Plasma-wallpaper-dreamdesktop" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/lib/kde4/dreamdesktop.so ]; then
$changelog
echo "Cinnamon" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Plasma-wallpaper-dreamdesktop" -i "/usr/share/icons/sistema.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="Por alguna razon Plasma-wallpaper-dreamdesktop no esta instalado, vuelva a intentar "
fi

    }

jocky(){
            
if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) != "16" ]
then
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Este programa No es compatible con Fedora 17 o posterior, nada que hacer"
else
wget -c -P/etc/yum.repos.d/ http://sourceforge.net/projects/postinstaller/files/repositorios/parsidora.repo
if [ "`ps -e | grep gdm`" ]; then
echo "Vos estas usando Gnome"
 yum -y install jockey jockey-selinux jockey-modaliases jockey-gtk | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Jocky" --text="Por favor espere...." --pulsate --auto-close --width=350
elif [ "`ps -e | grep kdm`" ]; then
echo "Vos estas usando KDE"
 yum -y install jockey jockey-selinux jockey-modaliases jockey-kde | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Jocky" --text="Por favor espere...." --pulsate --auto-close --width=350
else
echo "Vos estas usando otro"
fi
fi

if [ -f /usr/bin/jocky-gtk ] || [ -f /usr/bin/jocky-kde ]; then
$changelog
echo "Jocky" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Jockey" -i "/usr/share/icons/sistema.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="Por alguna razon Jocky no esta instalado, vuelva a intentar "
fi   


    }


gnodesk(){
            yum -y install @gnome-desktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando escritorio Gnome/Shell" --text="Por favor espere...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion Entorno de escritorio GNOME/SHELL" -i "/usr/share/icons/sistema.png" -t 5000'
echo "Entorno de escritorio GNOME/SHELL" >> installed.log

    }


kdesk(){
            yum -y install @kde-desktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando escritorio KDE" --text="Por favor espere...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion Entorno de escritorio KDE" -i "/usr/share/icons/sistema.png" -t 5000'
echo "Entorno de escritorio KDE" >> installed.log

    }


xfdesk(){
            yum -y install @xfce-desktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando escritorio XFCE" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y install greybird-gtk2-theme greybird-gtk2-theme greybird-xfwm4-theme greybird-xfce4-notifyd-theme xfce4-volumed | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando tema Greybird para XFCE" --text="Por favor espere...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Entorno de escritorio XFCE" -i "/usr/share/icons/sistema.png" -t 5000'
echo "Entorno de escritorio XFCE" >> installed.log

    }


lxdesk(){
            yum -y install @lxde-desktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando escritorio LXDE" --text="Por favor espere...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Entorno de escritorio LXDE" -i "/usr/share/icons/sistema.png" -t 5000'
echo "Entorno de escritorio LXDE" >> installed.log

    }

mat(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "17" ]; then
yum -y groupinstall mate-desktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando escritorio MATE" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y install mate-media | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando control de volumen para MATE" --text="Por favor espere...." --pulsate --auto-close --width=350

elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]; then
yum -y install http://dl.dropbox.com/u/49862637/Mate-desktop/mate-desktop-fedora/releases/16/noarch/mate-desktop-release-16-5.fc16.noarch.rpm
yum -y groupinstall MATE-Desktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando escritorio MATE" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y install mate-media | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando control de volumen para MATE" --text="Por favor espere...." --pulsate --auto-close --width=350
else
yum -y groupinstall mate-desktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando escritorio MATE" --text="Por favor espere...." --pulsate --auto-close --width=350
yum -y install mate-media | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando control de volumen para MATE" --text="Por favor espere...." --pulsate --auto-close --width=350
fi

su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Entorno de escritorio MATE" -i "/usr/share/icons/sistema.png" -t 5000'
echo "Entorno de escritorio MATE" >> installed.log

    }


razor(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "17" ]; then
xterm -e 'wget -c -P/etc/yum.repos.d/ http://download.opensuse.org/repositories/X11:/QtDesktop/Fedora_17/X11:QtDesktop.repo'
wait ${!}
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y install razorqt | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Razor-qt Desk" --text="Por favor espere...." --pulsate --auto-close --width=350
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]; then
xterm -e 'wget -c -P/etc/yum.repos.d/ http://download.opensuse.org/repositories/X11:/QtDesktop/Fedora_16/X11:QtDesktop.repo'
wait ${!}
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y install razorqt | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Razor-qt Desk" --text="Por favor espere...." --pulsate --auto-close --width=350
fi

su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Entorno de escritorio Razor-qt" -i "/usr/share/icons/sistema.png" -t 5000'
echo "Entorno de escritorio Razor-qt" >> installed.log

    }


SLinux(){
            
enable="SELINUX=enforcing"
disable="SELINUX=disabled"
seconfig=$(sed -n '7p' /etc/selinux/config); echo "seconfig = $seconfig"

cp -f /etc/selinux/config /etc/selinux/config.bak

if [ "$seconfig" = "$enable" ]; then 
zenity --question --title="Do you want disable SELinux?" --text="Detected enable SELinux" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Se ha desactivado SELinux"
else
echo 'Cuando tu quieras'
fi

elif [ "$seconfig" = "$disable" ]; then
zenity --question --title="Do you want enable SELinux?" --text="Detected disable SELinux" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then
sed -i s/SELINUX=disabled/SELINUX=enforcing/g /etc/selinux/config
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Se ha activado SELinux"
else
echo 'cuando tu quieras'
fi

fi


su $noti -c 'notify-send "PostInstallerF" "Completada la Desactivacion o Activacion de SELinux" -i "/usr/share/icons/sistema.png" -t 5000'


    }

frozen(){
            
enable="exclude=kernel*"; echo "enable = $enable"
krozker=$(grep "exclude=kernel*" /etc/yum.conf); echo "krozker = $krozker"
disable=""

if [ -f /etc/yum.conf.bak ]; then
echo 'el backup ya fue creado'
else
cp -f /etc/yum.conf /etc/yum.conf.bak
fi

if [ "$krozker" = "$enable" ]; then 
echo "posiblemente ya este congelado el kernel"
zenity --question --title="Do you want enable updates kernel?" --text="Detected disable updates kernel" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then
sed -i '/exclude=kernel*/d' /etc/yum.conf
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Se ha activado las actualizaciones del kernel"
else
echo 'Estamos para servirte'
fi

elif [ "$krozker" = "$disable" ]; then 
echo "No esta congelado el kernel"
zenity --question --title="Do you want disable updates kernel?" --text="Detected enable updates kernel" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then
echo "exclude=kernel*" >> /etc/yum.conf
yad --class="ATENCIÓN" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Se han desactivado las actualizaciones del kernel"
else
echo 'cuando quieras'
fi

fi

    }



grubcus(){
            
yum -y install grub-customizer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Grub Customizer" --text="Por favor espere...." --pulsate --auto-close --width=350


if [ -f /usr/bin/grub-customizer ]; then
$changelog
echo "Grub Customizer" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Grub Customizer" -i "/usr/share/icons/sistema.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="Por alguna razon Grub Customizer no esta instalado, vuelva a intentar "
fi


    }

compatw(){

if [ -d /lib/modules/?.*.fc17.i686.PAE/ ]; then
            
yad --info --title="PostInstallerF" --text="Compat wireless no es compatible con kernel PAE "
else
if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]; then
wget -c -P/etc/yum.repos.d/ http://people.redhat.com/sgruszka/compat-wireless.repo
yum -y --exclude=kernel* update 2>&1 | zenity --progress --title "Actualizando repositorios para Compat wireless" --text="Por favor espere...." --pulsate --auto-close --width=400
echo 'es fedora 16'

elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "17" ]; then
wget -c -P/etc/yum.repos.d/ http://people.redhat.com/sgruszka/compat-wireless.repo
yum -y --exclude=kernel* update 2>&1 | zenity --progress --title "Actualizando repositorios para Compat wireless" --text="Por favor espere...." --pulsate --auto-close --width=400
echo 'es fedora 17'

elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then
yad --info --title="PostInstallerF" --text="No compatible aun con Fedora 18 "
echo 'es fedora 17'
fi
  fi



if [ -f /etc/yum.repos.d/compat-wireless.repo ]; then
$changelog
echo "Compat wireless" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Compat wireless" -i "/usr/share/icons/sistema.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="Por alguna razon Compat wireless no esta instalado, vuelva a intentar "
fi


    }



errors(){
LOGFILE=${1:-/var/log/messages}

PARSER='{font=""; color="#FFFFFF"}; \
/kernel/ {font="italic"}; \
/warn/ {color="#FFF4B8"}; \
/error/ {color="#FFD0D8"}; \
OFS="\n" {print $1 " " $2, $3, $4, substr($5,0,index($5,":")-1), \
substr($0,index($0,$6)), font, color; fflush()}'

tail -f $LOGFILE | awk "$PARSER" | \
yad --title="Log viewer" --window-icon=logviewer \
    --button=gtk-close --geometry 600x350 \
    --list --text="Content of $LOGFILE" \
    --column Date --column Time --column Host \
    --column Tag --column Message:TIP \
    --column @font@ --column @back@

exit $?
su $noti -c 'notify-send "PostInstallerF" "Acabas de ver los errores del sistema" -i "/usr/share/icons/sistema.png" -t 5000'

}

reposi(){

gpk-prefs

su $noti -c 'notify-send "PostInstallerF" "Recuerde los cambios hechos en los repositorios" -i "/usr/share/icons/sistema.png" -t 5000'

}

nvidia(){

PKGSINSTALLED=$(rpm -qa *kmod-nvidia*)
targra=$(lspci | grep -i nvidia | grep VGA |grep -i GeForce | awk '{print $8,$9,$10}' | sed 's/[[]//g' | sed 's/[]]//g'); echo "targra=$targra"

lspci | grep -i nvidia | grep VGA | awk '{print $8,$9,$10}' | sed 's/[[]//g' | sed 's/[]]//g' >> /tmp/targra2.txt

# Check if user really has a nvidia video card
	VGA=$(lspci | grep -i nvidia | grep VGA) > /dev/null
	if [[ "$?" != 0 ]]; then
echo 'No nVidia card detected'
zenity --info --title="PostInstallerF" --text="No nVidia card detected"
else

	if [[ -n "$PKGSINSTALLED" ]]; then

		echo 'nVidia driver seems to be already installed'
zenity --info --title="PostInstallerF" --text="nVidia driver seems to be already installed"
else

foo8=$(w3m -dump ftp://download.nvidia.com/XFree86/Linux-x86_64/290.10/README/supportedchips.html); echo "foo8=$foo8" >> /tmp/nvdia.txt


egrep 'GeForce 6' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce 7' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce 8' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce 2' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce 3' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce 4' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce 5' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce FX' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce4' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt
egrep 'GeForce2' /tmp/nvdia.txt | sed '1d' | awk '{print $1,$2,$3,$4,$5}' >> /tmp/lastest_nvdia.txt

wait ${!}

VGA=$(grep "$targra" /tmp/lastest_nvdia.txt) > /dev/null
	if [[ "$?" != 0 ]]; then
echo 'No nVidia card compatible'
cat /dev/null > /tmp/nvdia.txt
cat /dev/null > /tmp/lastest_nvdia.txt
cat /dev/null > /tmp/targra2.txt
zenity --info --title="PostInstallerF" --text="No nVidia card compatible"
else
echo 'ya la hiciste rey'
zenity --question --title="Do you want install Nvidia Drivers?" --text="Remember this funtion is experimental" --ok-label "Yes" --cancel-label "No"

if [[ $? -eq 0 ]]; then

VGA3=$(grep 'GeForce FX' /tmp/targra2.txt) > /dev/null
	if [[ "$?" = 0 ]]; then
echo '173.14.xx driver'
yum -y update kernel | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando el kernel" --text="Por favor espere puede tardar mucho...." --pulsate --auto-close --width=350

yum -y install akmod-nvidia-173xx xorg-x11-drv-nvidia-173xx-libs.i686 | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Nvidia Drivers" --text="Por favor espere...." --pulsate --auto-close --width=350

mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

dracut /boot/initramfs-$(uname -r).img $(uname -r)

xterm -e 'nvidia-xconfig'

cat /dev/null > /tmp/nvdia.txt
cat /dev/null > /tmp/lastest_nvdia.txt
cat /dev/null > /tmp/targra2.txt

su $noti -c 'notify-send "PostInstallerF" "Se ha instalado los drivers Nvidia, por favor reinicie el sistema" -i "/usr/share/icons/sistema.png" -t 5000'
fi

VGA4=$(grep -e 'GeForce4' -e 'GeForce2' /tmp/targra2.txt) > /dev/null
	if [[ "$?" = 0 ]]; then
echo '96.43.xx driver'
yum -y update kernel | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando el kernel" --text="Por favor espere puede tardar mucho...." --pulsate --auto-close --width=350

yum -y install akmod-nvidia-96xx xorg-x11-drv-nvidia-96xx-libs.i686 | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Nvidia Drivers" --text="Por favor espere...." --pulsate --auto-close --width=350

mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

dracut /boot/initramfs-$(uname -r).img $(uname -r)

xterm -e 'nvidia-xconfig'

cat /dev/null > /tmp/nvdia.txt
cat /dev/null > /tmp/lastest_nvdia.txt
cat /dev/null > /tmp/targra2.txt

su $noti -c 'notify-send "PostInstallerF" "Se ha instalado los drivers Nvidia, por favor reinicie el sistema" -i "/usr/share/icons/sistema.png" -t 5000'
fi


VGA7=$(grep -e 'GeForce 2' -e 'GeForce 3' -e 'GeForce 4' -e 'GeForce 5' -e 'GeForce 6' -e 'GeForce 7' /tmp/targra2.txt) > /dev/null
	if [[ "$?" = 0 ]]; then
echo 'Series 304'
yum -y update kernel | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando el kernel" --text="Por favor espere puede tardar mucho...." --pulsate --auto-close --width=350

yum -y install akmod-nvidia-304xx xorg-x11-drv-nvidia-304xx-libs | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Nvidia Drivers" --text="Por favor espere...." --pulsate --auto-close --width=350

mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

dracut /boot/initramfs-$(uname -r).img $(uname -r)

xterm -e 'nvidia-xconfig'

cat /dev/null > /tmp/nvdia.txt
cat /dev/null > /tmp/lastest_nvdia.txt
cat /dev/null > /tmp/targra2.txt

su $noti -c 'notify-send "PostInstallerF" "Se ha instalado los drivers Nvidia, por favor reinicie el sistema" -i "/usr/share/icons/sistema.png" -t 5000'
fi


VGA8=$(grep -e 'GeForce 8' -e 'GeForce 9' /tmp/targra2.txt) > /dev/null
	if [[ "$?" = 0 ]]; then
echo 'Nuevos controladores'
yum -y update kernel | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando el kernel" --text="Por favor espere puede tardar mucho...." --pulsate --auto-close --width=350

yum -y install akmod-nvidia xorg-x11-drv-nvidia-libs | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Nvidia Drivers" --text="Por favor espere...." --pulsate --auto-close --width=350

mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

dracut /boot/initramfs-$(uname -r).img $(uname -r)

xterm -e 'nvidia-xconfig'

cat /dev/null > /tmp/nvdia.txt
cat /dev/null > /tmp/lastest_nvdia.txt
cat /dev/null > /tmp/targra2.txt

su $noti -c 'notify-send "PostInstallerF" "Se ha instalado los drivers Nvidia, por favor reinicie el sistema" -i "/usr/share/icons/sistema.png" -t 5000'
fi


fi
echo 'cuando tu quieras'
fi
fi
 fi


}


ativide(){

ATIINSTALLED=$(rpm -qa *kmod-catalyst*)

lspci | grep -e AMD -e ATI >> /tmp/targra4.txt

VGA2=$(lspci | grep -e AMD -e ATI) > /dev/null
	if [[ "$?" != 0 ]]; then
echo "No ATI card detected"
cat /dev/null > /tmp/targra4.txt
zenity --info --title="PostInstallerF" --text="No ATI card detected"
else

VGA6=$(grep -e 'RadeonHD 2' -e 'RadeonHD 3' -e 'RadeonHD 4' -e 'RadeonHD 5' -e 'RadeonHD 6' -e 'RadeonHD 7' -e 'RadeonHD 8'  /tmp/targra4.txt) > /dev/null
	if [[ "$?" = 0 ]]; then
echo "ATI card supported"
if [ -f /usr/share/ati/amd-uninstall.sh ]; then
xterm -e "sh /usr/share/ati/amd-uninstall.sh"
wait ${!}
yum -y reinstall mesa-libGL | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Reinstalling mesa-libGL" --text="Por favor espere...." --pulsate --auto-close --width=350
yum -y update kernel | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando el kernel" --text="Por favor espere puede tardar mucho...." --pulsate --auto-close --width=350
yum -y install akmod-catalyst xorg-x11-drv-catalyst xorg-x11-drv-catalyst-libs | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Ati Drivers" --text="Por favor espere...." --pulsate --auto-close --width=350
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-radeon.img
dracut /boot/initramfs-$(uname -r).img $(uname -r)
xterm -e 'glxinfo |grep -i "\(render\|opengl\)"'
cat /dev/null > /tmp/targra4.txt
su $noti -c 'notify-send "PostInstallerF" "Se ha instalado los drivers Ati, por favor reinicie el sistema" -i "/usr/share/icons/sistema.png" -t 5000'


elif [[ -n "$ATIINSTALLED" ]]; then

echo "ATI driver seems to be already installed."
zenity --info --title="PostInstallerF" --text="ATI driver seems to be already installed."
else
yum -y update kernel | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando el kernel" --text="Por favor espere puede tardar mucho...." --pulsate --auto-close --width=350
yum -y install akmod-catalyst xorg-x11-drv-catalyst xorg-x11-drv-catalyst-libs | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Ati Drivers" --text="Por favor espere...." --pulsate --auto-close --width=350
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-radeon.img
dracut /boot/initramfs-$(uname -r).img $(uname -r)
xterm -e 'glxinfo |grep -i "\(render\|opengl\)"'
cat /dev/null > /tmp/targra4.txt
su $noti -c 'notify-send "PostInstallerF" "Se ha instalado los drivers Ati, por favor reinicie el sistema" -i "/usr/share/icons/sistema.png" -t 5000'
fi
else
echo 'No Ati card compatible'
cat /dev/null > /tmp/targra4.txt
zenity --info --title="PostInstallerF" --text="No Ati card compatible"
fi

fi


}


actualizar(){

xterm -e 'rm -f /var/lib/rpm/_db*'

xterm -e 'rpm -vv --rebuilddb' 

package-cleanup --cleandupes -y | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/trashito.png" --image-on-top --progress --title "Eliminando paquetes duplicados" --text="Por favor espere...." --pulsate --auto-close --width=350

yum clean all | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/trashito.png" --image-on-top --progress --title "limpiando repositorios" --text="Por favor espere...." --pulsate --auto-close --width=350 

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando el Sistema" --text="Por favor espere puede tardar mucho...." --pulsate --auto-close --width=350

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando el Sistema" --text="Por favor espere puede tardar mucho...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "Se ha actualizado el sistema" -i "/usr/share/icons/sistema.png" -t 5000'

    }


cleanlog(){
            cat /dev/null > /usr/share/.postinstallerf/installed.log

su $noti -c 'notify-send "PostInstallerF" "Se ha realizado el reset de PostInstallerF" -i "/usr/share/icons/sistema.png" -t 5000'

    }


delpost(){


zenity --question --title="PostInstallerF" --text="Do you want uninstall PostIstallerF?" --ok-label "Yes" --cancel-label "No"

if [[ $? -eq 0 ]]; then
            
yum -y remove postinstallerf | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/trashito.png" --image-on-top --progress --title "Eliminando PostInstallerF" --text="Por favor espere...." --pulsate --auto-close --width=350

su $noti -c 'notify-send "PostInstallerF" "Se ha eliminado PostInstallerF, fué un gusto poder ayudarte" -i "/usr/share/icons/sistema.png" -t 5000'

else
echo 'Cuando tu quieras'
fi


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

#Otra alternativa para comparar varias variables
#if [[ $loca!=`$loca && $loca3 && $loca4 && $loca5 && $loca6` ]]; 


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
       su $noti -c 'notify-send "Terminado!" "Todo está completado" -i "/usr/share/icons/pinguino.png" -t 10000'
       
            
    fi

     
    exit 0
