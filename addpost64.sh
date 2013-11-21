#!/bin/bash
#
# +--------------------------------------------------------------------------------+
# | Copyright (C) 2013 Kuboosoft                                                   |
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
# FEDORA 19,20 ADPOST 1.2.2 64 BITS

# ACTUALIZACION DE ADPOST
updater=/usr/share/updatepostintaller/addpost64.sh
if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/addpost64.sh
echo "se elimino el archivo obsoleto de actualizacion"
else
echo "Aun no se ha descargado el archivo de actualizacion"
fi

if [ -d /usr/share/updatepostintaller/ ]; then
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/addpost64.sh'
else
mkdir /usr/share/updatepostintaller/
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/addpost64.sh'
fi 

source=/usr/bin/postinstallerf/addpost64.sh
update=/usr/share/updatepostintaller/addpost64.sh

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
zenity --info --text "Install se encuentra actualizado" --title "PostInstallerF" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/addpost64.sh /usr/bin/postinstallerf/ 
zenity --info --text "Install se ha actualizado
Por favor Reinicie Install" --title "PostInstallerF" --timeout=5
fi
 else
diff -a $source $update
if [ $? -eq 0 ]; then
echo "Los ficheros son iguales"
zenity --info --text "Install is updated" --title "PostInstallerF" --timeout=5
else
echo "Los ficheros No son iguales"
cp -f /usr/share/updatepostintaller/addpost64.sh /usr/bin/postinstallerf/ 
zenity --info --text "Install was updated
Please Restart Install" --title "PostInstallerF" --timeout=5
fi
fi



# +--------------------------------------------------------------------------------------------------+
# |AQUI INICIA EL MENU                                                                               |
# +--------------------------------------------------------------------------------------------------+

    generateInstallMenu(){ 
            im="yad --image="/usr/share/icons/acciones/add.png" --image-on-top --class="Install" --window-icon="/usr/share/icons/acciones/add.png" --list --checklist  --width=700 --height=500 --title \"PostInstallerF for Fedora 64bit (Ver 1.2.0)\" --text \"Select items from the list below\" "
            im=$im"--column=\"\" --column \"Application\" --column \"Description\"    --column \"Status\"                           "

 # Building Install Menue

            # Building Install Menue

if [ $(echo $LANG | cut -b1-2) = "es" ]; then

            if ! $installed | grep "Repositorios RPM Fusion" > /dev/null; then
if [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ]; then
                    im=$im"FALSE \"Repositorios RPM Fusion\"     \"Proporciona un repositorio que se puede acceder usando yum y PackageKit para el software del Proyecto Fedora [Recomendado]\" \"ACTIVADO  \"  "
else
im=$im"FALSE \"Repositorios RPM Fusion\"     \"Proporciona un repositorio que se puede acceder usando yum y PackageKit para el software del Proyecto Fedora [Recomendado]\" \"NO ACTIVADO  \"  "
fi
            fi

if ! $installed | grep "Cambiar lenguaje del sistema" > /dev/null; then
if [ -f /usr/bin/system-config-language ]; then
                    im=$im"FALSE \"Cambiar lenguaje del sistema\"             \"Elige tu lenguaje materno\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Cambiar lenguaje del sistema\"             \"Elige tu lenguaje materno\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Herramientas Básicas de compilación" > /dev/null; then
if [ -f /usr/bin/make ]
then
                    im=$im"FALSE \"Herramientas Básicas de compilación\"                  \"Compila tus programas\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Herramientas Básicas de compilación\"                  \"Compila tus programas\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Mozilla Firefox" > /dev/null; then
if [ -f /usr/bin/firefox ]
then
                    im=$im"FALSE \"Mozilla Firefox\"                  \"Navegador web de mozilla.org\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Mozilla Firefox\"                  \"Navegador web de mozilla.org\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Instalar Codecs Audio/Video" > /dev/null; then
if [ -d /usr/share/doc/gstreamer-plugins-bad-nonfree-* ]; then
                    im=$im"FALSE \"Instalar Codecs Audio/Video\"      \"Todo lo necesario para reproduccion de audio y video\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Instalar Codecs Audio/Video\"      \"Todo lo necesario para reproduccion de audio y video\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Flash Player" > /dev/null; then
if [ -f /usr/bin/flash-player-properties ]; then
                    im=$im"FALSE \"Flash Player\"           \"Plugin necesario para reproduccion flash del navegador\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Flash Player\"           \"Plugin necesario para reproduccion flash del navegador\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Unrar y p7zip" > /dev/null; then
if [ -f /usr/bin/unrar ] && [ -f /usr/bin/7za ]; then
                    im=$im"FALSE \"Unrar y p7zip\"                   \"Descomprime archivos rar y 7zip\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Unrar y p7zip\"                   \"Descomprime archivos rar y 7zip\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Java OpenJDK" > /dev/null; then

if [ -f /usr/bin/java ]; then
                    im=$im"FALSE \"Java OpenJDK\"           \"Ejecucion de archivos o programas escritos en java\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Java OpenJDK\"           \"Ejecucion de archivos o programas escritos en java\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Java JRE Oracle" > /dev/null; then

if [ -f /usr/java/latest/lib/i386/libnpjp2.so ] || [ -f /usr/java/latest/lib64/x86_64/libnpjp2.so ]; then
                    im=$im"FALSE \"Java JRE Oracle\"           \"Implementation propietaria del lenguaje de programacion Java.\" \"INSTALADO [$versionjava] \"  "
else
im=$im"FALSE \"Java JRE Oracle\"           \"Implementation propietaria del lenguaje de programacion Java.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Java JDK Oracle" > /dev/null; then

if [ -f /usr/java/latest/jre/lib/amd64/libnpjp2.so ] || [ -f /usr/java/latest/jre/lib/i386/libnpjp2.so ]; then
                    im=$im"FALSE \"Java JDK Oracle\"     \"Oracle Java Runtime Environment [Desarrolladores]\" \"INSTALADO [$versionjkd]  \"  "
else
im=$im"FALSE \"Java JDK Oracle\"     \"Oracle Java Runtime Environment [Desarrolladores]\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "GIMP" > /dev/null; then
if [ -f /usr/bin/gimp ]
 then
                    im=$im"FALSE \"GIMP\"            \"Edición de imágenes digitales en forma de mapa de bits, tanto dibujos como fotografías\" \"INSTALADO  \"  "
else
im=$im"FALSE \"GIMP\"            \"Edición de imágenes digitales en forma de mapa de bits, tanto dibujos como fotografías\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Hugin" > /dev/null; then
if [ -f /usr/bin/hugin ]
 then
                    im=$im"FALSE \"Hugin\"            \"Une múltiples imágenes, la imagen resultante puede abarcar 360 grados. Excelentes imágenes panorámicas\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Hugin\"            \"Une múltiples imágenes, la imagen resultante puede abarcar 360 grados. Excelentes imágenes panorámicas.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Converseen" > /dev/null; then
if [ -f /usr/bin/converseen ]; then
                    im=$im"FALSE \"Converseen\"            \"Convertir y cambiar el tamaño de un número ilimitado de imágenes a cualquiera de los formatos más populares: DPX, EXR, GIF, JPEG, JPEG 2000, PDF, PhotoCD, PNG, Postscript, SVG, y TIFF\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Converseen\"            \"Convertir y cambiar el tamaño de un número ilimitado de imágenes a cualquiera de los formatos más populares: DPX, EXR, GIF, JPEG, JPEG 2000, PDF, PhotoCD, PNG, Postscript, SVG, y TIFF\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "MyPaint" > /dev/null; then
if [ -f /usr/bin/mypaint ]; then
                    im=$im"FALSE \"MyPaint\" \"MyPaint es una aplicación de software libre para ilustrar y dibujar con una tableta digitalizadora\" \"INSTALADO  \"  "
else
im=$im"FALSE \"MyPaint\" \"MyPaint es una aplicación de software libre para ilustrar y dibujar con una tableta digitalizadora\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Pinta" > /dev/null; then
if [ -f /usr/bin/pinta ]; then
                    im=$im"FALSE \"Pinta\" \"Pinta es un programa de dibujo libre y de codigo y modelado similar Paint.NET.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Pinta\" \"Pinta es un programa de dibujo libre y de codigo y modelado similar Paint.NET.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Pencil" > /dev/null; then
if [ -f /usr/bin/pencil ]; then
                    im=$im"FALSE \"Pencil\" \"Herramienta opensource para hacer diagramas y prototipos de interfaz gráfica de usuario.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Pencil\" \"Herramienta opensource para hacer diagramas y prototipos de interfaz gráfica de usuario.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Fotoxx" > /dev/null; then
if [ -f /usr/bin/fotoxx ]; then
                    im=$im"FALSE \"Fotoxx\"               \"Edición de fotos y gestión de la colección\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Fotoxx\"               \"Edición de fotos y gestión de la colección\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Shutter" > /dev/null; then
if [ -f /usr/bin/shutter ]; then
                    im=$im"FALSE \"Shutter\"       \"Shutter es un programa con características ricas de captura de pantalla\" \"INSTALADO  \"  "
else
m=$im"FALSE \"Shutter\"       \"Shutter es un programa con características ricas de captura de pantalla\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Glabels" > /dev/null; then
if [ -f /usr/bin/glabels-* ]; then
                    im=$im"FALSE \"Glabels\"            \"Es un programa para crear etiquetas y tarjetas de visita para el entorno de escritorio GNOME\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Glabels\"            \"Es un programa para crear etiquetas y tarjetas de visita para el entorno de escritorio GNOME\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Kover" > /dev/null; then
if [ -f /usr/bin/kover ]; then
                    im=$im"FALSE \"Kover\"              \"Kover es una aplicación informática libre que permite diseñar e imprimir carátulas de CD\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Kover\"              \"Kover es una aplicación informática libre que permite diseñar e imprimir carátulas de CD\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "LibreOffice" > /dev/null; then
if [ -d /usr/lib/libreoffice/ ]; then
                    im=$im"FALSE \"LibreOffice\"         \"LibreOffice es la suite de productividad personal de código abierto para GNU/Linux\" \"INSTALADO  \"  "
else
im=$im"FALSE \"LibreOffice\"         \"LibreOffice es la suite de productividad personal de código abierto para GNU/Linux\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Basket" > /dev/null; then
if [ -f /usr/bin/basket ]; then
                    im=$im"FALSE \"Basket\"         \"Organiza tus notas en una jerarquía de canastas, estupendo organizador de notas.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Basket\"         \"Organiza tus notas en una jerarquía de canastas, estupendo organizador de notas.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "ProjectLibre" > /dev/null; then
if [ -f /usr/bin/projectlibre ]; then
                    im=$im"FALSE \"ProjectLibre\"         \"ProjectLibre es la alternativa de código abierto a Microsoft Project.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"ProjectLibre\"         \"ProjectLibre es la alternativa de código abierto a Microsoft Project.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Adobe Reader" > /dev/null; then
                    if [ -f /usr/bin/acroread ]; then
                    im=$im"FALSE \"Adobe Reader\"             \"Visor de PDF fácil de ver, buscar, imprimir\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Adobe Reader\"             \"Visor de PDF fácil de ver, buscar, imprimir\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "PDF Mod" > /dev/null; then
if [ -f /usr/bin/pdfmod ]; then
                    im=$im"FALSE \"PDF Mod\"                \"PDF Mod es una sencilla aplicación para la modificación de documentos PDF\" \"INSTALADO  \"  "
else
im=$im"FALSE \"PDF Mod\"                \"PDF Mod es una sencilla aplicación para la modificación de documentos PDF\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "PDF Split and Merge" > /dev/null; then
if [ -f /usr/bin/pdfsam ]; then
                    im=$im"FALSE \"PDF Split and Merge\"                \"Herramienta fácil de usar para combinar y dividir documentos en formato pdf\" \"INSTALADO  \"  "
else
im=$im"FALSE \"PDF Split and Merge\"                \"Herramienta fácil de usar para combinar y dividir documentos en formato pdf\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "YAGF" > /dev/null; then
if [ -f /usr/bin/yagf ]; then
                    im=$im"FALSE \"YAGF\"                \"Herramienta de reconocimiento de texto con interfaz gráfica para la escritura cuneiforme y Tesseract.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"YAGF\"                \"Herramienta de reconocimiento de texto con interfaz gráfica para la escritura cuneiforme y Tesseract.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Scribus" > /dev/null; then
if [ -f /usr/bin/scribus ]; then
                    im=$im"FALSE \"Scribus\"               \"Scribus es un programa de maquetación de páginas de código abierto\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Scribus\"               \"Scribus es un programa de maquetación de páginas de código abierto\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Dia" > /dev/null; then
if [ -f /usr/bin/dia ]; then
                    im=$im"FALSE \"Dia\"                   \"Dia es más o menos inspirado en el programa comercial de Windows Visio\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Dia\"                   \"Dia es más o menos inspirado en el programa comercial de Windows Visio\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Gnumeric" > /dev/null; then
if [ -f /usr/bin/gnumeric ]; then
                    im=$im"FALSE \"Gnumeric\"                 \"Gnumeric es una hoja de cálculo libre que forma parte del entorno de escritorio GNOME\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Gnumeric\"                 \"Gnumeric es una hoja de cálculo libre que forma parte del entorno de escritorio GNOME\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Planner" > /dev/null; then
if [ -f /usr/bin/planner ]; then
                    im=$im"FALSE \"Planner\"            \"Planner es la mejor herramienta de creacion y gestión de proyectos, una alternativa a Microsoft Project\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Planner\"            \"Planner es la mejor herramienta de creacion y gestión de proyectos, una alternativa a Microsoft Project\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "VYM" > /dev/null; then
if [ -f /usr/bin/vym ]; then
                    im=$im"FALSE \"VYM\"                   \"(Ver su mente) es una herramienta para generar y manipular mapas que muestran sus pensamientos,conocidos como mapa mentales\" \"INSTALADO  \"  "
else
im=$im"FALSE \"VYM\"                   \"(Ver su mente) es una herramienta para generar y manipular mapas que muestran sus pensamientos,conocidos como mapa mentales\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Freemind" > /dev/null; then
if [ -f /usr/bin/freemind ]; then
                    im=$im"FALSE \"Freemind\"             \"Un programa premier para crear mapas mentales, hecho en java\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Freemind\"             \"Un programa premier para crear mapas mentales, hecho en java\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "yEd" > /dev/null; then
if [ -f /opt/yEd/yEd ]; then
                    im=$im"FALSE \"yEd\"             \"Aplicación de escritorio potente que puede usarse para generar de forma rápida y eficaz diagramas de alta calidad.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"yEd\"             \"Aplicación de escritorio potente que puede usarse para generar de forma rápida y eficaz diagramas de alta calidad.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Cmap Tools" > /dev/null; then
if [ -f $HOME/IHMC_CmapTools/bin/update ]; then
                    im=$im"FALSE \"Cmap Tools\"             \"Construir, navegar, compartir y criticar modelos de conocimiento representados como mapas conceptuales.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Cmap Tools\"             \"Construir, navegar, compartir y criticar modelos de conocimiento representados como mapas conceptuales.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Anki" > /dev/null; then
if [ -f /usr/bin/anki ]; then
                    im=$im"FALSE \"Anki\"                \"Programa que hace recordar las cosas fáciles. Debido a que es mucho más eficiente que los métodos tradicionales de estudio.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Anki\"                \"Programa que hace recordar las cosas fáciles. Debido a que es mucho más eficiente que los métodos tradicionales de estudio.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Wine y winetricks" > /dev/null; then
if [ -f /usr/bin/wine ] && [ -f /usr/bin/winetricks ]; then
                    im=$im"FALSE \"Wine y winetricks\"                  \"Instala algunas aplicaciones de windows\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Wine y winetricks\"                  \"Instala algunas aplicaciones de windows\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Oracle Virtual Box" > /dev/null; then
if [ -f '/etc/yum.repos.d/virtualbox.repo' ] && [ -f /usr/bin/VirtualBox ]; then
                    im=$im"FALSE \"Oracle Virtual Box\"            \"Software de virtualización para arquitecturas x86/amd64\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Oracle Virtual Box\"            \"Software de virtualización para arquitecturas x86/amd64\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "PlayOnLinux" > /dev/null; then
if [ -f /usr/bin/playonlinux ]; then
                    im=$im"FALSE \"PlayOnLinux\"                \"Programa que nos permite instalar y usar fácilmente numerosos juegos y programas para Windows®\" \"INSTALADO  \"  "
else
im=$im"FALSE \"PlayOnLinux\"                \"Programa que nos permite instalar y usar fácilmente numerosos juegos y programas para Windows®\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "TeamViewer" > /dev/null; then
if [ -f /opt/teamviewer/teamviewer ]; then
                    im=$im"FALSE \"TeamViewer\"                  \"La solución All-In-One para el acceso remoto y la asistencia a través de internet\" \"INSTALADO  \"  "
else
im=$im"FALSE \"TeamViewer\"                  \"La solución All-In-One para el acceso remoto y la asistencia a través de internet\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "DropBox" > /dev/null; then
if [ -f /usr/bin/dropbox ]; then
                    im=$im"FALSE \"DropBox\"                    \"Dropbox es un servicio de alojamiento de archivos multiplataforma en la nube, operado por la compañía Dropbox\" \"INSTALADO  \"  "
else
im=$im"FALSE \"DropBox\"                    \"Dropbox es un servicio de alojamiento de archivos multiplataforma en la nube, operado por la compañía Dropbox\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Hyper Video Converter" > /dev/null; then
if [ -f /usr/bin/hypervc ]; then
                    im=$im"FALSE \"Hyper Video Converter\"                   \"Conversion de video profesional\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Hyper Video Converter\"                   \"Conversion de video profesional\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Miro Video Converter" > /dev/null; then
if [ -f /usr/bin/miro-video-converter.py ]; then
                    im=$im"FALSE \"Miro Video Converter\"                   \"Conversion de videos desde y hacia diferentes formatos, incluyendo formatos para dispositivos como teléfonos Android.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Miro Video Converter\"                   \"Conversion de videos desde y hacia diferentes formatos, incluyendo formatos para dispositivos como teléfonos Android.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Arista Transcoder" > /dev/null; then
if [ -f /usr/bin/arista-gtk ]; then
                    im=$im"FALSE \"Arista Transcoder\"                   \"Conversion de video para dispositivos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Arista Transcoder\"                   \"Conversion de video para dispositivos\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Qwinff" > /dev/null; then
if [ -f /usr/bin/qwinff ]; then
                    im=$im"FALSE \"Qwinff\"                   \"QWinFF es un multiplataforma, y fácil de usar convertidor de medios frontend de FFmpeg.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Qwinff\"                   \"QWinFF es un multiplataforma, y fácil de usar convertidor de medios frontend de FFmpeg.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Transcoder" > /dev/null; then
if [ -f /usr/share/applications/Transcoder.desktop ] && [ -f /usr/local/bin/Transcoder/Transcoder ]; then
                    im=$im"FALSE \"Transcoder\"                \"Simple conversion de video y audio\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Transcoder\"                \"Simple conversion de video y audio\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Mobilmedia Converter" > /dev/null; then
if [ -f /usr/local/bin/mmc ]; then
                    im=$im"FALSE \"Mobilmedia Converter\"                  \"Conversion de video para dispositivos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Mobilmedia Converter\"                  \"Conversion de video para dispositivos\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "YakiTo" > /dev/null; then
if [ -f /usr/bin/yakito ]; then
                    im=$im"FALSE \"YakiTo\"               \"Conversion de video profesional\" \"INSTALADO  \"  "
else
im=$im"FALSE \"YakiTo\"               \"Conversion de video profesional\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Ekd" > /dev/null; then
if [ -f /usr/bin/ekd ]; then
                    im=$im"FALSE \"Ekd\"               \"Esta aplicación puede ser utilizada para operaciones de post producción para vídeos y lotes de imágenes\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Ekd\"               \"Esta aplicación puede ser utilizada para operaciones de post producción para vídeos y lotes de imágenes\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "FF Multi Converter" > /dev/null; then
if [ -f /usr/bin/ffmulticonverter ]; then
                    im=$im"FALSE \"FF Multi Converter\"               \"Sencilla aplicación que le permite convertir archivos de audio, vídeo, imágenes y documentos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"FF Multi Converter\"               \"Sencilla aplicación que le permite convertir archivos de audio, vídeo, imágenes y documentos\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "GtkPod" > /dev/null; then
if [ -f /usr/bin/gtkpod ]; then
                    im=$im"FALSE \"GtkPod\"             \"Interfaz gráfica de usuario para el iPod de Apple\" \"INSTALADO  \"  "
else
im=$im"FALSE \"GtkPod\"             \"Interfaz gráfica de usuario para el iPod de Apple\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "EasyTag" > /dev/null; then
if [ -f /usr/bin/easytag ]; then
                    im=$im"FALSE \"EasyTag\"              \"EasyTAG es una utilidad para ver y editar las etiquetas para archivos MP3, MP2, MP4/AAC, FLAC, Ogg Vorbis, MusePack, Monkey Audio y WavPack archivos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"EasyTag\"              \"EasyTAG es una utilidad para ver y editar las etiquetas para archivos MP3, MP2, MP4/AAC, FLAC, Ogg Vorbis, MusePack, Monkey Audio y WavPack archivos\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Avidemux" > /dev/null; then
if [ -f /usr/bin/avidemux ]; then
                    im=$im"FALSE \"Avidemux\"       \"Avidemux es un editor de vídeo gratuito diseñado para corte simple, filtrado y codificación de tareas\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Avidemux\"       \"Avidemux es un editor de vídeo gratuito diseñado para corte simple, filtrado y codificación de tareas\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Blender" > /dev/null; then
if [ -f /usr/bin/blender ]; then
                    im=$im"FALSE \"Blender\"               \"Programa de modelado, animación y creación de gráficos tridimensionales\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Blender\"               \"Programa de modelado, animación y creación de gráficos tridimensionales\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Tupi" > /dev/null; then
if [ -f /usr/bin/tupi ]; then
                    im=$im"FALSE \"Tupi\"               \"Herramienta de diseño y autoría, para los artistas digitales interesados ​​en animación 2D.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Tupi\"               \"Herramienta de diseño y autoría, para los artistas digitales interesados ​​en animación 2D.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "BRL-CAD" > /dev/null; then
if [ -f /usr/brlcad/bin/brlcad-config ]; then
                    im=$im"FALSE \"BRL-CAD\"    \"BRL-CAD es un programa libre, de código abierto alternativo a AutoCAD, desarrollado por los militares de USA en colaboración con la NASA\" \"INSTALADO  \"  "
else
im=$im"FALSE \"BRL-CAD\"    \"BRL-CAD es un programa libre, de código abierto alternativo a AutoCAD, desarrollado por los militares de USA en colaboración con la NASA\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Sweet Home 3D" > /dev/null; then
if [ -f /usr/share/applications/SweetHome3D.desktop ] && [ -f /usr/bin/sweethome3d.sh ]; then
                    im=$im"FALSE \"Sweet Home 3D\"          \"Sweet Home 3D es una aplicación libre de diseño de interiores que le ayuda a colocar sus muebles sobre un plano de una casa en 2D, con una vista previa en 3D\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Sweet Home 3D\"          \"Sweet Home 3D es una aplicación libre de diseño de interiores que le ayuda a colocar sus muebles sobre un plano de una casa en 2D, con una vista previa en 3D\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Libre CAD" > /dev/null; then
if [ -f /usr/bin/librecad ]; then
                    im=$im"FALSE \"Libre CAD\"    \"LibreCAD es un libre de código abierto aplicación de CAD\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Libre CAD\"    \"LibreCAD es un libre de código abierto aplicación de CAD\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "FreeCAD" > /dev/null; then
if [ -f /usr/bin/FreeCAD ]; then
                    im=$im"FALSE \"FreeCAD\"    \"FreeCAD es un propósito general 3D CAD, MCAD, CAx, CAE y PLM modelador.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"FreeCAD\"    \"FreeCAD es un propósito general 3D CAD, MCAD, CAx, CAE y PLM modelador.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "DraftSight" > /dev/null; then
if [ -f /usr/bin/draftsight ]; then
                    im=$im"FALSE \"DraftSight\"    \"DraftSight es un programa libre de la aplicación CAD 2D que te permite crear, editar y visualizar sus archivos DWG / DXF\" \"INSTALADO  \"  "
else
im=$im"FALSE \"DraftSight\"    \"DraftSight es un programa libre de la aplicación CAD 2D que te permite crear, editar y visualizar sus archivos DWG / DXF\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Inkscape" > /dev/null; then
if [ -f /usr/bin/inkscape ]; then
                    im=$im"FALSE \"Inkscape\"                 \"Editor de Gráficos Vectoriales, similar al Adobe Illustrator, que busca ser compatible con SVG, de código abierto\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Inkscape\"                 \"Editor de Gráficos Vectoriales, similar al Adobe Illustrator, que busca ser compatible con SVG, de código abierto\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Openshot" > /dev/null; then
if [ -f /usr/bin/openshot ]; then
                    im=$im"FALSE \"Openshot\"    \"Un simple, potente y gratuito editor de vídeo con un enfoque en la facilidad de uso\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Openshot\"    \"Un simple, potente y gratuito editor de vídeo con un enfoque en la facilidad de uso\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Kdenlive" > /dev/null; then
if [ -f /usr/bin/kdenlive ]; then
                    im=$im"FALSE \"Kdenlive\"    \"Intuitivo y poderoso editor de video multi-pista, incluye las tecnologías de vídeo más recientes.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Kdenlive\"    \"Intuitivo y poderoso editor de video multi-pista, incluye las tecnologías de vídeo más recientes.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "LIVES" > /dev/null; then
if [ -f /usr/bin/lives ]; then
                    im=$im"FALSE \"LIVES\"    \"Programa de edición de video y VJ software para Linux\" \"INSTALADO  \"  "
else
im=$im"FALSE \"LIVES\"    \"Programa de edición de video y VJ software para Linux\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Imagination" > /dev/null; then
if [ -f /usr/bin/imagination ]; then
                    im=$im"FALSE \"Imagination\"    \"Ligero creador de diapositivas para DVD\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Imagination\"    \"Ligero creador de diapositivas para DVD\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "DeveDe" > /dev/null; then
if [ -f /usr/bin/devede ]; then
                    im=$im"FALSE \"DeveDe\"    \"Programa que permite crear video DVDs y CDs, aptos para un reproductor doméstico\" \"INSTALADO  \"  "
else
im=$im"FALSE \"DeveDe\"    \"Programa que permite crear video DVDs y CDs, aptos para un reproductor doméstico\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "DVDStyler" > /dev/null; then
if [ -f /usr/bin/dvdstyler ]; then
                    im=$im"FALSE \"DVDStyler\"    \"Crea menús de DVDs a tu gusto\" \"INSTALADO  \"  "
else
im=$im"FALSE \"DVDStyler\"    \"Crea menús de DVDs a tu gusto\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "ffDiaporama" > /dev/null; then
if [ -f /usr/bin/ffDiaporama ]; then
                    im=$im"FALSE \"ffDiaporama\"    \"Aplicación para la creación de secuencias de videos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"ffDiaporama\"    \"Aplicación para la creación de secuencias de videos\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Wink" > /dev/null; then
if [ -f /usr/local/bin/Wink/wink ]; then
                    im=$im"FALSE \"Wink\"    \"Software de creación de Tutoriales y Presentaciones, dirigido principalmente a la creación de videotutoriales\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Wink\"    \"Software de creación de Tutoriales y Presentaciones, dirigido principalmente a la creación de videotutoriales\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Virtual Lighttable and Darkroom" > /dev/null; then
if [ -f /usr/bin/darktable ]; then
                    im=$im"FALSE \"Virtual Lighttable and Darkroom\"    \"Es una aplicacion de flujo de trabajo y el revelador RAW para fotógrafos. Un lighttable virtual y cuarto oscuro para los fotógrafos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Virtual Lighttable and Darkroom\"    \"Es una aplicacion de flujo de trabajo y el revelador RAW para fotógrafos. Un lighttable virtual y cuarto oscuro para los fotógrafos\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Gnome Subtitles" > /dev/null; then
if [ -f /usr/bin/gnome-subtitles ]; then
                    im=$im"FALSE \"Gnome Subtitles\"    \"Un editor de subtítulos para el escritorio GNOME\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Gnome Subtitles\"    \"Un editor de subtítulos para el escritorio GNOME\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "VLC media player" > /dev/null; then
if [ -f /usr/bin/qvlc ]; then
                    im=$im"FALSE \"VLC media player\"    \"Potente reproductor multimedia y servidor de streaming\" \"INSTALADO  \"  "
else
im=$im"FALSE \"VLC media player\"    \"Potente reproductor multimedia y servidor de streaming\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Netflix Player" > /dev/null; then
if [ -f /usr/bin/netflix-desktop ]; then
                    im=$im"FALSE \"Netflix Player\"    \" Ver Peliculas & TV Shows Online.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Netflix Player\"    \" Ver Peliculas & TV Shows Online.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "XBMC" > /dev/null; then
if [ -f /usr/bin/xbmc ]; then
                    im=$im"FALSE \"XBMC\"    \"Completo centro multimedia de entretenimiento para Linux.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"XBMC\"    \"Completo centro multimedia de entretenimiento para Linux.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Clementine" > /dev/null; then
if [ -f /usr/bin/clementine ]; then
                    im=$im"FALSE \"Clementine\"    \"Reproductor musical multiplataforma. Está inspirado en Amarok\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Clementine\"    \"Reproductor musical multiplataforma. Está inspirado en Amarok\" \"NO INSTALADO  \"  "
fi
            fi
 
if ! $installed | grep "Sound converter" > /dev/null; then
if [ -f /usr/bin/soundconverter ]; then
                    im=$im"FALSE \"Sound converter\"    \"SoundConverter es el convertidor de archivos de audio principal para el escritorio GNOME\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Sound converter\"    \"SoundConverter es el convertidor de archivos de audio principal para el escritorio GNOME\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Audacity" > /dev/null; then
if [ -f /usr/bin/audacity ]; then
                    im=$im"FALSE \"Audacity\"    \"Un editor de audio y grabador de Linux gratuito y fácil de usar\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Audacity\"    \"Un editor de audio y grabador de Linux gratuito y fácil de usar\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "OcenAudio" > /dev/null; then
if [ -f /usr/bin/ocenaudio ]; then
                    im=$im"FALSE \"OcenAudio\"    \"Programa multiplataforma de edicion de audio rápido, funcional y fácil de usar.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"OcenAudio\"    \"Programa multiplataforma de edicion de audio rápido, funcional y fácil de usar.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Mixxx" > /dev/null; then
if [ -f /usr/bin/mixxx ]; then
                    im=$im"FALSE \"Mixxx\"    \"Mixxx tiene todo lo necesario para empezar a hacer mezclas de DJ con un ajustado paquete integrado.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Mixxx\"    \"Mixxx tiene todo lo necesario para empezar a hacer mezclas de DJ con un ajustado paquete integrado.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "SKYPE" > /dev/null; then
if [ -f /usr/bin/skype ]; then
                    im=$im"FALSE \"SKYPE\"    \"Te brinda la facilidad de llamar barato o de hacer llamadas gratis entre usuarios de Skype\" \"INSTALADO  \"  "
else
im=$im"FALSE \"SKYPE\"    \"Te brinda la facilidad de llamar barato o de hacer llamadas gratis entre usuarios de Skype\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Jitsi" > /dev/null; then
if [ -f /usr/bin/jitsi ]; then
                    im=$im"FALSE \"Jitsi\"    \"Un audio / video y comunicador de chat que soporta protocolos como SIP, XMPP / Jabber, AIM / ICQ, Windows Live, Yahoo!.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Jitsi\"    \"Un audio / video y comunicador de chat que soporta protocolos como SIP, XMPP / Jabber, AIM / ICQ, Windows Live, Yahoo!.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Turpial" > /dev/null; then
if [ -f /usr/bin/turpial ]; then
                    im=$im"FALSE \"Turpial\"    \"Cliente alternativo para la red Twitter con múltiples interfaces\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Turpial\"    \"Cliente alternativo para la red Twitter con múltiples interfaces\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Gwibber" > /dev/null; then
if [ -f /usr/bin/gwibber ]; then
                    im=$im"FALSE \"Gwibber\"    \"Cliente de microblogging para el entorno de escritorio GNOME\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Gwibber\"    \"Cliente de microblogging para el entorno de escritorio GNOME\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Bible Time" > /dev/null; then
if [ -f /usr/bin/bibletime ]; then
                    im=$im"FALSE \"Bible Time\"    \"Biblia para Linux\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Bible Time\"    \"Biblia para Linux\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Tuxpaint" > /dev/null; then
if [ -f /usr/bin/tuxpaint ]; then
                    im=$im"FALSE \"Tuxpaint\"    \"Programa de diseño gratuito para niños de 3 años y más\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Tuxpaint\"    \"Programa de diseño gratuito para niños de 3 años y más\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Stellarium" > /dev/null; then
if [ -f /usr/bin/stellarium ]; then
                    im=$im"FALSE \"Stellarium\"    \"Programa planetario, muestra un cielo realista en 3D tal como se aprecia a simple vista, con binoculares o telescopio\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Stellarium\"    \"Programa planetario, muestra un cielo realista en 3D tal como se aprecia a simple vista, con binoculares o telescopio\" \"INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Celestia" > /dev/null; then
if [ -f /usr/bin/celestia ]; then
                    im=$im"FALSE \"Celestia\"    \"Simulación de espacio visual de tiempo real OpenGL\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Celestia\"    \"Simulación de espacio visual de tiempo real OpenGL\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Google Earth" > /dev/null; then
if [ -f /opt/google/earth/free/googleearth ]; then
                    im=$im"FALSE \"Google Earth\"    \"Programa informático similar a un Sistema de Información Geográfica (SIG)\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Google Earth\"    \"Programa informático similar a un Sistema de Información Geográfica (SIG)\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Gcompris" > /dev/null; then
if [ -f /usr/bin/gcompris ]; then
                    im=$im"FALSE \"Gcompris\"    \"GCompris es un programa de cómputo educacional con diferentes actividades para niños entre 2 y 10 años de edad\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Gcompris\"    \"GCompris es un programa de cómputo educacional con diferentes actividades para niños entre 2 y 10 años de edad\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "TuxMath" > /dev/null; then
if [ -f /usr/bin/tuxmath ]; then
                    im=$im"FALSE \"TuxMath\"    \"Tutor de escritura con un juego de arcade\" \"INSTALADO  \"  "
else
im=$im"FALSE \"TuxMath\"    \"Tutor de escritura con un juego de arcade\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "TuxType" > /dev/null; then
if [ -f /usr/bin/tuxtype ]; then
                    im=$im"FALSE \"TuxType\"    \"Simulación de espacio visual de tiempo real OpenGL\" \"INSTALADO  \"  "
else
im=$im"FALSE \"TuxType\"    \"Simulación de espacio visual de tiempo real OpenGL\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Childsplay" > /dev/null; then
if [ -f /usr/bin/childsplay ]; then
                    im=$im"FALSE \"Childsplay\"    \"Excelente paquete de juegos educativos para niños\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Childsplay\"    \"Excelente paquete de juegos educativos para niños\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Scratch" > /dev/null; then
if [ -f /usr/bin/scratch ]; then
                    im=$im"FALSE \"Scratch\"    \"Lenguaje de programación para todo el mundo. Crear historias interactivas, juegos, música y arte\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Scratch\"    \"Lenguaje de programación para todo el mundo. Crear historias interactivas, juegos, música y arte\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Ri-li" > /dev/null; then
if [ -f /usr/bin/Ri_li ]; then
                    im=$im"FALSE \"Ri-li\"    \"Juego para niños, Usted conduce un motor de madera de juguete en muchos niveles y tienes que recoger todos los vagones para ganar\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Ri-li\"    \"Juego para niños, Usted conduce un motor de madera de juguete en muchos niveles y tienes que recoger todos los vagones para ganar\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Frozen Bubble" > /dev/null; then
if [ -f /usr/bin/frozen-bubble ]; then
                    im=$im"FALSE \"Frozen Bubble\"    \"Videojuego de puzzles inspirado en Puzzle Bobble\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Frozen Bubble\"    \"Videojuego de puzzles inspirado en Puzzle Bobble\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Extreme Tux Racer" > /dev/null; then
if [ -f /usr/bin/etracer ]; then
                    im=$im"FALSE \"Extreme Tux Racer\"    \"Un proyecto de código abierto en el que el usuario toma la forma de Tux y las carreras de descenso a través de senderos alpinos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Extreme Tux Racer\"    \"Un proyecto de código abierto en el que el usuario toma la forma de Tux y las carreras de descenso a través de senderos alpinos\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Super Tux Kart" > /dev/null; then
if [ -f /usr/bin/supertuxkart ]; then
                    im=$im"FALSE \"Super Tux Kart\"    \"Juego libre y gratuito de carreras de coches tipo arcade en 3D, cuyo protagonista es Tux\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Super Tux Kart\"    \"Juego libre y gratuito de carreras de coches tipo arcade en 3D, cuyo protagonista es Tux\" \"NO INSTALADO  \"  "
fi
            fi



if ! $installed | grep "Wormux" > /dev/null; then
if [ -f /usr/bin/wormux ]; then
                    im=$im"FALSE \"Wormux\"    \"Juego de asesinato en masa 2D\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Wormux\"    \"Juego de asesinato en masa 2D\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Tremulous" > /dev/null; then
if [ -f /usr/bin/tremded ]; then
                    im=$im"FALSE \"Tremulous\"    \"Juego de disparos en primera persona, usando el motor de Quake 3\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Tremulous\"    \"Juego de disparos en primera persona, usando el motor de Quake 3\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Super Methane Brothers" > /dev/null; then
if [ -f /usr/bin/methane ]; then
                    im=$im"FALSE \"Super Methane Brothers\"    \"Juego de plataforma 2D\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Super Methane Brothers\"    \"Juego de plataforma 2D\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Pingus" > /dev/null; then
if [ -f /usr/bin/pingus ]; then
                    im=$im"FALSE \"Pingus\"    \"Juego donde se guía a los pingüinos con seguridad a casa antes de caer en el precipicio\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Pingus\"    \"Juego donde se guía a los pingüinos con seguridad a casa antes de caer en el precipicio\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Hedgewars" > /dev/null; then
if [ -f /usr/bin/hedgewars ]; then
                    im=$im"FALSE \"Hedgewars\"    \"Juego de batalla de tanques 2D donde los tanques son remplazados por erizos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Hedgewars\"    \"Juego de batalla de tanques 2D donde los tanques son remplazados por erizos\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Glaxium" > /dev/null; then
if [ -f /usr/bin/glaxium ]; then
                    im=$im"FALSE \"Glaxium\"    \"Juego OpenGL de disparos en el espacio\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Glaxium\"    \"Juego OpenGL de disparos en el espacio\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Amoebax" > /dev/null; then
if [ -f /usr/bin/amoebax ]; then
                    im=$im"FALSE \"Amoebax\"    \"Juego rompecabezas de acción\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Amoebax\"    \"Juego rompecabezas de acción\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Alien Arena" > /dev/null; then
if [ -e /usr/bin/alienarena ]; then
                    im=$im"FALSE \"Alien Arena\"    \"Juego de ciencia ficción retro de partida a muerte multijugador\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Alien Arena\"    \"Juego de ciencia ficción retro de partida a muerte multijugador\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "TORCS" > /dev/null; then
if [ -f /usr/bin/torcs ]; then
                    im=$im"FALSE \"TORCS\"    \"Simulador abierto de carrera de autos\" \"INSTALADO  \"  "
else
im=$im"FALSE \"TORCS\"    \"Simulador abierto de carrera de autos\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "FlightGear" > /dev/null; then
if [ -f /usr/bin/fgfs ]; then
                    im=$im"FALSE \"FlightGear\"    \"Simulador de vuelo 3D\" \"INSTALADO  \"  "
else
im=$im"FALSE \"FlightGear\"    \"Simulador de vuelo 3D\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Performous" > /dev/null; then
if [ -f /usr/local/bin/performous ] && [ -d /usr/local/share/games/performous/ ]; then 
                    im=$im"FALSE \"Performous\"    \"Un juego abierto de karaoke, banda y baile en el que uno o más jugadores interpretan una canción, con los scores de sus actuaciones.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Performous\"    \"Un juego abierto de karaoke, banda y baile en el que uno o más jugadores interpretan una canción, con los scores de sus actuaciones.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Steam" > /dev/null; then
if [ -f /usr/bin/steam ]; then
                    im=$im"FALSE \"Steam\"    \"Ofrece una gama de juegos directamente al escritorio del ordenador.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Steam\"    \"Ofrece una gama de juegos directamente al escritorio del ordenador.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Aquaria" > /dev/null; then
if [ -f /home/$noti/aquaria/aquaria ]; then
                    im=$im"FALSE \"Aquaria\"    \"Aquaria, es un premiado videojuego de acción-aventura, [requiere drivers gráficos instalados].\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Aquaria\"    \"Aquaria, es un premiado videojuego de acción-aventura, [requiere drivers gráficos instalados].\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Gtk-Gnutella" > /dev/null; then
if [ -f /usr/bin/gtk-gnutella ]; then
                    im=$im"FALSE \"Gtk-Gnutella\"    \"Programa P2P clónico de Gnutella (frostwire)\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Gtk-Gnutella\"    \"Programa P2P clónico de Gnutella (frostwire)\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "GrooveDown" > /dev/null; then
if [ -f /usr/bin/groovedown ]; then
                    im=$im"FALSE \"GrooveDown\"    \"Herramienta simple descarga para Grooveshark.com\" \"INSTALADO  \"  "
else
im=$im"FALSE \"GrooveDown\"    \"Herramienta simple descarga para Grooveshark.com\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "GrooveOff" > /dev/null; then
if [ -f /usr/bin/grooveoff ]; then
                    im=$im"FALSE \"GrooveOff\"    \"Cliente no oficial para grooveshark.com.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"GrooveOff\"    \"Cliente no oficial para grooveshark.com.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Frostwire" > /dev/null; then
if [ -f /usr/bin/frostwire ]; then
                    im=$im"FALSE \"Frostwire\"    \"FrostWire es un cliente P2P de código abierto compatible con la red Gnutella.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Frostwire\"    \"FrostWire es un cliente P2P de código abierto compatible con la red Gnutella.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "UGET" > /dev/null; then
if [ -f /usr/bin/uget-gtk ]; then
                    im=$im"FALSE \"UGET\"    \"Uget (antes urlgfe) es un gestor de descargas escrito en GTK +, fácil de usar, reanudar, clasificar descargar, y más\" \"INSTALADO  \"  "
else
im=$im"FALSE \"UGET\"    \"Uget (antes urlgfe) es un gestor de descargas escrito en GTK +, fácil de usar, reanudar, clasificar descargar, y más\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "FlareGet" > /dev/null; then
if [ -f /usr/bin/flareget ]; then
                    im=$im"FALSE \"FlareGet\"    \"Completo y avanzado, multi-threaded, gestor de descargas multi-segmento y acelerador para Linux.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"FlareGet\"    \"Completo y avanzado, multi-threaded, gestor de descargas multi-segmento y acelerador para Linux.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Tucan Manager" > /dev/null; then
if [ -f /usr/bin/tucan ]; then
                    im=$im"FALSE \"Tucan Manager\"    \"Tucan Manager es una aplicación para compartir archivos gratuito diseñado para hosters de 1-Click. Rápido y ligero, Tucan es totalmente de código abierto\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Tucan Manager\"    \"Tucan Manager es una aplicación para compartir archivos gratuito diseñado para hosters de 1-Click. Rápido y ligero, Tucan es totalmente de código abierto\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Yum Extender" > /dev/null; then
if [ -f /usr/bin/yumex ]; then
                    im=$im"FALSE \"Yum Extender\"    \"Una GUI para el gestor de paquetes yum\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Yum Extender\"    \"Una GUI para el gestor de paquetes yum\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Blueman" > /dev/null; then
if [ -f /usr/bin/blueman-manager ]; then
                    im=$im"FALSE \"Blueman\"    \"Todas las funciones de GTK Bluetooth Manager para GNOME\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Blueman\"    \"Todas las funciones de GTK Bluetooth Manager para GNOME\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Google-Chrome" > /dev/null; then
if [ -f /opt/google/chrome/google-chrome ]; then
                    im=$im"FALSE \"Google-Chrome\"    \"Navegador minimalista que hacer la web más rápido, más seguro y más fácil\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Google-Chrome\"    \"Navegador minimalista que hacer la web más rápido, más seguro y más fácil\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Chromium" > /dev/null; then
if [ -f /usr/bin/chromium-browser ]; then
                    im=$im"FALSE \"Chromium\"    \"Navegador de código abierto que pretende construir una forma más segura, más rápida y más estable para todos los usuarios de Internet\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Chromium\"    \"Navegador de código abierto que pretende construir una forma más segura, más rápida y más estable para todos los usuarios de Internet\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Opera" > /dev/null; then
if [ -f /usr/bin/opera ]; then
                    im=$im"FALSE \"Opera\"    \"Excelente navegador que hace que la Web sea rápida y divertida, que le de una experiencia de web en cualquier computador\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Opera\"    \"Excelente navegador que hace que la Web sea rápida y divertida, que le de una experiencia de web en cualquier computador\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "BleachBit" > /dev/null; then
if [ -f /usr/bin/bleachbit ]; then
                    im=$im"FALSE \"BleachBit\"    \"Programa para limpiar espacio en disco, mantener la privacidad\" \"INSTALADO  \"  "
else
im=$im"FALSE \"BleachBit\"    \"Programa para limpiar espacio en disco, mantener la privacidad\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "GnomeTweakTool y dconf-editor" > /dev/null; then
if [ -f /usr/bin/gnome-tweak-tool ] || [ -f /usr/bin/dconf-editor ] || [ -f /usr/bin/gconf-editor ]; then
                    im=$im"FALSE \"GnomeTweakTool y dconf-editor\"    \"Herramientas avanzadas para personalizar las opciones de GNOME 3\" \"INSTALADO  \"  "
else
im=$im"FALSE \"GnomeTweakTool y dconf-editor\"    \"Herramientas avanzadas para personalizar las opciones de GNOME 3\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Menu Libre" > /dev/null; then
if [ -f /usr/bin/menulibre ]; then
                    im=$im"FALSE \"Menu Libre\"    \"Un editor de menú avanzado que proporciona características modernas en una interfaz limpia y fácil de usar.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Menu Libre\"    \"Un editor de menú avanzado que proporciona características modernas en una interfaz limpia y fácil de usar.\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Completar Instalaciones pendientes" > /dev/null; then
                    im=$im"FALSE \"Completar Instalaciones pendientes\"    \"Continua instalaciones no completadas por errores del sistema\" \"ACTIVO  \"  "
            fi


if ! $installed | grep "Bitdefender" > /dev/null; then
if [ -f /opt/BitDefender-scanner/bin/bdgui ] || [ -f /opt/BitDefender-scanner/bin/bdscan ]; then
                    im=$im"FALSE \"Bitdefender\"    \"Antivirus para particiones ntsf etc\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Bitdefender\"    \"Antivirus para particiones ntsf etc\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Informacion del Sistema" > /dev/null; then
                    im=$im"FALSE \"Informacion del Sistema\"    \"Muestra la informacion del sistema\" \"ACTIVO  \"  "
            fi


if ! $installed | grep "Hardinfo" > /dev/null; then
if [ -f /usr/bin/hardinfo ]; then
                    im=$im"FALSE \"Hardinfo\"    \"Muestra información sobre el hardware del sistema y el sistema operativo\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Hardinfo\"    \"Muestra información sobre el hardware del sistema y el sistema operativo\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Batti" > /dev/null; then
if [ -f /usr/bin/batti ]; then
                    im=$im"FALSE \"Batti\"    \"Batti es un applet de monitor de batería ideal para LXDE para la bandeja del sistema\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Batti\"    \"Batti es un applet de monitor de batería ideal para LXDE para la bandeja del sistema\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Alien" > /dev/null; then
if [ -f /usr/bin/alien ]; then
                    im=$im"FALSE \"Alien\"    \"Alien nos permite convertir entre diferentes formatos de paquetes binarios linux, pudiendo pasar entre sí cualquiera de estos 4 formatos: deb, rpm, slackware tgz\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Alien\"    \"Alien nos permite convertir entre diferentes formatos de paquetes binarios linux, pudiendo pasar entre sí cualquiera de estos 4 formatos: deb, rpm, slackware tgz\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Microsoft TrueType core fonts" > /dev/null; then
if [ -d /usr/share/fonts/msttcorefonts ]; then
                    im=$im"FALSE \"Microsoft TrueType core fonts\"    \"Tipografias o letras oficiales de Microsoft\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Microsoft TrueType core fonts\"    \"Tipografias o letras oficiales de Microsoft\" \"NO INSTALADO  \"  "
fi
            fi


if ! $installed | grep "Reset PostInstallerF" > /dev/null; then
                    im=$im"FALSE \"Reset PostInstallerF\"    \"Reinicia el registro de los programas instalados via PostInstallerF\" \"ACTIVO  \"  "
            fi

   else
# AQUI EMPIESA LENGUAJE INGLES

if ! $installed | grep "Repositories RPM Fusion" > /dev/null; then
if [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ]; then
                    im=$im"FALSE \"Repositories RPM Fusion\"     \"RPM Fusion provides software that the Fedora Project or Red Hat doesn't want to ship.[Recommended]\" \"ACTIVATED  \"  "
else
im=$im"FALSE \"Repositories RPM Fusion\"     \"RPM Fusion provides software that the Fedora Project or Red Hat doesn't want to ship.[Recommended]\" \"NO ACTIVATED  \"  "
fi
            fi

if ! $installed | grep "Change system language" > /dev/null; then
if [ -f /usr/bin/system-config-language ]; then
                    im=$im"FALSE \"Change system language\"             \"Choose your native language\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Change system language\"             \"Choose your native language\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Build Basic Tools" > /dev/null; then
if [ -f /usr/bin/make ]
then
                    im=$im"FALSE \"Build Basic Tools\"                  \"Dependencies for compiling programs\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Build Basic Tools\"                  \"Dependencies for compiling programs\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Mozilla Firefox" > /dev/null; then
if [ -f /usr/bin/firefox ]
then
                    im=$im"FALSE \"Mozilla Firefox\"                  \"Standalone web browser from mozilla.org\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Mozilla Firefox\"                  \"Standalone web browser from mozilla.org\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Install Codecs Audio/Video" > /dev/null; then
if [ -d /usr/share/doc/gstreamer-plugins-bad-nonfree-* ]; then
                    im=$im"FALSE \"Install Codecs Audio/Video\"      \"Everything you need for audio and video play\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Install Codecs Audio/Video\"      \"Everything you need for audio and video play\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Flash Player" > /dev/null; then
if [ -f /usr/bin/flash-player-properties ]; then
                    im=$im"FALSE \"Flash Player\"           \"Plugin needed to run flash content in the browser\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Flash Player\"           \"Plugin needed to run flash content in the browser\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Unrar and p7zip" > /dev/null; then
if [ -f /usr/bin/unrar ] || [ -f /usr/bin/7za ]; then
                    im=$im"FALSE \"Unrar and p7zip\"                   \"Decompresses rar and 7zip files\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Unrar y p7zip\"                   \"Decompresses rar and 7zip files\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Java OpenJDK" > /dev/null; then

if [ -f /usr/bin/java ]; then
                    im=$im"FALSE \"Java OpenJDK\"           \"Free and open source implementation of the Java programming language.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Java OpenJDK\"           \"Free and open source implementation of the Java programming language.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Java JRE Oracle" > /dev/null; then

if [ -f /usr/java/latest/lib/i386/libnpjp2.so ] || [ -f /usr/java/latest/lib64/x86_64/libnpjp2.so ]; then
                    im=$im"FALSE \"Java JRE Oracle\"           \"Propietary implementation of the Java programming language.\" \"INSTALLED [$versionjava] \"  "
else
im=$im"FALSE \"Java JRE Oracle\"           \"Propietary implementation of the Java programming language.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Java JDK Oracle" > /dev/null; then

if [ -f /usr/java/latest/jre/lib/amd64/libnpjp2.so ] || [ -f /usr/java/latest/jre/lib/i386/libnpjp2.so ]; then
                    im=$im"FALSE \"Java JDK Oracle\"     \"Oracle Java Runtime Environment [Developer]\" \"INSTALLED [$versionjkd]  \"  "
else
im=$im"FALSE \"Java JDK Oracle\"     \"Oracle Java Runtime Environment [Developer]\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "GIMP" > /dev/null; then
if [ -f /usr/bin/gimp ]
 then
                    im=$im"FALSE \"GIMP\"            \"GIMP is the GNU Image Manipulation Program.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"GIMP\"            \"GIMP is the GNU Image Manipulation Program.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Hugin" > /dev/null; then
if [ -f /usr/bin/hugin ]
 then
                    im=$im"FALSE \"Hugin\"            \"Assemble a mosaic of photographs into a complete immersive panorama.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Hugin\"            \"Assemble a mosaic of photographs into a complete immersive panorama.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Converseen" > /dev/null; then
if [ -f /usr/bin/converseen ]; then
                    im=$im"FALSE \"Converseen\"            \"Open source batch image resizer and conversion tool written with Qt4 and ImageMagick.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Converseen\"            \"Open source batch image resizer and conversion tool written with Qt4 and ImageMagick.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "MyPaint" > /dev/null; then
if [ -f /usr/bin/mypaint ]; then
                    im=$im"FALSE \"MyPaint\" \"Fast and easy open-source graphics application for digital painters.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"MyPaint\" \"Fast and easy open-source graphics application for digital painters.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Pinta" > /dev/null; then
if [ -f /usr/bin/pinta ]; then
                    im=$im"FALSE \"Pinta\" \"Drawing/editing program modeled after Paint.NET.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Pinta\" \"drawing/editing program modeled after Paint.NET.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Pencil" > /dev/null; then
if [ -f /usr/bin/pencil ]; then
                    im=$im"FALSE \"Pencil\" \"Opensource tool for making diagrams and GUI prototyping that everyone can use.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Pencil\" \"Opensource tool for making diagrams and GUI prototyping that everyone can use.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Fotoxx" > /dev/null; then
if [ -f /usr/bin/fotoxx ]; then
                    im=$im"FALSE \"Fotoxx\"               \"Program for editing image files from a digital camera.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Fotoxx\"               \"Program for editing image files from a digital camera.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Shutter" > /dev/null; then
if [ -f /usr/bin/shutter ]; then
                    im=$im"FALSE \"Shutter\"       \"Shutter is a GTK+ 2.0 screenshot application written in perl.\" \"INSTALLED  \"  "
else
m=$im"FALSE \"Shutter\"       \"Shutter is a GTK+ 2.0 screenshot application written in perl.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Glabels" > /dev/null; then
if [ -f /usr/bin/glabels-* ]; then
                    im=$im"FALSE \"Glabels\"            \"A program for creating labels and business cards for GNOME\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Glabels\"            \"A program for creating labels and business cards for GNOME\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Kover" > /dev/null; then
if [ -f /usr/bin/kover ]; then
                    im=$im"FALSE \"Kover\"              \"WYSIWYG CD cover printer with CDDB support\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Kover\"              \"WYSIWYG CD cover printer with CDDB support\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "LibreOffice" > /dev/null; then
if [ -d /usr/lib/libreoffice/ ]; then
                    im=$im"FALSE \"LibreOffice\"         \"Open Source, community-developed, office productivity suite.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"LibreOffice\"         \"Open Source, community-developed, office productivity suite.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Basket" > /dev/null; then
if [ -f /usr/bin/basket ]; then
                    im=$im"FALSE \"Basket\"         \"Organize your notes in a hierarchy of baskets, by topic or project. Group notes together, collapse non-important groups...\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Basket\"         \"Organize your notes in a hierarchy of baskets, by topic or project. Group notes together, collapse non-important groups...\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "ProjectLibre" > /dev/null; then
if [ -f /usr/bin/projectlibre ]; then
                    im=$im"FALSE \"ProjectLibre\"         \"ProjectLibre is the open source alternative to Microsoft Project.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"ProjectLibre\"         \"ProjectLibre is the open source alternative to Microsoft Project.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Adobe Reader" > /dev/null; then
if [ -f /usr/bin/acroread ]; then
                    im=$im"FALSE \"Adobe Reader\"             \"Trusted standard for reliably viewing and interacting with PDF files.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Adobe Reader\"             \"Trusted standard for reliably viewing and interacting with PDF files.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "PDF Mod" > /dev/null; then
if [ -f /usr/bin/pdfmod ]; then
                    im=$im"FALSE \"PDF Mod\"                \"Simple application for modifying PDF written in C Sharp\" \"INSTALLED  \"  "
else
im=$im"FALSE \"PDF Mod\"                \"Simple application for modifying PDF written in C Sharp\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "PDF Split and Merge" > /dev/null; then
if [ -f /usr/bin/pdfsam ]; then
                    im=$im"FALSE \"PDF Split and Merge\"                \"Very simple, easy to use, free, open source utility to split and merge pdf files.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"PDF Split and Merge\"                \"Very simple, easy to use, free, open source utility to split and merge pdf files.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "YAGF" > /dev/null; then
if [ -f /usr/bin/yagf ]; then
                    im=$im"FALSE \"YAGF\"                \"Graphical interface for cuneiform and tesseract text recognition tools on the Linux platform.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"YAGF\"                \"Graphical interface for cuneiform and tesseract text recognition tools on the Linux platform.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Scribus" > /dev/null; then
if [ -f /usr/bin/scribus ]; then
                    im=$im"FALSE \"Scribus\"               \"DeskTop Publishing application written in Qt\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Scribus\"               \"DeskTop Publishing application written in Qt\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Dia" > /dev/null; then
if [ -f /usr/bin/dia ]; then
                    im=$im"FALSE \"Dia\"                   \"A GTK+ based diagram creation program similar Windows Visio\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Dia\"                   \"A GTK+ based diagram creation program similar Windows Visio\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Gnumeric" > /dev/null; then
if [ -f /usr/bin/gnumeric ]; then
                    im=$im"FALSE \"Gnumeric\"                 \"A GNOME Spreadsheet Program\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Gnumeric\"                 \"A GNOME Spreadsheet Program\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Planner" > /dev/null; then
if [ -f /usr/bin/planner ]; then
                    im=$im"FALSE \"Planner\"            \"A graphical project management tool\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Planner\"            \"A graphical project management tool\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "VYM" > /dev/null; then
if [ -f /usr/bin/vym ]; then
                    im=$im"FALSE \"VYM\"                   \"A tool to generate and manipulate maps which show your thoughts.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"VYM\"                   \"A tool to generate and manipulate maps which show your thoughts.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Freemind" > /dev/null; then
if [ -f /usr/bin/freemind ]; then
                    im=$im"FALSE \"Freemind\"             \"FreeMind is a premier free mind-mapping software written in Java.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Freemind\"             \"FreeMind is a premier free mind-mapping software written in Java.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "yEd" > /dev/null; then
if [ -f /opt/yEd/yEd ]; then
                    im=$im"FALSE \"yEd\"             \"yEd is a powerful desktop application that can be used to quickly and effectively generate high-quality diagrams.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"yEd\"             \"yEd is a powerful desktop application that can be used to quickly and effectively generate high-quality diagrams.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Cmap Tools" > /dev/null; then
if [ -f $HOME/IHMC_CmapTools/bin/update ]; then
                    im=$im"FALSE \"Cmap Tools\"             \"Program empowers users to construct, navigate, share and criticize knowledge models represented as concept maps.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Cmap Tools\"             \"yEd is a powerful desktop application that can be used to quickly and effectively generate high-quality diagrams.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Anki" > /dev/null; then
if [ -f /usr/bin/anki ]; then
                    im=$im"FALSE \"Anki\"                \"Flashcard program for using space repetition learning.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Anki\"                \"Flashcard program for using space repetition learning.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Wine and winetricks" > /dev/null; then
if [ -f /usr/bin/wine ] || [ -f /usr/bin/winetricks ]; then
                    im=$im"FALSE \"Wine and winetricks\"                  \"A compatibility layer for running Windows programs\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Wine and winetricks\"                  \"A compatibility layer for running Windows programs\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Oracle Virtual Box" > /dev/null; then
if [ -f '/etc/yum.repos.d/virtualbox.repo' ] || [ -f /usr/bin/VirtualBox ]; then
                    im=$im"FALSE \"Oracle Virtual Box\"            \" Powerful x86 virtualization for enterprise as well as home\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Oracle Virtual Box\"            \" Powerful x86 virtualization for enterprise as well as home use\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "PlayOnLinux" > /dev/null; then
if [ -f /usr/bin/playonlinux ]; then
                    im=$im"FALSE \"PlayOnLinux\"                \"GUI for managing Windows programs under linux\" \"INSTALLED  \"  "
else
im=$im"FALSE \"PlayOnLinux\"                \"GUI for managing Windows programs under linux\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "TeamViewer" > /dev/null; then
if [ -f /opt/teamviewer/teamviewer ]; then
                    im=$im"FALSE \"TeamViewer\"                  \"Remote Support, Remote Access, Remote Administration, Home Office and Online Meetings.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"TeamViewer\"                  \"Remote Support, Remote Access, Remote Administration, Home Office and Online Meetings.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "DropBox" > /dev/null; then
if [ -f /usr/bin/dropbox ]; then
                    im=$im"FALSE \"DropBox\"                    \"Sync and backup files between computers\" \"INSTALLED  \"  "
else
im=$im"FALSE \"DropBox\"                    \"Sync and backup files between computers\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Hyper Video Converter" > /dev/null; then
if [ -f /usr/bin/hypervc ]; then
                    im=$im"FALSE \"Hyper Video Converter\"                   \"A frontend for various command line tools such as ffmpeg.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Hyper Video Converter\"                   \"A frontend for various command line tools such as ffmpeg.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Miro Video Converter" > /dev/null; then
if [ -f /usr/bin/miro-video-converter.py ]; then
                    im=$im"FALSE \"Miro Video Converter\"                   \"Open source, cross-platform application to convert videos from and to various formats, including formats suitable for devices such as Android phones.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Miro Video Converter\"                   \"Open source, cross-platform application to convert videos from and to various formats, including formats suitable for devices such as Android phones.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Arista Transcoder" > /dev/null; then
if [ -f /usr/bin/arista-gtk ]; then
                    im=$im"FALSE \"Arista Transcoder\"                   \"A easy to use multimedia transcoder for the GNOME Desktop.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Arista Transcoder\"                   \"A easy to use multimedia transcoder for the GNOME Desktop.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Qwinff" > /dev/null; then
if [ -f /usr/bin/qwinff ]; then
                    im=$im"FALSE \"Qwinff\"                   \"QWinFF is a cross-platform, easy-to-use media converter frontend to FFmpeg.\" \"INSTALADO  \"  "
else
im=$im"FALSE \"Qwinff\"                   \"QWinFF is a cross-platform, easy-to-use media converter frontend to FFmpeg.\" \"NO INSTALADO  \"  "
fi
            fi

if ! $installed | grep "Transcoder" > /dev/null; then
if [ -f /usr/share/applications/Transcoder.desktop ] && [ -f /usr/local/bin/Transcoder/Transcoder ]; then
                    im=$im"FALSE \"Transcoder\"                \"Video converter for Linux using GTK+ as GUI toolkit and ffmpeg as backend.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Transcoder\"                \"Video converter for Linux using GTK+ as GUI toolkit and ffmpeg as backend.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Mobilmedia Converter" > /dev/null; then
if [ -f /usr/local/bin/mmc ]; then
                    im=$im"FALSE \"Mobilmedia Converter\"                  \"Video converter for converting between popular desktop audio and video formats\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Mobilmedia Converter\"                  \"Video converter for converting between popular desktop audio and video formats\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "YakiTo" > /dev/null; then
if [ -f /usr/bin/yakito ]; then
                    im=$im"FALSE \"YakiTo\"               \"Multimedia file converter, free and open\" \"INSTALLED  \"  "
else
im=$im"FALSE \"YakiTo\"               \"Multimedia file converter, free and open\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Ekd" > /dev/null; then
if [ -f /usr/bin/ekd ]; then
                    im=$im"FALSE \"Ekd\"               \"Open source software which makes videos, pictures and audio post-production. \" \"INSTALLED  \"  "
else
im=$im"FALSE \"Ekd\"               \"Open source software which makes videos, pictures and audio post-production. \" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "FF Multi Converter" > /dev/null; then
if [ -f /usr/bin/ffmulticonverter ]; then
                    im=$im"FALSE \"FF Multi Converter\"               \"Simple graphical application which enables you to convert audio, video, image and document files\" \"INSTALLED  \"  "
else
im=$im"FALSE \"FF Multi Converter\"               \"Simple graphical application which enables you to convert audio, video, image and document files\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "GtkPod" > /dev/null; then
if [ -f /usr/bin/gtkpod ]; then
                    im=$im"FALSE \"GtkPod\"             \"Graphical user interface for the Apple iPod for Unix-like systems, written using the GTK+ toolkit.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"GtkPod\"             \"graphical user interface for the Apple iPod for Unix-like systems, written using the GTK+ toolkit. \" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "EasyTag" > /dev/null; then
if [ -f /usr/bin/easytag ]; then
                    im=$im"FALSE \"EasyTag\"              \"Utility for viewing, editing and writing ID3 tags of your MP3 files.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"EasyTag\"              \"Utility for viewing, editing and writing ID3 tags of your MP3 files.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Avidemux" > /dev/null; then
if [ -f /usr/bin/avidemux ]; then
                    im=$im"FALSE \"Avidemux\"       \"A graphical tool to edit video (filter/re-encode/split).\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Avidemux\"       \"A graphical tool to edit video (filter/re-encode/split).\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Blender" > /dev/null; then
if [ -f /usr/bin/blender ]; then
                    im=$im"FALSE \"Blender\"               \"A fully integrated 3D graphics creation suite.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Blender\"               \"A fully integrated 3D graphics creation suite.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Tupi" > /dev/null; then
if [ -f /usr/bin/tupi ]; then
                    im=$im"FALSE \"Tupi\"               \"A design and authoring tool for digital artists interested in 2D Animation.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Tupi\"               \"A design and authoring tool for digital artists interested in 2D Animation.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "BRL-CAD" > /dev/null; then
if [ -f /usr/brlcad/bin/brlcad-config ]; then
                    im=$im"FALSE \"BRL-CAD\"    \"Powerful cross-platform open source solid modeling system.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"BRL-CAD\"    \"Powerful cross-platform open source solid modeling system.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Sweet Home 3D" > /dev/null; then
if [ -f /usr/share/applications/SweetHome3D.desktop ] && [ -f /usr/bin/sweethome3d.sh ]; then
                    im=$im"FALSE \"Sweet Home 3D\"          \"Interior 2D design application with 3D preview.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Sweet Home 3D\"          \"Interior 2D design application with 3D preview.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Libre CAD" > /dev/null; then
if [ -f /usr/bin/librecad ]; then
                    im=$im"FALSE \"Libre CAD\"    \"Free Open Source CAD application\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Libre CAD\"    \"Free Open Source CAD application\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "FreeCAD" > /dev/null; then
if [ -f /usr/bin/FreeCAD ]; then
                    im=$im"FALSE \"FreeCAD\"    \"General purpose feature-based, parametric 3D modeler for CAD, MCAD, CAx, CAE and PLM.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"FreeCAD\"    \"General purpose feature-based, parametric 3D modeler for CAD, MCAD, CAx, CAE and PLM.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "DraftSight" > /dev/null; then
if [ -f /usr/bin/draftsight ]; then
                    im=$im"FALSE \"DraftSight\"    \"Proprietary freeware 2D CAD product for engineers, architects, designers, draftspeople, students and educators.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"DraftSight\"    \"Proprietary freeware 2D CAD product for engineers, architects, designers, draftspeople, students and educators.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Inkscape" > /dev/null; then
if [ -f /usr/bin/inkscape ]; then
                    im=$im"FALSE \"Inkscape\"                 \"Vector graphics editor using the SVG file format.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Inkscape\"                 \"Vector graphics editor using the SVG file format.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Openshot" > /dev/null; then
if [ -f /usr/bin/openshot ]; then
                    im=$im"FALSE \"Openshot\"    \"Open-source, non-linear video editor for Linux based on MLT framework.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Openshot\"    \"Open-source, non-linear video editor for Linux based on MLT framework.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Kdenlive" > /dev/null; then
if [ -f /usr/bin/kdenlive ]; then
                    im=$im"FALSE \"Kdenlive\"    \"Intuitive and powerful multi-track video editor, including most recent video technologies.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Kdenlive\"    \"Intuitive and powerful multi-track video editor, including most recent video technologies.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "LIVES" > /dev/null; then
if [ -f /usr/bin/lives ]; then
                    im=$im"FALSE \"LIVES\"    \"Linux Video Editing System.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"LIVES\"    \"Linux Video Editing System.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Imagination" > /dev/null; then
if [ -f /usr/bin/imagination ]; then
                    im=$im"FALSE \"Imagination\"    \"DVD slide show maker.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Imagination\"    \"DVD slide show maker.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "DeveDe" > /dev/null; then
if [ -f /usr/bin/devede ]; then
                    im=$im"FALSE \"DeveDe\"    \"Program to create VideoDVDs and CDs.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"DeveDe\"    \"Program to create VideoDVDs and CDs.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "DVDStyler" > /dev/null; then
if [ -f /usr/bin/dvdstyler ]; then
                    im=$im"FALSE \"DVDStyler\"    \"Crossplatform DVD Authoring System.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"DVDStyler\"    \"Crossplatform DVD Authoring System.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "ffDiaporama" > /dev/null; then
if [ -f /usr/bin/ffDiaporama ]; then
                    im=$im"FALSE \"ffDiaporama\"    \"Movie creator from photos and video clips.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"ffDiaporama\"    \"Movie creator from photos and video clips.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Wink" > /dev/null; then
if [ -f /usr/bin/wink ]; then
                    im=$im"FALSE \"Wink\"    \"Wink is a Tutorial and Presentation creation software.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Wink\"    \"Wink is a Tutorial and Presentation creation software.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Virtual Lighttable and Darkroom" > /dev/null; then
if [ -f /usr/bin/darktable ]; then
                    im=$im"FALSE \"Virtual Lighttable and Darkroom\"    \"Utility to organize and develop raw images.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Virtual Lighttable and Darkroom\"    \"Utility to organize and develop raw images.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Gnome Subtitles" > /dev/null; then
if [ -f /usr/bin/gnome-subtitles ]; then
                    im=$im"FALSE \"Gnome Subtitles\"    \"Video subtitle editor for GNOME.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Gnome Subtitles\"    \"Video subtitle editor for GNOME.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "VLC media player" > /dev/null; then
if [ -f /usr/bin/qvlc ]; then
                    im=$im"FALSE \"VLC media player\"    \"A multi-platform MPEG, VCD/DVD, and DivX player.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"VLC media player\"    \"A multi-platform MPEG, VCD/DVD, and DivX player.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Netflix Player" > /dev/null; then
if [ -f /usr/bin/netflix-desktop ]; then
                    im=$im"FALSE \"Netflix Player\"    \" Watch Movies & TV Shows Online.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Netflix Player\"    \" Watch Movies & TV Shows Online.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "XBMC" > /dev/null; then
if [ -f /usr/bin/xbmc ]; then
                    im=$im"FALSE \"XBMC\"    \"Complete media center solution for Linux.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"XBMC\"    \"Complete media center solution for Linux.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Clementine" > /dev/null; then
if [ -f /usr/bin/clementine ]; then
                    im=$im"FALSE \"Clementine\"    \"A music player and library organizer.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Clementine\"    \"A music player and library organizer.\" \"NO INSTALLED  \"  "
fi
            fi
 
if ! $installed | grep "Sound converter" > /dev/null; then
if [ -f /usr/bin/soundconverter ]; then
                    im=$im"FALSE \"Sound converter\"    \"A simple sound converter application for GNOME.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Sound converter\"    \"A simple sound converter application for GNOME.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Audacity" > /dev/null; then
if [ -f /usr/bin/audacity ]; then
                    im=$im"FALSE \"Audacity\"    \"A program that lets you manipulate digital audio waveforms.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Audacity\"    \"A program that lets you manipulate digital audio waveforms.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "OcenAudio" > /dev/null; then
if [ -f /usr/bin/ocenaudio ]; then
                    im=$im"FALSE \"OcenAudio\"    \"Cross-platform, easy to use, fast and functional audio editor..\" \"INSTALLED  \"  "
else
im=$im"FALSE \"OcenAudio\"    \"Cross-platform, easy to use, fast and functional audio editor.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Mixxx" > /dev/null; then
if [ -f /usr/bin/mixxx ]; then
                    im=$im"FALSE \"Mixxx\"    \"Mixxx has everything you need to start making DJ mixes in a tight, integrated package.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Mixxx\"    \"Mixxx has everything you need to start making DJ mixes in a tight, integrated package.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "SKYPE" > /dev/null; then
if [ -f /usr/bin/skype ]; then
                    im=$im"FALSE \"SKYPE\"    \"Free Internet telephony that just works.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"SKYPE\"    \"Free Internet telephony that just works.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Jitsi" > /dev/null; then
if [ -f /usr/bin/jitsi ]; then
                    im=$im"FALSE \"Jitsi\"    \"An audio/video and chat communicator that supports protocols such as SIP, XMPP/Jabber, AIM/ICQ, Windows Live, Yahoo!.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Jitsi\"    \"An audio/video and chat communicator that supports protocols such as SIP, XMPP/Jabber, AIM/ICQ, Windows Live, Yahoo!.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Turpial" > /dev/null; then
if [ -f /usr/bin/turpial ]; then
                    im=$im"FALSE \"Turpial\"    \"Cool twitter client with many features and very light.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Turpial\"    \"Cool twitter client with many features and very light.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Gwibber" > /dev/null; then
if [ -f /usr/bin/gwibber ]; then
                    im=$im"FALSE \"Gwibber\"    \"Microblogging client, which supports Twitter, Identi.ca, StatusNet, Facebook, Flickr, Digg, FriendFeed and Qaiku.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Gwibber\"    \"Microblogging client, which supports Twitter, Identi.ca, StatusNet, Facebook, Flickr, Digg, FriendFeed and Qaiku.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Bible Time" > /dev/null; then
if [ -f /usr/bin/bibletime ]; then
                    im=$im"FALSE \"Bible Time\"    \"Free and easy to use cross-platform bible study tool.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Bible Time\"    \"Free and easy to use cross-platform bible study tool.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Tuxpaint" > /dev/null; then
if [ -f /usr/bin/tuxpaint ]; then
                    im=$im"FALSE \"Tuxpaint\"    \"Tux Paint is a free drawing program designed for young children.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Tuxpaint\"    \"Tux Paint is a free drawing program designed for young children.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Stellarium" > /dev/null; then
if [ -f /usr/bin/stellarium ]; then
                    im=$im"FALSE \"Stellarium\"    \"A stellarium with great graphics and a nice database of sky-objects.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Stellarium\"    \"A stellarium with great graphics and a nice database of sky-objects.\" \"INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Celestia" > /dev/null; then
if [ -f /usr/bin/celestia ]; then
                    im=$im"FALSE \"Celestia\"    \"OpenGL real-time visual space simulation.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Celestia\"    \"OpenGL real-time visual space simulation.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Google Earth" > /dev/null; then
if [ -f /opt/google/earth/free/googleearth ]; then
                    im=$im"FALSE \"Google Earth\"    \"3D planet viewer that lets you interactively navigate satellite imagery, maps, terrain, and so forth.\" \"INSTALALED  \"  "
else
im=$im"FALSE \"Google Earth\"    \"3D planet viewer that lets you interactively navigate satellite imagery, maps, terrain, and so forth.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Gcompris" > /dev/null; then
if [ -f /usr/bin/gcompris ]; then
                    im=$im"FALSE \"Gcompris\"    \" Educational suite for kids 2-10 years old.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Gcompris\"    \" Educational suite for kids 2-10 years old.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "TuxMath" > /dev/null; then
if [ -f /usr/bin/tuxmath ]; then
                    im=$im"FALSE \"TuxMath\"    \"Math game for kids with Tux.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"TuxMath\"    \"Math game for kids with Tux.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "TuxType" > /dev/null; then
if [ -f /usr/bin/tuxtype ]; then
                    im=$im"FALSE \"TuxType\"    \"Educational Typing Tutor Game Starring Tux\" \"INSTALLED  \"  "
else
im=$im"FALSE \"TuxType\"    \"Educational Typing Tutor Game Starring Tux\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Childsplay" > /dev/null; then
if [ -f /usr/bin/childsplay ]; then
                    im=$im"FALSE \"Childsplay\"    \"Suite of educational games for young children.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Childsplay\"    \"Suite of educational games for young children.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Scratch" > /dev/null; then
if [ -f /usr/bin/scratch ]; then
                    im=$im"FALSE \"Scratch\"    \"Programming system and content development tool.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Scratch\"    \"Programming system and content development tool.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Ri-li" > /dev/null; then
if [ -f /usr/bin/Ri_li ]; then
                    im=$im"FALSE \"Ri-li\"    \"Arcade game where you drive a toy wood engine.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Ri-li\"    \"Arcade game where you drive a toy wood engine.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Frozen Bubble" > /dev/null; then
if [ -f /usr/bin/frozen-bubble ]; then
                    im=$im"FALSE \"Frozen Bubble\"    \"Frozen Bubble arcade game\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Frozen Bubble\"    \"Frozen Bubble arcade game\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Extreme Tux Racer" > /dev/null; then
if [ -f /usr/bin/etracer ]; then
                    im=$im"FALSE \"Extreme Tux Racer\"    \"3D racing game featuring Tux.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Extreme Tux Racer\"    \"3D racing game featuring Tux.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Super Tux Kart" > /dev/null; then
if [ -f /usr/bin/supertuxkart ]; then
                    im=$im"FALSE \"Super Tux Kart\"    \"Go-kart racing game for kids with several famous OpenSource mascots participating.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Super Tux Kart\"    \"Go-kart racing game for kids with several famous OpenSource mascots participating.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Wormux" > /dev/null; then
if [ -f /usr/bin/wormux ]; then
                    im=$im"FALSE \"Wormux\"    \"2D convivial mass murder game.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Wormux\"    \"2D convivial mass murder game.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Tremulous" > /dev/null; then
if [ -f /usr/bin/tremded ]; then
                    im=$im"FALSE \"Tremulous\"    \"A free team based FPS/RTS hybrid built on the ioq3 engine. Includes community updates.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Tremulous\"    \"A free team based FPS/RTS hybrid built on the ioq3 engine. Includes community updates.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Super Methane Brothers" > /dev/null; then
if [ -f /usr/bin/methane ]; then
                    im=$im"FALSE \"Super Methane Brothers\"    \"Super Methane Brothers.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Super Methane Brothers\"    \"Super Methane Brothers.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Pingus" > /dev/null; then
if [ -f /usr/bin/pingus ]; then
                    im=$im"FALSE \"Pingus\"    \"Guide the penguins safely home before they drop of the cliff.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Pingus\"    \"Guide the penguins safely home before they drop of the cliff.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Hedgewars" > /dev/null; then
if [ -f /usr/bin/hedgewars ]; then
                    im=$im"FALSE \"Hedgewars\"    \"Free Worms-like turn based strategy game.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Hedgewars\"    \"Free Worms-like turn based strategy game.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Glaxium" > /dev/null; then
if [ -f /usr/bin/glaxium ]; then
                    im=$im"FALSE \"Glaxium\"    \"An OpenGL space shooter.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Glaxium\"    \"An OpenGL space shooter.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Amoebax" > /dev/null; then
if [ -f /usr/bin/amoebax ]; then
                    im=$im"FALSE \"Amoebax\"    \"Puyo Puyo-style puzzle game for up to two players.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Amoebax\"    \"Puyo Puyo-style puzzle game for up to two players.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Alien Arena" > /dev/null; then
if [ -f /usr/bin/alienarena ]; then
                    im=$im"FALSE \"Alien Arena\"    \"Multiplayer retro sci-fi deathmatch game.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Alien Arena\"    \"Multiplayer retro sci-fi deathmatch game.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "TORCS" > /dev/null; then
if [ -f /usr/bin/torcs ]; then
                    im=$im"FALSE \"TORCS\"    \"A 3D racing cars simulator using OpenGL.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"TORCS\"    \"A 3D racing cars simulator using OpenGL.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "FlightGear" > /dev/null; then
if [ -f /usr/bin/fgfs ]; then
                    im=$im"FALSE \"FlightGear\"    \"An open-source, multi-platform flight simulator.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"FlightGear\"    \"An open-source, multi-platform flight simulator.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Performous" > /dev/null; then
if [ -f /usr/local/bin/performous ] && [ -d /usr/local/share/games/performous/ ]; then 
                    im=$im"FALSE \"Performous\"    \"Open-source rhythm/performance platform that contains singing, guitar/bass playing, drumming and dancing all in one game.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Performous\"    \"Open-source rhythm/performance platform that contains singing, guitar/bass playing, drumming and dancing all in one game.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Steam" > /dev/null; then
if [ -f /usr/bin/steam ]; then
                    im=$im"FALSE \"Steam\"    \"Delivers a range of games straight to a computer's desktop.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Steam\"    \"Delivers a range of games straight to a computer's desktop.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Aquaria" > /dev/null; then
if [ -f /home/$noti/aquaria/aquaria ]; then
                    im=$im"FALSE \"Aquaria\"    \"A breath-taking underwater fantasy game, [requires graphics drivers installed].\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Aquaria\"    \"A breath-taking underwater fantasy game, [requires graphics drivers installed].\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Gtk-Gnutella" > /dev/null; then
if [ -f /usr/bin/gtk-gnutella ]; then
                    im=$im"FALSE \"Gtk-Gnutella\"    \"GUI based Gnutella Client(frostwire)\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Gtk-Gnutella\"    \"GUI based Gnutella Client (frostwire)\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "GrooveDown" > /dev/null; then
if [ -f /usr/bin/groovedown ]; then
                    im=$im"FALSE \"GrooveDown\"    \"Simple Downloadtool for Grooveshark.com.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"GrooveDown\"    \"Simple Downloadtool for Grooveshark.com.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Frostwire" > /dev/null; then
if [ -f /usr/bin/frostwirelauch ]; then
                    im=$im"FALSE \"Frostwire\"    \"FrostWire is a free, open source BitTorrent client.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Frostwire\"    \"FrostWire is a free, open source BitTorrent client.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "GrooveOff" > /dev/null; then
if [ -f /usr/bin/grooveoff ]; then
                    im=$im"FALSE \"GrooveOff\"    \"Unofficial client for grooveshark.com.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"GrooveOff\"    \"Unofficial client for grooveshark.com.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "UGET" > /dev/null; then
if [ -f /usr/bin/uget-gtk ]; then
                    im=$im"FALSE \"UGET\"    \"GTK+ download manager featuring download classification and HTML import.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"UGET\"    \"GTK+ download manager featuring download classification and HTML import.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "FlareGet" > /dev/null; then
if [ -f /usr/bin/flareget ]; then
                    im=$im"FALSE \"FlareGet\"    \"full featured, advanced, multi-threaded, multi-segment download manager and accelerator for Linux.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"FlareGet\"    \"full featured, advanced, multi-threaded, multi-segment download manager and accelerator for Linux.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Tucan Manager" > /dev/null; then
if [ -f /usr/bin/tucan ]; then
                    im=$im"FALSE \"Tucan Manager\"    \"Manager for downloads and uploads at hosting sites.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Tucan Manager\"    \"Manager for downloads and uploads at hosting sites.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Yum Extender" > /dev/null; then
if [ -f /usr/bin/yumex ]; then
                    im=$im"FALSE \"Yum Extender\"    \"Yum Extender graphical package management tool.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Yum Extender\"    \"Yum Extender graphical package management tool.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Blueman" > /dev/null; then
if [ -f /usr/bin/blueman-manager ]; then
                    im=$im"FALSE \"Blueman\"    \"GTK+ bluetooth manager.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Blueman\"    \"GTK+ bluetooth manager.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Google-Chrome" > /dev/null; then
if [ -f /opt/google/chrome/google-chrome ]; then
                    im=$im"FALSE \"Google-Chrome\"    \"Browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Google-Chrome\"    \"Browser that combines a minimal design with sophisticated technology to make the web faster, safer, and easier.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Chromium" > /dev/null; then
if [ -f /usr/bin/chromium-browser ]; then
                    im=$im"FALSE \"Chromium\"    \"The open-source project behind Google Chrome, an attempt at creating a safer, faster, and more stable browser.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Chromium\"    \"The open-source project behind Google Chrome, an attempt at creating a safer, faster, and more stable browser.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Opera" > /dev/null; then
if [ -f /usr/bin/opera ]; then
                    im=$im"FALSE \"Opera\"    \"Web browser, smaller, faster, customize, powerful, yet user-friendly.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Opera\"    \"Web browser, smaller, faster, customize, powerful, yet user-friendly.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "BleachBit" > /dev/null; then
if [ -f /usr/bin/bleachbit ]; then
                    im=$im"FALSE \"BleachBit\"    \"Deletes unneeded files to free disk space and maintain privacy.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"BleachBit\"    \"Deletes unneeded files to free disk space and maintain privacy.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "GnomeTweakTool and dconf-editor" > /dev/null; then
if [ -f /usr/bin/gnome-tweak-tool ] && [ -f /usr/bin/dconf-editor ] && [ -f /usr/bin/gconf-editor ]; then
                    im=$im"FALSE \"GnomeTweakTool and dconf-editor\"    \"Advanced tools for customizing GNOME 3 options.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"GnomeTweakTool and dconf-editor\"    \"Advanced tools for customizing GNOME 3 options.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Menu Libre" > /dev/null; then
if [ -f /usr/bin/menulibre ]; then
                    im=$im"FALSE \"Menu Libre\"    \"An advanced menu editor that provides modern features in a clean, easy-to-use interface.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Menu Libre\"    \"An advanced menu editor that provides modern features in a clean, easy-to-use interface.\" \"NO INSTALLED  \"  "
fi
            fi

if ! $installed | grep "Complete pending installations" > /dev/null; then
                    im=$im"FALSE \"Complete pending installations\"    \"Continuing uncompleted installations for system errors.\" \"ACTIVO  \"  "
            fi


if ! $installed | grep "Bitdefender" > /dev/null; then
if [ -f /opt/BitDefender-scanner/bin/bdgui ] || [ -f /opt/BitDefender-scanner/bin/bdscan ]; then
                    im=$im"FALSE \"Bitdefender\"    \"Advanced antivirus for partitions NTSF.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Bitdefender\"    \"Advanced antivirus for partitions NTSF.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "System Information" > /dev/null; then
                    im=$im"FALSE \"System Information\"    \"Must the System Information\" \"ACTIVO  \"  "
            fi


if ! $installed | grep "Hardinfo" > /dev/null; then
if [ -f /usr/bin/hardinfo ]; then
                    im=$im"FALSE \"Hardinfo\"    \" A system information and benchmark tool.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Hardinfo\"    \" A system information and benchmark tool.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Batti" > /dev/null; then
if [ -f /usr/bin/batti ]; then
                    im=$im"FALSE \"Batti\"    \"Simple battery monitor for the system tray.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Batti\"    \"Simple battery monitor for the system tray.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Alien" > /dev/null; then
if [ -e /usr/bin/alien ]; then
                    im=$im"FALSE \"Alien\"    \"Convert and install deb and other packages: rpm, slackware tgz.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Alien\"    \"Convert and install deb and other packages: rpm, slackware tgz.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Microsoft TrueType core fonts" > /dev/null; then
if [ -d /usr/share/fonts/msttcorefonts ]; then
                    im=$im"FALSE \"Microsoft TrueType core fonts\"    \"TrueType core fonts for the web.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Microsoft TrueType core fonts\"    \"TrueType core fonts for the web.\" \"NO INSTALLED  \"  "
fi
            fi


if ! $installed | grep "Reset PostInstallerF" > /dev/null; then
                    im=$im"FALSE \"Reset PostInstallerF\"    \"Restart the registry, of the programs installed via PostInstallerF.\" \"ACTIVE  \"  "
            fi
fi



    }



chooseInstalls(){
     
            #choosing witch installs/tweaks to run
            echo "Running Choice Menu..."
            choice=`echo $im | sh -`
           
#installing dependency stdc++-33
            if test ${#choice} -gt 0; then
                    libstdc
            fi
     
            if echo $choice | grep "Repositorios RPM Fusion" > /dev/null; then
                    extraRepos
       
            fi


if echo $choice | grep "Repositories RPM Fusion" > /dev/null; then
                    extraRepos
       
            fi
          
            if echo $choice | grep "Cambiar lenguaje del sistema" > /dev/null; then
                    lenguaje
            fi


if echo $choice | grep "Change system language" > /dev/null; then
                    lenguaje
            fi

            if echo $choice | grep "Herramientas Básicas de compilación" > /dev/null; then
                    basicompile
            fi


if echo $choice | grep "Build Basic Tools" > /dev/null; then
                    basicompile
            fi

if echo $choice | grep "Mozilla Firefox" > /dev/null; then
                    zorrito
            fi

            if echo $choice | grep "Instalar Codecs Audio/Video" > /dev/null; then
                    multimediaCodecs
            fi

            if echo $choice | grep "Install Codecs Audio/Video" > /dev/null; then
                    multimediaCodecs
            fi

            if echo $choice | grep "Flash Player" > /dev/null; then
                    flash
            fi
            if echo $choice | grep "Unrar y p7zip" > /dev/null; then
                    comprimir
            fi


            if echo $choice | grep "Unrar and p7zip" > /dev/null; then
                    comprimir
            fi

            if echo $choice | grep "Java OpenJDK" > /dev/null; then
                    java
            fi

            if echo $choice | grep "Java JRE Oracle" > /dev/null; then
                    jre
            fi

            if echo $choice | grep "Java JDK Oracle" > /dev/null; then
                    jdkin
            fi

            if echo $choice | grep "GIMP" > /dev/null; then
                    gimp
            fi

            if echo $choice | grep "Hugin" > /dev/null; then
                    hugp
            fi

            if echo $choice | grep "Converseen" > /dev/null; then
                    converseen
            fi 

            if echo $choice | grep "MyPaint" > /dev/null; then
                    mipaint
            fi

            if echo $choice | grep "Pinta" > /dev/null; then
                    pint
            fi

            if echo $choice | grep "Pencil" > /dev/null; then
                    pencil
            fi

            if echo $choice | grep "Fotoxx" > /dev/null; then
                    fotoxx
            fi
            if echo $choice | grep "Shutter" > /dev/null; then
                    shutter
            fi
            if echo $choice | grep "Glabels" > /dev/null; then
                    glabels
            fi
            if echo $choice | grep "Kover" > /dev/null; then
                    kover
            fi
            if echo $choice | grep "LibreOffice" > /dev/null; then
                    office
            fi

            if echo $choice | grep "Basket" > /dev/null; then
                    basquet
            fi

            if echo $choice | grep "ProjectLibre" > /dev/null; then
                    project
            fi

            if echo $choice | grep "Adobe Reader" > /dev/null; then
                    reader
            fi
            if echo $choice | grep "PDF Mod" > /dev/null; then
                    pdfmod
            fi

            if echo $choice | grep "PDF Split and Merge" > /dev/null; then
                    pdfsam
            fi

            if echo $choice | grep "YAGF" > /dev/null; then
                    yagsca
            fi

            if echo $choice | grep "Scribus" > /dev/null; then
                    scribus
            fi
            if echo $choice | grep "Dia" > /dev/null; then
                    adia
            fi
            if echo $choice | grep "Gnumeric" > /dev/null; then
                    gnu
            fi
            if echo $choice | grep "Planner" > /dev/null; then
                    planner
            fi
            if echo $choice | grep "VYM" > /dev/null; then
                    vym
            fi
            if echo $choice | grep "Freemind" > /dev/null; then
                    freemind
            fi

            if echo $choice | grep "yEd" > /dev/null; then
                    yEdt
            fi

            if echo $choice | grep "Cmap Tools" > /dev/null; then
                    cmap
            fi

            if echo $choice | grep "Anki" > /dev/null; then
                    anki
            fi
            
            if echo $choice | grep "Wine y winetricks" > /dev/null; then
                    wine
            fi


if echo $choice | grep "Wine and winetricks" > /dev/null; then
                    wine
            fi

            if echo $choice | grep "Oracle Virtual Box" > /dev/null; then
                    virtualbox
            fi
            if echo $choice | grep "PlayOnLinux" > /dev/null; then
                    play
            fi
            if echo $choice | grep "TeamViewer" > /dev/null; then
                    team
            fi
            if echo $choice | grep "DropBox" > /dev/null; then
                    dropbox
            fi
            if echo $choice | grep "Hyper Video Converter" > /dev/null; then
                    Hyper
            fi

            if echo $choice | grep "Miro Video Converter" > /dev/null; then
                    mvcon
            fi

            if echo $choice | grep "Arista Transcoder" > /dev/null; then
                    arista
            fi

            if echo $choice | grep "Qwinff" > /dev/null; then
                    qwinf
            fi
            if echo $choice | grep "Transcoder" > /dev/null; then
                    transcoder
            fi
            if echo $choice | grep "Mobilmedia Converter" > /dev/null; then
                    Mobilmedia
            fi
            if echo $choice | grep "YakiTo" > /dev/null; then
                    yakiTo
            fi
            if echo $choice | grep "Ekd" > /dev/null; then
                    ekd
            fi

            if echo $choice | grep "FF Multi Converter" > /dev/null; then
                    ffmulticonverter
            fi
           
            if echo $choice | grep "GtkPod" > /dev/null; then
                    gtkPod
            fi
            if echo $choice | grep "EasyTag" > /dev/null; then
                    easyTag
            fi
            if echo $choice | grep "Avidemux" > /dev/null; then
                    avidemux
            fi
            if echo $choice | grep "Blender" > /dev/null; then
                    blender
            fi

            if echo $choice | grep "Tupi" > /dev/null; then
                    tupapi
            fi

            if echo $choice | grep "BRL-CAD" > /dev/null; then
                    brlcad
            fi

            if echo $choice | grep "Sweet Home 3D" > /dev/null; then
                    Sweet
            fi
            if echo $choice | grep "LibreCAD" > /dev/null; then
                    libreCAD
            fi

            if echo $choice | grep "FreeCAD" > /dev/null; then
                    freecad
            fi

            if echo $choice | grep "DraftSight" > /dev/null; then
                    Draft
            fi

            if echo $choice | grep "Inkscape" > /dev/null; then
                    inkscape
            fi
     
            if echo $choice | grep "Openshot" > /dev/null; then
                    openshot
            fi

if echo $choice | grep "Kdenlive" > /dev/null; then
                    kden
            fi


if echo $choice | grep "LIVES" > /dev/null; then
                    lives
            fi


if echo $choice | grep "Imagination" > /dev/null; then
                    imagination
            fi


if echo $choice | grep "DeveDe" > /dev/null; then
                    deveDe
            fi


if echo $choice | grep "DVDStyler" > /dev/null; then
                    dVDStyler
            fi


if echo $choice | grep "ffDiaporama" > /dev/null; then
                    ffaporama
            fi

if echo $choice | grep "Wink" > /dev/null; then
                    wnk 
            fi

if echo $choice | grep "Virtual Lighttable and Darkroom" > /dev/null; then
                    Virtual
            fi


if echo $choice | grep "Gnome Subtitles" > /dev/null; then
                    GnomeSubtitles
            fi


if echo $choice | grep "VLC media player" > /dev/null; then
                    vlc
            fi

if echo $choice | grep "Netflix Player" > /dev/null; then
                    flix
            fi

if echo $choice | grep "XBMC" > /dev/null; then
                    xbm
            fi


if echo $choice | grep "Clementine" > /dev/null; then
                    clementine
            fi


if echo $choice | grep "Sound converter" > /dev/null; then
                    sound
            fi


if echo $choice | grep "Audacity" > /dev/null; then
                    audacity
            fi

if echo $choice | grep "OcenAudio" > /dev/null; then
                    ocenaudio
            fi

if echo $choice | grep "Mixxx" > /dev/null; then
                    mix
            fi


if echo $choice | grep "SKYPE" > /dev/null; then
                    skype
            fi

if echo $choice | grep "Jitsi" > /dev/null; then
                    jitsi
            fi

if echo $choice | grep "Turpial" > /dev/null; then
                    turpial
            fi


if echo $choice | grep "Gwibber" > /dev/null; then
                    gwibber
            fi


if echo $choice | grep "Bible Time" > /dev/null; then
                    bible
            fi


if echo $choice | grep "Tuxpaint" > /dev/null; then
                    tuxpaint
            fi


if echo $choice | grep "Stellarium" > /dev/null; then
                    Stellar
            fi


if echo $choice | grep "Celestia" > /dev/null; then
                    celestia
            fi


if echo $choice | grep "Google Earth" > /dev/null; then
                    Earth
            fi


if echo $choice | grep "Gcompris" > /dev/null; then
                    gcompris
            fi


if echo $choice | grep "TuxMath" > /dev/null; then
                    tuxMath
            fi


if echo $choice | grep "TuxType" > /dev/null; then
                    tuxType
            fi


if echo $choice | grep "Childsplay" > /dev/null; then
                    childsplay
            fi


if echo $choice | grep "Scratch" > /dev/null; then
                    scratch
            fi


if echo $choice | grep "Ri-li" > /dev/null; then
                    ri
            fi


if echo $choice | grep "Frozen Bubble" > /dev/null; then
                    Frozen
            fi


if echo $choice | grep "Extreme Tux Racer" > /dev/null; then
                    Extreme
            fi


if echo $choice | grep "Super Tux Kart" > /dev/null; then
                    Super
            fi


if echo $choice | grep "Wormux" > /dev/null; then
                    wormux
            fi


if echo $choice | grep "Tremulous" > /dev/null; then
                    tremulous
            fi


if echo $choice | grep "Super Methane Brothers" > /dev/null; then
                    Methane
            fi


if echo $choice | grep "Pingus" > /dev/null; then
                    pingus
            fi


if echo $choice | grep "Hedgewars" > /dev/null; then
                    hedgewars
            fi


if echo $choice | grep "Glaxium" > /dev/null; then
                    glaxium
            fi


if echo $choice | grep "Amoebax" > /dev/null; then
                    amoebax
            fi


if echo $choice | grep "Alien Arena" > /dev/null; then
                    AlienArena
            fi


if echo $choice | grep "TORCS" > /dev/null; then
                    tORCS
            fi


if echo $choice | grep "FlightGear" > /dev/null; then
                    flightGear
            fi

if echo $choice | grep "Performous" > /dev/null; then
                    perfo
            fi

if echo $choice | grep "Steam" > /dev/null; then
                    stea
            fi

if echo $choice | grep "Aquaria" > /dev/null; then
                    aqua
            fi

if echo $choice | grep "Gtk-Gnutella" > /dev/null; then
                    Gnutella
            fi


if echo $choice | grep "GrooveDown" > /dev/null; then
                    grooveDown
            fi

if echo $choice | grep "GrooveOff" > /dev/null; then
                    veOff
            fi

if echo $choice | grep "Frostwire" > /dev/null; then
                    wirefro
            fi

if echo $choice | grep "UGET" > /dev/null; then
                    uget
            fi


if echo $choice | grep "Tucan Manager" > /dev/null; then
                    tucan
            fi


if echo $choice | grep "Yum Extender" > /dev/null; then
                    YumExtender
            fi


if echo $choice | grep "Blueman" > /dev/null; then
                    blue
            fi


if echo $choice | grep "Google-Chrome" > /dev/null; then
                    Chrome
            fi


if echo $choice | grep "Chromium" > /dev/null; then
                    chromium
            fi


if echo $choice | grep "Opera" > /dev/null; then
                    opera
            fi


if echo $choice | grep "BleachBit" > /dev/null; then
                    bleachBit
            fi


if echo $choice | grep "GnomeTweakTool y dconf-editor" > /dev/null; then
                    GnomeTweak
            fi

if echo $choice | grep "GnomeTweakTool and dconf-editor" > /dev/null; then
                    GnomeTweak
            fi

if echo $choice | grep "Menu Libre" > /dev/null; then
                    mlibre
            fi

if echo $choice | grep "Completar Instalaciones pendientes" > /dev/null; then
                    pendientes
            fi

if echo $choice | grep "Complete pending installations" > /dev/null; then
                    pendientes
            fi


if echo $choice | grep "Bitdefender" > /dev/null; then
                    bitdefender
            fi


if echo $choice | grep "Informacion del Sistema" > /dev/null; then
                    infosystem
            fi


if echo $choice | grep "System Information" > /dev/null; then
                    infosystem
            fi


if echo $choice | grep "Hardinfo" > /dev/null; then
                    hardinfo
            fi


if echo $choice | grep "Batti" > /dev/null; then
                    batti
            fi


if echo $choice | grep "Alien" > /dev/null; then
                    alien
            fi


if echo $choice | grep "Microsoft TrueType core fonts" > /dev/null; then
                    truetype
            fi


if echo $choice | grep "Reset PostInstallerF" > /dev/null; then
                    cleanlog
            fi


    }
     
     
    ##
    ## Tweak/Install functions
    ##

libstdc(){
            #Checking for libstdc++-33
            if ! $installed | grep "libstdc++-33" > /dev/null; then
                    #zenity --notification --text "Installing dependency compat-libstdc++-33" &
                    echo "Installing dependency compat-libstdc++-33..."
                    yum -y install compat-libstdc++-33
                    echo "libstdc++-33" >> installed.log
            fi
    }
     
    extraRepos(){
            echo "Adding rpmfusion repositories..."    
            
if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-16.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-16.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=350
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "17" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-17.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-17.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=350
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=350
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-19.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-19.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "20" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-20.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-20.noarch.rpm 2>&1 | zenity --progress --title "Verificando o agregando Repositorio RPMFusion" --text="Por favor espere...." --pulsate --auto-close --width=400
fi
  
     
    
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Repositorio RPMFusion " -i "/usr/share/icons/pinguino.png" -t 5000'
else           
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Repositorio RPMFusion " -i "/usr/share/icons/pinguino.png" -t 5000'
fi
     

    }
     
    lenguaje(){

if [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "es" ]; then
yum -y install kde-l10n-Spanish | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando soporte español para KDE" --text="Por favor espere...." --pulsate --auto-close --width=350

elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "pt" ]; then
yum -y install kde-l10n-Portuguese | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalação de suporte para KDE Português" --text="Por favor espere...." --pulsate --auto-close --width=350


elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "fr" ]; then
yum -y install kde-l10n-French | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installation de soutien français pour KDE" --text="Por favor espere...." --pulsate --auto-close --width=350



elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "ja" ]; then
yum -y install kde-l10n-Japanese | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "KDE用日本語サポートのインストール" --text="Por favor espere...." --pulsate --auto-close --width=350



elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "zh" ]; then
yum -y install kde-l10n-Chinese | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "安装中国支持KDE" --text="Por favor espere...." --pulsate --auto-close --width=350



elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "it" ]; then
yum -y install kde-l10n-Italian | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installazione del il supporto per KDE italiana" --text="Por favor espere...." --pulsate --auto-close --width=350
fi    
    
            yum -y install system-config-language 2>&1 | zenity --progress  --title="'Instalando el administrador de lenguaje" --text="Please wait...." --pulsate --auto-close --width=350
system-config-language

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Administrador de Lenguaje" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Administrador de Lenguaje" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

    }
     
    basicompile(){
            yum -y install kernel-headers kernel-devel hg git | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando kernel-headers, devel, hg y git" --text="Por favor espere...." --pulsate --auto-close --width=350

 yum -y groupinstall "Development Tools" "Legacy Software Development" | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Development Tools y Legacy Software Development" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y groupinstall "Development Libraries" | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Development Libraries..." --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y groupinstall "x-software-development" | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando x-software-development..." --text="Por favor espere...." --pulsate --auto-close --width=350

$changelog
echo "Herramientas Básicas de compilación" >> installed.log

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada instalacion de Herramientas Básicas de compilación" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Completada instalacion de Herramientas Básicas de compilación" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
    }


    zorrito(){
            yum -y install firefox | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Mozilla Firefox" --text="Por favor espere...." --pulsate --auto-close --width=350

$changelog
echo "Mozilla Firefox" >> installed.log

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada instalacion de Mozilla Firefox" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Completada instalacion de Mozilla Firefox" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
    }

     
    multimediaCodecs(){

            yum -y install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando codecs de video y audio" --text="Por favor espere...." --pulsate --auto-close --width=350

 yum -y install ffmpeg mencoder ffmpeg2theora mplayer libdvdcss | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando codecs de video y audio" --text="Por favor espere...." --pulsate --auto-close --width=350 

yum -y install gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando codecs de video y audio extras" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y install faac vo-aacenc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing encoders of video extras" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/k3b ]; then
yum -y install k3b-extras-freeworld | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando k3b Extras Freeworld" --text="Por favor espere...." --pulsate --auto-close --width=350
fi
             
            $changelog
            echo "Multimedia codecs" >> installed.log

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada instalacion de Multimedia codecs" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Completada instalacion de Multimedia codecs" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

    }

     
    flash(){
            yum -y localinstall http://linuxdownload.adobe.com/linux/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Por favor espere...." --pulsate --auto-close --width=350
yum -y install flash-plugin | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando flash-plugin" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Flash Player" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Flash Player" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "Flash Player" >> installed.log
    }
     
    comprimir(){
            yum -y install unrar p7zip p7zip-plugins | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando unrar y p7zip" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Unrar y p7zip" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Unrar y p7zip" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

                    echo "Unrar y p7zip" >> installed.log
            
    }
     
    java(){
            yum -y install java icedtea-web | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Java OpenJDK" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Java OpenJDK" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Java OpenJDK" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

     
            echo "Java OpenJDK" >> installed.log
    }


jre(){

rm -f /tmp/jre-oraclejava.rpm
rm -f /etc/profile.d/java.sh

if [ -f /usr/lib/IcedTeaPlugin.so ] || [ -f /usr/lib64/IcedTeaPlugin.so ]; then
xterm -e 'yum -y remove icedtea-web'
fi

PKGSINSTALLED=$(rpm -qa jdk*-linux-*.rpm)  

 if [[ -n "$PKGSINSTALLED" ]]; then

zenity --question --title="Detected jkd oracle java installed" --text="You need uninstall jdk oracle java, Do you want uninstall" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then

xterm -e 'yum -y remove jdk'

rm -f /etc/profile.d/java.sh

if [ `getconf LONG_BIT` = "64" ]
then
rm -f /usr/lib64/mozilla/plugins/libnpjp2.so
else
rm -f /usr/lib/mozilla/plugins/libnpjp2.so
fi  
           
if [ `getconf LONG_BIT` = "64" ]
then
xterm -e 'wget -c -P/tmp/ -r -l1 -H -t1 -nd -N -np -Ajre*-linux-x64.rpm -erobots=off http://uni-smr.ac.ru/archive/dev/java/JRE/oracle/7/'
wait ${!}

xterm -e 'yum -y install /tmp/jre*-linux-x64.rpm'
else
xterm -e 'wget -c -P/tmp/ -r -l1 -H -t1 -nd -N -np -Ajre*-linux-i586.rpm -erobots=off http://uni-smr.ac.ru/archive/dev/java/JRE/oracle/7/'
wait ${!}
xterm -e 'yum -y install /tmp/jre*-linux-i586.rpm'
fi


if [ `getconf LONG_BIT` = "64" ]
then
ln -s /usr/java/latest/lib64/x86_64/libnpjp2.so /usr/lib64/mozilla/plugins/
else
ln -s /usr/java/latest/lib/i386/libnpjp2.so /usr/lib/mozilla/plugins/
fi

echo 'PATH=/usr/java/latest/bin:$PATH' >> /etc/profile.d/java.sh

if [ `getconf LONG_BIT` = "64" ]
then
rm -f jre*-linux-x64.rpm
else
rm -f jre*-linux-i586.rpm
fi

else
echo 'en otra ocacion'
fi

 else

if [ `getconf LONG_BIT` = "64" ]
then
xterm -e 'wget -c -P/tmp/ -r -l1 -H -t1 -nd -N -np -Ajre*-linux-x64.rpm -erobots=off http://uni-smr.ac.ru/archive/dev/java/JRE/oracle/7/'
wait ${!}
xterm -e 'yum -y install /tmp/jre*-linux-x64.rpm'
else
xterm -e 'wget -c -P/tmp/ -r -l1 -H -t1 -nd -N -np -Ajre*-linux-i586.rpm -erobots=off http://uni-smr.ac.ru/archive/dev/java/JRE/oracle/7/'
wait ${!}
xterm -e 'yum -y install /tmp/jre*-linux-i586.rpm'
fi

if [ -f /usr/lib64/mozilla/plugins/libnpjp2.so ] || [ -f /usr/lib/mozilla/plugins/libnpjp2.so ]; then
echo 'jre plugin enabled'
else
if [ `getconf LONG_BIT` = "64" ]
then
ln -s /usr/java/latest/lib64/x86_64/libnpjp2.so /usr/lib64/mozilla/plugins/
else
ln -s /usr/java/latest/lib/i386/libnpjp2.so /usr/lib/mozilla/plugins/
fi
  fi

if [ -f /etc/profile.d/java.sh ]; then
echo 'default jdk java enabled'
else
echo 'PATH=/usr/java/latest/bin:$PATH' >> /etc/profile.d/java.sh
fi

if [ `getconf LONG_BIT` = "64" ]
then
rm -f jre*-linux-x64.rpm
else
rm -f jre*-linux-i586.rpm
fi
  fi


if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Java JRE Oracle" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Java JRE Oracle" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
     
    }


jdkin(){  

if [ -f /usr/lib/IcedTeaPlugin.so ] || [ -f /usr/lib64/IcedTeaPlugin.so ]; then
xterm -e 'yum -y remove icedtea-web'
fi


PKGSINSTALLED=$(rpm -qa jdk*-linux-*.rpm)  

	if [[ -n "$PKGSINSTALLED" ]]; then

zenity --question --title="Detected jre oracle java installed" --text="You need uninstall jre oracle java, Do you want uninstall" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then

xterm -e 'yum -y remove jre'

rm -f /etc/profile.d/java.sh

if [ `getconf LONG_BIT` = "64" ]
then
rm -f /usr/lib64/mozilla/plugins/libnpjp2.so
else
rm -f /usr/lib/mozilla/plugins/libnpjp2.so
fi

if [ `getconf LONG_BIT` = "64" ]
then
xterm -e 'wget -c -P/tmp/ -r -l1 -H -t1 -nd -N -np -Ajdk*-linux-x64.rpm -erobots=off http://ftp.wsisiz.edu.pl/pub/pc/pozyteczne%20oprogramowanie/java/'
wait ${!}
xterm -e 'yum -y install /tmp/jdk*-linux-x64.rpm'
else
xterm -e 'wget -c -P/tmp/ -r -l1 -H -t1 -nd -N -np -Ajdk*-linux-i586.rpm -erobots=off http://ftp.wsisiz.edu.pl/pub/pc/pozyteczne%20oprogramowanie/java/'
wait ${!}
xterm -e 'yum -y install /tmp/jdk*-linux-i586.rpm'
fi


if [ `getconf LONG_BIT` = "64" ]
then
ln -s /usr/java/latest/jre/lib/amd64/libnpjp2.so /usr/lib64/mozilla/plugins/
else
ln -s /usr/java/latest/jre/lib/i386/libnpjp2.so /usr/lib/mozilla/plugins/
fi

echo 'PATH=/usr/java/latest/bin:$PATH' >> /etc/profile.d/java.sh

if [ `getconf LONG_BIT` = "64" ]
then
rm -f jdk*-linux-x64.rpm
else
rm -f jdk*-linux-i586.rpm
fi

 else
echo 'en otra ocacion'
  fi

  else 


          
if [ `getconf LONG_BIT` = "64" ]
then
xterm -e 'wget -c -P/tmp/ -r -l1 -H -t1 -nd -N -np -Ajdk*-linux-x64.rpm -erobots=off http://ftp.wsisiz.edu.pl/pub/pc/pozyteczne%20oprogramowanie/java/'
wait ${!}
xterm -e 'yum -y install /tmp/jdk*-linux-x64.rpm'
else
xterm -e 'wget -c -P/tmp/ -r -l1 -H -t1 -nd -N -np -Ajdk*-linux-i586.rpm -erobots=off http://ftp.wsisiz.edu.pl/pub/pc/pozyteczne%20oprogramowanie/java/'
wait ${!}
xterm -e 'yum -y install /tmp/jdk*-linux-i586.rpm'
fi

if [ -f /usr/lib64/mozilla/plugins/libnpjp2.so ] || [ -f /usr/lib/mozilla/plugins/libnpjp2.so ]; then
echo 'jdk plugin enabled, removing old ln'
rm -f  /usr/lib64/mozilla/plugins/libnpjp2.so
rm -f  /usr/lib/mozilla/plugins/libnpjp2.so
else
if [ `getconf LONG_BIT` = "64" ]
then
ln -s /usr/java/latest/jre/lib/amd64/libnpjp2.so /usr/lib64/mozilla/plugins/
else
ln -s /usr/java/latest/jre/lib/i386/libnpjp2.so /usr/lib/mozilla/plugins/
fi
  fi

if [ -f /etc/profile.d/java.sh ]; then
echo 'default jdk java enabled'
else
echo 'PATH=/usr/java/latest/bin:$PATH' >> /etc/profile.d/java.sh
fi

if [ `getconf LONG_BIT` = "64" ]
then
rm -f jdk*-linux-x64.rpm
else
rm -f jdk*-linux-i586.rpm
fi
  
   fi

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Java JDK Oracle" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Java JKD Oracle" -i "/usr/share/icons/pinguino.png" -t 5000'
fi   

    }

     
    gimp(){
            yum -y install gimp | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando GIMP" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de GIMP" -i "/usr/share/icons/pincel_rco.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of GIMP" -i "/usr/share/icons/pincel_rco.png" -t 5000'
fi
           
            echo "GIMP" >> installed.log
    }

    hugp(){
            yum -y install hugin | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Hugin" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Hugin" -i "/usr/share/icons/pincel_rco.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Hugin" -i "/usr/share/icons/pincel_rco.png" -t 5000'
fi
           
            echo "Hugin" >> installed.log
    }


     converseen(){
            yum -y install converseen | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Converseen" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Converseen" -i "/usr/share/icons/pincel_rco.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Converseen" -i "/usr/share/icons/pincel_rco.png" -t 5000'
fi
           
            echo "Converseen" >> installed.log
    }

     
    mipaint(){
            yum -y install mypaint | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando MyPaint" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de MyPaint" -i "/usr/share/icons/pincel_rco.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of MyPaint" -i "/usr/share/icons/pincel_rco.png" -t 5000'
fi
     
            echo "MyPaint" >> installed.log
    }


    pint(){
            yum -y install pinta | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Pinta" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Pinta" -i "/usr/share/icons/pincel_rco.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Pinta" -i "/usr/share/icons/pincel_rco.png" -t 5000'
fi
     
            echo "Pinta" >> installed.log
    }


    pencil(){
            yum -y --enablerepo=updates-testing install pencil | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Pencil" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Pencil" -i "/usr/share/icons/pincel_rco.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Pencil" -i "/usr/share/icons/pincel_rco.png" -t 5000'
fi
     
            echo "Pencil" >> installed.log
    }

    
    fotoxx(){
            yum -y install fotoxx | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Fotoxx" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Fotoxx" -i "/usr/share/icons/camera.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Fotoxx" -i "/usr/share/icons/camera.png" -t 5000'
fi
     
            echo "Fotoxx" >> installed.log
    }
     
    shutter(){
            yum -y install shutter | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Shutter" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Shutter" -i "/usr/share/icons/camera.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Shutter" -i "/usr/share/icons/camera.png" -t 5000'
fi
     
            echo "Shutter" >> installed.log
    }
     
    glabels(){
            yum -y install glabels | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Glabels" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Glabels" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Glabels" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "Glabels" >> installed.log
    }
     
    kover(){
            yum -y install kover | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Kover" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Kover" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Kover" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "Kover" >> installed.log
    }
     
    office(){
            yum -y install libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-draw libreoffice-langpack-es | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando LibreOffice" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de LibreOffice" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of LibreOffice" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
     
            echo "LibreOffice" >> installed.log
    }


    basquet(){ 

yum -y install basket | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Basket" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/basket ]; then
$changelog
echo "Basket" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Basket" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Basket" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Basket not installed, please try again."
fi

     
            
    }


    caligra(){
            yum -y install calligra | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Calligra" --text="Please wait...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Calligra" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of LibreOffice" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
     
            echo "LibreOffice" >> installed.log
    }


project(){
            
foo3=$(w3m -dump http://sourceforge.net/projects/projectlibre/files/ProjectLibre/); echo "foo3=$foo3" >> /tmp/projectlibre.txt
wait ${!}
egrep '1.' /tmp/projectlibre.txt | sed '1d' | awk '{print $1}' | head -1 >> /tmp/lastest_projectlibre.txt

latestfoo3=$(cat /tmp/lastest_projectlibre.txt ); echo "latestfoo3=$latestfoo3"

yum -y localinstall http://sourceforge.net/projects/projectlibre/files/ProjectLibre/$latestfoo3/projectlibre-$latestfoo3-1.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando ProjectLibre" --text="Por favor espere...." --pulsate --auto-close --width=350 

cat /dev/null > /tmp/projectlibre.txt
cat /dev/null > /tmp/lastest_projectlibre.txt

if [ -f /usr/bin/projectlibre ]; then
$changelog
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de ProjectLibre" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of ProjectLibre" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else
     xterm -e 'yum -y install http://sourceforge.net/projects/projectlibre/files/ProjectLibre/1.5.4/projectlibre-1.5.4-1.rpm'
if [ -f /usr/bin/projectlibre ]; then
$changelog
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de ProjectLibre" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of ProjectLibre" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 fi
fi
     

    }
     
    reader(){
            yum -y localinstall http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Por favor espere...." --pulsate --auto-close --width=350
 yum -y install nspluginwrapper AdobeReader_enu | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Adobe Reader" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Adobe Reader" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Adobe Reader" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
            echo "Adobe Reader" >> installed.log
    }
     
    pdfmod(){
            yum -y install pdfmod | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando PDF Mod" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/pdfmod ]; then
$changelog
echo "PDF Mod" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de PDF Mod" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of PDF Mod" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason PDF Mod not installed, please try again"
fi


    }

   pdfsam(){
rm -f /usr/share/applications/pdfsam.desktop 
rm -f /usr/share/applications/Split\ and\ Merge.desktop
rm -f /usr/share/applications/pdfsam.desktop
rm -rf /usr/share/pdfsam-*/
rm -f /opt/pdfsam-out.zip
rm -f /usr/bin/pdfsam.sh
rm -rf /home/$noti/.pdfsam/


        
yum -y install pdfsam | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing PDF Split and Merge" --text="Please wait...." --pulsate --auto-close --width=350



if [ -f /usr/bin/pdfsam ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de PDF Split and Merge" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of PDF Split and Merge" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason PDF Split not installed, please try again"
fi

    }


yagsca(){
            yum -y install yagf | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando YAGF" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de YAGF" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of YAGF" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "YAGF" >> installed.log
    }
     
    scribus(){
            yum -y install scribus | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Scribus" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Scribus" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Scribus" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "Scribus" >> installed.log
    }
     
    adia(){
            yum -y install dia | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Dia" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Dia" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Dia" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
            echo "Dia" >> installed.log
    }
     
    gnu(){
            yum -y install gnumeric | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Gnumeric" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Gnumeric" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Gnumeric" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
            echo "Gnumeric" >> installed.log
    }
     
    planner(){
            yum -y install planner | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Planner" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Planner" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Planner" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "Planner" >> installed.log
    }
     
    vym(){
            yum -y install vym | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando VYM" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de VYM" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of VYM" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "VYM" >> installed.log
    }
     
    freemind(){
            yum -y install freemind | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Freemind" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Freemind" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Freemind" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
            echo "Freemind" >> installed.log
    }


yEdt(){
            yum -y install java | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Java como complemento" --text="Por favor espere...." --pulsate --auto-close --width=350

wget -c -P/tmp/ http://www.yworks.com/products/yed/demo/yEd-3.9.2_setup.sh 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading: yEd  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500

xterm -e 'sh /tmp/yEd-3.9.2_setup.sh'

if [ -f /opt/yEd/yEd ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de yEd" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of yEd" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
            echo "yEd" >> installed.log
else
zenity --info --title="PostInstallerF" --text="For some reason yEd not installed, please try again"
fi

    }


cmap(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then
yum -y localinstall http://sourceforge.net/projects/postinstaller/files/fedora/releases/19/i386/updates/cmaptools-5.05-2.fc19.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando CmapTools" --text="Por favor espere...." --pulsate --auto-close --width=350
else
yum -y install cmaptools | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando CmapTools" --text="Por favor espere...." --pulsate --auto-close --width=350
fi


    }

     
    anki(){
            yum -y install anki | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Anki" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Anki" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Anki" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "Anki" >> installed.log
    }
     
     
    wine(){
            yum -y install wine cabextract | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Wine" --text="Por favor espere...." --pulsate --auto-close --width=350

 yum -y localinstall ftp://ftp.pbone.net/mirror/cachalot.mine.nu/RPMS/winetricks-20110429-0.fc15.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Winetricks" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Wine y winetricks" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Wine y winetricks" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
     
            echo "Wine y winetricks" >> installed.log
    }
     
    virtualbox(){

if [ -f '/tmp/LATEST.TXT' ]; then
rm -f /tmp/LATEST.TXT
fi

wget -c -P/tmp/ http://download.virtualbox.org/virtualbox/LATEST.TXT

lastest=$(cat /tmp/LATEST.TXT ); echo lastest=$lastest


            if [ -f '/etc/yum.repos.d/virtualbox.repo' ]; then
yum -y install kernel-headers kernel-devel dkms gcc 2>&1 | zenity --progress  --title="Instalando dependencias de Virtual Box" --text="Please wait...." --pulsate --auto-close --width=350
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Por favor espere...." --pulsate --auto-close --width=350

xterm -e 'yum -y install --enablerepo=virtualbox VirtualBox-4.2'
xterm -e '/etc/init.d/vboxdrv setup'
cd /tmp/
wget -c  http://download.virtualbox.org/virtualbox/$lastest/Oracle_VM_VirtualBox_Extension_Pack-$lastest.vbox-extpack 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading: Virtual Box  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
wait ${!}
xterm -e "VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$lastest.vbox-extpack"
usermod -a -G vboxusers $noti
groups $noti
zenity --info --title="PostInstallerF" --text="Para obtener soporte usb en Oracle Virtual Box es necesario reiniciar el sistema "
else
wget -c -P/etc/yum.repos.d/ http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
yum -y install kernel-headers kernel-devel dkms gcc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando dependencias de Virtual Box" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Por favor espere...." --pulsate --auto-close --width=350

xterm -e 'yum -y install --enablerepo=virtualbox VirtualBox-4.2'
xterm -e '/etc/init.d/vboxdrv setup'
cd /tmp/
wget -c  http://download.virtualbox.org/virtualbox/$lastest/Oracle_VM_VirtualBox_Extension_Pack-$lastest.vbox-extpack 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading: Virtual Box  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
wait ${!}
xterm -e "VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-$lastest.vbox-extpack"
usermod -a -G vboxusers $noti
groups $noti
zenity --info --title="PostInstallerF" --text="Para obtener soporte usb en Oracle Virtual Box es necesario reiniciar el sistema "
fi

if [ -f "/etc/yum.repos.d/virtualbox.repo" ] && [ -f /usr/bin/VirtualBox ]; then
rm -f /tmp/Oracle_VM_VirtualBox_Extension_Pack-*.vbox-extpack
$changelog
echo "Oracle Virtual Box" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Oracle Virtual Box" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Oracle Virtual Box" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Oracle Virtual Box not installed, please try again"
fi

    }
     
    play(){
            yum -y install wine cabextract | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Wine" --text="Por favor espere...." --pulsate --auto-close --width=350

 yum -y localinstall ftp://ftp.pbone.net/mirror/cachalot.mine.nu/RPMS/winetricks-20110429-0.fc15.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Winetricks" --text="Por favor espere...." --pulsate --auto-close --width=350 

yum -y localinstall http://rpm.playonlinux.com/PlayOnLinux_yum-3.3.rpm 

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y install playonlinux | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "PlayOnLinux" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/playonlinux ]; then
$changelog
echo "PlayOnLinux" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de PlayOnLinux" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of PlayOnLinux" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason PlayOnLinux not installed, please try again"
fi

    }
     
    team(){
            yum -y localinstall http://www.teamviewer.com/download/teamviewer_linux.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "TeamViewer" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /opt/teamviewer/teamviewer ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de TeamViewer" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of TeamViewer" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason TeamViewer not installed, please try again"
fi

    }
     
    dropbox(){

if [ -f /etc/yum.repos.d/dropbox.repo ]; then
echo 'el repositorio esta incluido'
yum -y install nautilus-dropbox | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Dropbox" --text="Please wait...." --pulsate --auto-close --width=350
echo 'skip_if_unavailable=1' >> /etc/yum.repos.d/dropbox.repo
else
echo '[Dropbox]
name=Dropbox Repository
baseurl=http://linux.dropbox.com/fedora/$releasever/
gpgkey=https://linux.dropbox.com/fedora/rpm-public-key.asc
skip_if_unavailable=1' >> /etc/yum.repos.d/dropbox.repo
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Actualizando" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep2.png" --image-on-top --progress --title "Updating new repositories" --text="Please wait...." --pulsate --auto-close --width=350
yum -y install nautilus-dropbox | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Dropbox" --text="Please wait...." --pulsate --auto-close --width=350
echo 'skip_if_unavailable=1' >> /etc/yum.repos.d/dropbox.repo
fi
            
if [ -f /usr/bin/dropbox ]; then
$changelog
echo "DropBox" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de DropBox" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of DropBox" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Dropbox not installed, please try again"
fi

    }
     
    Hyper(){
            

yum -y install hypervc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Hyper Video Converter" --text="Plesase wait...." --pulsate --auto-close --width=350
 
 

if [ -f /usr/bin/hypervc ]; then
$changelog
echo "Hyper Video Converter" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Hyper Video Converter" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Hyper Video Converter" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Hyper Video Converter not installed, please try again"
fi

    }

    mvcon(){

yum -y install mvc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Miro Video Converter" --text="Please wait...." --pulsate --auto-close --width=350

           
if [ -f /usr/bin/miro-video-converter.py ]; then
$changelog
echo "Miro Video Converter" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Miro Video Converter" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Miro Video Converter" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Miro Video Converter not installed, please try again"
fi

    }
     
    arista(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
zenity --info --title="PostInstallerF" --text="Arista Transcoder is not compatible with Fedora 19, sorry"
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "20" ]; then
zenity --info --title="PostInstallerF" --text="Arista Transcoder is not compatible with Fedora 20, sorry"
else
yum -y install arista | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Arista Transcoder" --text="Por favor espere...." --pulsate --auto-close --width=350
           
if [ -f /usr/bin/arista-gtk ]; then
$changelog
echo "Arista Transcoder" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Arista Transcoder" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Arista Transcoder" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Arista Transcoder not installed, please try again"
fi

fi

    }

    qwinf(){

yum -y install qwinff | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Qwinff" --text="Por favor espere...." --pulsate --auto-close --width=350
           
if [ -f /usr/bin/qwinff ]; then
$changelog
echo "Qwinff" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Qwinff" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Qwinff" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Qwinff not installed, please try again"
fi

    }
     
    transcoder(){
if [ -f /usr/share/applications/Transcoder.desktop ] && [ -f /usr/local/bin/Transcoder/Transcoder ]; then
rm -f /usr/share/applications/Transcoder.desktop
else
echo "ya esta instalado"
fi
            yum -y install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg ffmpeg mencoder ffmpeg2theora mplayer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "codecs de video y audio" --text="Por favor espere...." --pulsate --auto-close --width=350
wait ${!}
cd /usr/local/bin/
wget -c -P/usr/local/bin/ http://sourceforge.net/projects/transcoder84/files/0.0.6/Transcoder_0.0.6_amd64.tar.gz 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:Transcoder  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
cd /usr/local/bin/
tar -xvzf Transcoder_0.0.6_amd64.tar.gz 2>&1 | zenity --progress --title "Extrayendo e instalando Transcoder " --text="Por favor espere...." --pulsate --auto-close --width=350
cp -f /usr/local/bin/Transcoder/data/transcoder.png /usr/share/icons/

echo "[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=/usr/share/icons/transcoder.png
Name[en_US]=Transcoder
Exec=/usr/local/bin/Transcoder/Transcoder
Comment[en_US]=video convert
Name=Transcoder
Comment=video convert
Icon=/usr/share/icons/transcoder.png
Categories=GTK;Application;AudioVideo;Video;" >> /usr/share/applications/Transcoder.desktop

chmod o=rwxs * /usr/share/applications/Transcoder.desktop

if [ -f /usr/local/bin/Transcoder/Transcoder ]; then
$changelog
echo "Transcoder" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Transcoder" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Transcoder" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Transcoder not installed, please try again"
fi


    }
     
    Mobilmedia(){
            yum -y install mmc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Mobilmedia Converter" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/local/bin/mmc ]; then
$changelog
echo "Mobilmedia Converter" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Mobilmedia Converter" -i "/usr/share/icons/pinguino.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="Por alguna razon Mobilmedia Converter no esta instalado, vuelva a intentar "
fi

    }
     
    yakiTo(){
yum -y install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg ffmpeg mencoder ffmpeg2theora mplayer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "codecs de video y audio" --text="Por favor espere...." --pulsate --auto-close --width=350

            yum -y install java | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Java OpenJDK" --text="Por favor espere...." --pulsate --auto-close --width=350

xterm -e 'curl -o yakito-0.1.2-linux.sh http://www.yakiboo.net/yakito/downloads/yakito-0.1.2-linux.sh' 
wait ${!} 
xterm -e 'sudo sh yakito-0.1.2-linux.sh'

if [ -f /usr/bin/yakito ]; then
$changelog
echo "YakiTo" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de YakiTo" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of YakiTo" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason YakiTo not installed, please try again"
fi

    }


ekd(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then

yum -y install ekd | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Ekd" --text="Por favor espere...." --pulsate --auto-close --width=350

elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
zenity --info --title="PostInstallerF" --text="Ekd is not compatible with Fedora 19, sorry"

else

yum -y install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg ffmpeg mencoder ffmpeg2theora mplayer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando codecs de video y audio" --text="Por favor espere...." --pulsate --auto-close --width=350

yum -y install PyQt4 PyQt ImageMagick numpy python-imaging sox | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando dependencias para Ekd" --text="Por favor espere...." --pulsate --auto-close --width=350

foo5=$(w3m -dump http://sourceforge.net/projects/ekd/files/ekd/); echo "foo5=$foo5" >> /tmp/ekd.txt 

egrep '3.' /tmp/ekd.txt | sed '1,2d' | awk '{print $1}' | head -1 >> /tmp/lastest_ekd.txt

wait ${!}

latestfoo5=$(cat /tmp/lastest_ekd.txt ); echo "latestfoo5=$latestfoo5"

yum -y localinstall http://sourceforge.net/projects/ekd/files/ekd/$latestfoo5/GNU-Linux/ekd-$latestfoo5-2.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Ekd" --text="Por favor espere...." --pulsate --auto-close --width=350

cat /dev/null > /tmp/ekd.txt
cat /dev/null > /tmp/lastest_ekd.txt
fi

if [ -f /usr/bin/ekd ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Ekd" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Ekd" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Ekd not installed, please try again"
fi

    }


ffmulticonverter(){

yum -y install ffmulticonverter | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing ffmulticonverter" --text="Please wait...." --pulsate --auto-close --width=350
 
 

if [ -f /usr/bin/ffmulticonverter ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de FF Multi Converter" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of FF Multi Converter" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason FF Multi Coverter not installed, please try again"
fi

    }

            
    gtkPod(){
            
yum -y install gtkpod | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando dependencias para GtkPod" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de GtkPod" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of GtkPod" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "GtkPod" >> installed.log
    }
     
    easyTag(){
            yum -y install easytag | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando EasyTag" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de EasyTag" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of EasyTag" -i "/usr/share/icons/pinguino.png" -t 5000'
fi 

            echo "EasyTag" >> installed.log
    }
     
    avidemux(){
            yum -y install avidemux | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Avidemux" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Avidemux" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Avidemux" -i "/usr/share/icons/pinguino.png" -t 5000'
fi 

            echo "Avidemux" >> installed.log
    }
     
    blender(){
            yum -y install blender | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Blender" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Blender" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Blender" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "Blender" >> installed.log
    }


    tupapi(){
            yum -y install tupi | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Tupi" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Tupi" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Tupi" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

            echo "Tupi" >> installed.log
    }



brlcad(){
yum -y localinstall http://sourceforge.net/projects/brlcad/files/BRL-CAD%20for%20Linux/7.20.6/brlcad-7.20.6-0.fedora.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando BRL-CAD" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/brlcad/bin/brlcad-config ]; then
$changelog
echo "BRL-CAD" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de BRL-CAD" -i "/usr/share/icons/pinguino.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="Por alguna razon BRL-CAD no esta instalado, vuelva a intentar "
fi

    }

     
    Sweet(){  
if [ -f /usr/share/applications/SweetHome3D.desktop ]; then
rm -f /usr/share/applications/SweetHome3D.desktop 
fi

if [ -f /usr/bin/sweethome3d.sh ]; then
rm -f /usr/bin/sweethome3d.sh 
fi

if [ -f /usr/bin/sweethome3d ]; then
rm -f /usr/bin/sweethome3d 
fi

if [ -d /home/$noti/.sweethome/ ]; then
rm -R /home/$noti/.sweethome/
fi

if [ -f /opt/SweetHome3D-linux-x64.tgz ]; then
rm -f /opt/SweetHome3D-linux-x64.tgz 
fi

        
xterm -e 'wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/SweetHome3DLogo.png'

xterm -e 'wget -c -P/usr/bin/ http://sourceforge.net/projects/postinstaller/files/scripts/sweethome3d.sh'

cd /tmp/
foo=$(w3m -dump http://sourceforge.net/projects/sweethome3d/files/SweetHome3D/); echo "foo=$foo" >> /tmp/sweethome.txt | sed -n -e '/SweetHome3D-/p' /tmp/sweethome.txt | more | awk '{print $1}' | head -1 >> /tmp/lastest_sweethome.txt 
wait ${!}

latestfoo=$(cat /tmp/lastest_sweethome.txt ); echo "latestfoo=$latestfoo"

        
cd /opt/ 

wget -c -O SweetHome3D-linux-x64.tgz http://sourceforge.net/projects/sweethome3d/files/SweetHome3D/$latestfoo/$latestfoo-linux-x64.tgz 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:SweetHome3D  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500 


wait ${!}


echo "[Desktop Entry]
Name=Sweet Home 3D
Terminal=false
Icon=/usr/share/icons/SweetHome3DLogo.png
Type=Application
Encoding=UTF-8
Categories=Graphics;
Exec=/usr/bin/sweethome3d.sh
Comment=Free interior design application that helps you place your furniture on a house 2D plan, with a 3D preview." >> /usr/share/applications/SweetHome3D.desktop 

chmod a+x /usr/bin/sweethome3d.sh
chmod a+x /usr/share/applications/SweetHome3D.desktop
chmod a+rwx /opt/SweetHome3D-linux-x64.tgz

cat /dev/null > /tmp/sweethome.txt

cat /dev/null > /tmp/lastest_sweethome.txt


if [ -f /usr/bin/sweethome3d.sh ] && [ -f /opt/SweetHome3D-linux-x86.tgz ]; then
echo "Sweet Home 3D" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Sweet Home 3D" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Sweet Home 3D" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Sweet Home 3D not installed, please try again"
fi

    }
     
    libreCAD(){
if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) != "16" ]
then
yum -y install qt boost | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando dependencias para LibreCAD" --text="Por favor espere...." --pulsate --auto-close --width=350

wget -c -P/usr/local/ http://sourceforge.net/projects/postinstaller/files/Fedora%2017/librecad64.tar.gz 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:LibreCAD  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
cd /usr/local/
tar -xvzf librecad64.tar.gz
wait ${!}
cd librecad
cp -f /usr/local/librecad/bin/librecad /usr/bin/
cp -f /usr/local/librecad/share/applications/librecad.desktop /usr/share/applications/
cp -R /usr/local/librecad/share/librecad/ /usr/share/
cp -R /usr/local/librecad/share/applications/ /usr/share/
cp -R /usr/local/librecad/share/pixmaps/ /usr/share/
chmod a+x /usr/bin/librecad
chmod a+x /usr/share/applications/librecad.desktop
else 
yum -y install http://sourceforge.net/projects/rallaz.u/files/LibreCAD-1.0.1/Fedora_16/librecad-1.0.1-1.1.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando LibreCAD" --text="Por favor espere...." --pulsate --auto-close --width=350
fi   

if [ -f /usr/bin/librecad ]; then
$changelog
echo "Libre CAD" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de LibreCAD" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of LibreCAD" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason LibreCAD not installed, please try again"
fi

    }

freecad(){
yum -y install freecad | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando FreeCAD" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/FreeCAD ]; then
$changelog
echo "FreeCAD" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de FreeCAD" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of FreeCAD" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason FreeCAD not installed, please try again"
fi

    }


Draft(){
yum -y localinstall http://dl-ak.solidworks.com/nonsecure/draftsight/V1R2.0/draftSight.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando DraftSight" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/draftsight ]; then
$changelog
echo "DraftSight" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de DraftSight" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of DraftSight" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason DraftSight not installed, please try again"
fi 

    }

     
    inkscape(){
            yum -y install inkscape | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Inkscape" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Inkscape" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Inkscape" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
           
            echo "Inkscape" >> installed.log
    }

     
    openshot(){
            yum -y install blender | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Blender como complemento a Openshot" --text="Por favor espere...." --pulsate --auto-close --width=350

 yum -y install inkscape | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Inkscape como complemento a Openshot" --text="Por favor espere...." --pulsate --auto-close --width=350

 yum -y install openshot | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Openshot" --text="Por favor espere...." --pulsate --auto-close --width=350

su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Openshot" -i "/usr/share/icons/pinguino.png" -t 5000'

echo "Inkscape" >> installed.log
echo "Blender" >> installed.log
echo "Openshot" >> installed.log

    }

kden(){
            yum -y install kdenlive | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Kdenlive" --text="Por favor espere...." --pulsate --auto-close --width=350

$changelog
echo "Kdenlive" >> installed.log

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Kdenlive" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Kdenlive" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

    }


lives(){
            

 yum -y install lives | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Lives" --text="Por favor espere...." --pulsate --auto-close --width=350



if [ -f /usr/bin/lives ]; then
$changelog
echo "LIVES" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de LIVES" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of LIVES" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason LIVES not installed, please try again"
fi

    }


imagination(){
            yum -y install imagination | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Imagination" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Imagination" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Imagination" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Imagination" >> installed.log

    }


deveDe(){
            yum -y install devede | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando DeveDe" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de DeveDe" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of DeveDe" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "DeveDe" >> installed.log

    }


dVDStyler(){
            yum -y install dvdstyler | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando DVDStyler" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de DVDStyler" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of DVDStyler" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "DVDStyler" >> installed.log

    }


ffaporama(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "20" ]; then
zenity --info --title="PostInstallerF" --text="ffDiaporama is no yet avaiable for Fedora 19, please try other day sorry"         
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "17" ]
then
xterm -e 'yum -y localinstall http://ffdiaporama.tuxfamily.org/download.php?f=Stable/1.3_20120627/ffDiaporama-1.3.2012.0627-0.fc17.x86_64.rpm'
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]
then
xterm -e 'yum -y localinstall http://ffdiaporama.tuxfamily.org/download.php?f=Stable/1.3_20120526/ffDiaporama-1.3.2012.0526-0.fc16.x86_64.rpm'
else
yum -y install ffdiaporama | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing ffDiaporama" --text="Please wait...." --pulsate --auto-close --width=350
fi

if [ -f /usr/bin/ffDiaporama ]; then
$changelog
echo "ffDiaporama" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de ffDiaporama" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of ffDiaporama" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason ffDiaporama not installed, please try again"
fi

    }


wnk(){
            
yum -y install wink | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Wink" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/wink ]; then
$changelog
echo "Wink" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Wink" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Wink" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Wink not installed, please try again"
fi

    }


Virtual(){
            yum -y install darktable | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Virtual Lighttable and Darkroom" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Virtual Lighttable and Darkroom" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Virtual Lighttable and Darkroom" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Virtual Lighttable and Darkroom" >> installed.log

    }


GnomeSubtitles(){
            yum -y install gnome-subtitles | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Gnome Subtitles" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Gnome Subtitles" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Gnome Subtitles" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Gnome Subtitles" >> installed.log

    }


vlc(){
            yum -y install vlc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Vlc Media Player" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de VLC media player" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of VLC media player" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "VLC media player" >> installed.log

    }

flix(){

if [ -f /tmp/Netflixplayer.tar.gz ]; then
rm -f /tmp/Netflixplayer.tar.gz
fi

if [ -f /opt/Netflixplayer.tar.gz ]; then
rm -f /opt/Netflixplayer.tar.gz
fi

if [ -f /tmp/Netflix.sh ]; then
rm -f /tmp/Netflix.sh
fi

if [ -f /opt/Netflix.sh ]; then
rm -f /opt/Netflix.sh
fi

yum -y install netflix-desktop | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Netflix-Desktop" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/netflix-desktop ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Netflix Player" -i "/opt/Netflix/netflix.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Netflix Player" -i "/opt/Netflix/netflix.png" -t 5000'
fi
 else
zenity --info --title="PostInstallerF" --text="For some reason Netflix Player not installed, please try again"
fi

    }


xbm(){

if [ -f /tmp/addonsxbmc.tar.gz ]; then
rm -f /tmp/addonsxbmc.tar.gz
fi

            yum -y install xbmc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando XBMC" --text="Por favor espere...." --pulsate --auto-close --width=350


if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de XBMC" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of XBMC" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "XBMC" >> installed.log

    }


clementine(){
            yum -y install qtwebkit clementine | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Clementine" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Clementine" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Clementine" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Clementine" >> installed.log

    }


sound(){
            yum -y install soundconverter | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Sound Converter" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Sound converter" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Sound converter" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Sound converter" >> installed.log

    }


audacity(){
            yum -y install audacity | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Audacity" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Audacity" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Audacity" -i "/usr/share/icons/pinguino.png" -t 5000'
fi


echo "Audacity" >> installed.log

    }


ocenaudio(){
            yum -y localinstall http://www.ocenaudio.com.br/downloads/ocenaudio64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando OcenAudio" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de OcenAudio" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of OcenAudio" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "OcenAudio" >> installed.log

    }


mix(){
            yum -y install mixxx | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Mixxx" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Mixxx" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Mixxx" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Mixxx" >> installed.log

    }



skype(){
            yum -y install skype | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Skype" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/skype ]; then
$changelog
echo "SKYPE" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de SKYPE" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of SKYPE" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason SKYPE not installed, please try again"
fi


    }


jitsi(){
            yum -y localinstall https://download.jitsi.org/jitsi/rpm/jitsi-2.2-latest.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Jitsi" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/jitsi ]; then
$changelog
echo "Jitsi" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Jitsi" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Jitsi" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Jitsi not installed, please try again"
fi


    }

turpial(){
            yum -y install turpial | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Turpial" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Turpial" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Turpial" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Turpial" >> installed.log

    }


gwibber(){
            yum -y install gwibber | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Gwibber" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Gwibber" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Gwibber" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Gwibber" >> installed.log

    }


bible(){
            yum -y install bibletime | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Bible Time" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Bible Time" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Bible Time" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Bible Time" >> installed.log

    }


tuxpaint(){
            yum -y install tuxpaint | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Tuxpaint" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Tuxpaint" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Tuxpaint" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Tuxpaint" >> installed.log

    }


Stellar(){
            yum -y install stellarium | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Stellarium" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Stellarium" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Stellarium" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Stellarium" >> installed.log

    }


celestia(){
            yum -y install celestia | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Celestia" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Celestia" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Celestia" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Celestia" >> installed.log

    }


Earth(){
            yum -y localinstall http://dl.google.com/dl/earth/client/current/google-earth-stable_current_x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Google Earth" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /opt/google/earth/free/googleearth ]; then
$changelog
echo "Google Earth" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Google Earth" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Google Earth" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Google Earth not installed, please try again"
fi


    }


gcompris(){
            yum -y install gcompris | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Gcompris" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Gcompris" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Gcompris" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Gcompris" >> installed.log

    }


tuxMath(){
            yum -y tuxmath | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando TuxMath" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de TuxMath" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of TuxMath" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "TuxMath" >> installed.log

    }


tuxType(){
            yum -y install tuxtype2 | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando TuxType" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de TuxType" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of TuxType" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "TuxType" >> installed.log

    }


childsplay(){
            yum -y install childsplay | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Childsplay" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Childsplay" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Childsplay" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Childsplay" >> installed.log

    }


scratch(){
            yum -y localinstall http://info.scratch.mit.edu/sites/infoscratch.media.mit.edu/files/file/scratch-1.4.0.1-1.i386.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Scratch" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/scratch ]; then
$changelog
echo "Scratch" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Scratch" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Scratch" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Scratch not installed, please try again"
fi

    }


ri(){
            yum -y install Ri-li | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Ri-li" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Ri-li" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Ri-li" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Ri-li" >> installed.log

    }


Frozen(){
            yum -y install frozen-bubble | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Frozen Bubble" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Frozen Bubble" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Frozen Bubble" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Frozen Bubble" >> installed.log

    }


Extreme(){
            yum -y install extremetuxracer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Extreme Tux Racer" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Extreme Tux Racer" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Extreme Tux Racer" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Extreme Tux Racer" >> installed.log

    }


Super(){
            yum -y install supertuxkart | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Super Tux Kart" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Extreme Super Tux Kart" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Extreme Super Tux Kart" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Super Tux Kart" >> installed.log

    }



wormux(){
            yum -y install wormux | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Wormux" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Wormux" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Wormux" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Wormux" >> installed.log

    }


tremulous(){
            yum -y install tremulous | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Tremulous" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Tremulous" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Tremulous" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Tremulous" >> installed.log

    }


Methane(){
            yum -y install methane | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Super Methane Brothers" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Super Methane Brothers" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Super Methane Brothers" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Super Methane Brothers" >> installed.log

    }


pingus(){
            yum -y install pingus | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Pingus" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Pingus" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Pingus" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Pingus" >> installed.log

    }


hedgewars(){
             yum -y install hedgewars | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Hedgewars" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Hedgewars" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Hedgewars" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Hedgewars" >> installed.log

    }


glaxium(){
            yum -y install glaxium | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Glaxium" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Glaxium" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Glaxium" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Glaxium" >> installed.log

    }


amoebax(){
            yum -y install amoebax | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Amoebax" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Amoebax" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Amoebax" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Amoebax" >> installed.log

    }


AlienArena(){
            yum -y install alienarena | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Alien Arena" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Alien Arena" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Alien Arena" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Alien Arena" >> installed.log

    }


tORCS(){
            yum -y install torcs | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando TORCS" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de TORCS" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of TORCS" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "TORCS" >> installed.log

    }


flightGear(){
            yum -y install FlightGear | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando FlightGear" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de FlightGear" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of FlightGear" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "FlightGear" >> installed.log

    }


perfo(){

yum -y install performous | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Performous" --text="Por favor espere...." --pulsate --auto-close --width=350 

if [ -f /usr/bin/performous ]; then  
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Performous" -i "/usr/share/icons/pinguino.png" -t 5000'
else         
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Performous" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
echo "Performous" >> installed.log
 else
zenity --info --title="PostInstallerF" --text="For some reason Performous not installed, please try again"
fi


    }


stea(){

if [ -f /tmp/steam*.rpm ]; then
rm -f /tmp/steam*.rpm
fi

if [ -f /etc/yum.repos.d/steam.repo ]; then
echo 'exist repository steam'
else
echo '[steam]
name=Steam RPM packages (and dependencies) for Fedora
baseurl=http://spot.fedorapeople.org/steam/fedora-$releasever/
enabled=1
skip_if_unavailable=1
gpgcheck=0' >> /etc/yum.repos.d/steam.repo
fi 

wait ${!}

yum -y install steam | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Steam" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/steam ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Steam" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Steam" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else
zenity --info --title="PostInstallerF" --text="For some reason Steam not installed, please try again"
fi

    }


aqua(){

if [ -f /tmp/aquaria-beta3-installer.run ]; then
rm aquaria-beta3-installer.run
fi

wget -c -P/tmp/ http://icculus.org/aquaria/aquaria-beta3-installer.run  2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading: Aquaria  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500

wait ${!}

chmod a+x aquaria-beta3-installer.run 

su $noti -c xterm -e './aquaria-beta3-installer.run'

if [ -f /home/$noti/aquaria/aquaria ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Aquaria" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Aquaria" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
echo "Aquaria" >> installed.log
 else
zenity --info --title="PostInstallerF" --text="For some reason Aquaria not installed, please try again"
fi

    }


Gnutella(){
            yum -y install gtk-gnutella | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Gtk-Gnutella" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Gtk-Gnutella" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Gtk-Gnutella" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Gtk-Gnutella" >> installed.log

    }


grooveDown(){
rm -f /usr/share/applications/GrooveDown.desktop
rm -rf /usr/share/GrooveDown/
rm -R /usr/local/bin/GrooveDown/
rm -f /usr/local/bin/GrooveDown/GrooveDown.sh
rm -rf /home/$noti/.GroveDown/
rm -f /opt/Groovedown.zip

yum -y install groovedown | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing GroveDown" --text="Please wait...." --pulsate --auto-close --width=350



if [ -f /usr/bin/groovedown ]; then
$changelog
echo "GrooveDown" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de GrooveDown" -i "/usr/share/icons/gd_logo.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of GrooveDown" -i "/usr/share/icons/gd_logo.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason GrooveDown not installed, please try again"
fi

    }


veOff(){

echo '[home_gcala]
name=gcala Home Project
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/gcala/Fedora_$releasever/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/home:/gcala/Fedora_$releasever/repodata/repomd.xml.key
enabled=1
skip_if_unavailable=1' >> /etc/yum.repos.d/home:gcala.repo

yum -y install http://download.opensuse.org/repositories/home:/gcala/Fedora_18/x86_64/grooveoff-0.1.1-20.1.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing GrooveOff" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/grooveoff ]; then
$changelog
echo "GrooveOff" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de GrooveOff" -i "/usr/share/icons/gd_logo.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of GrooveOff" -i "/usr/share/icons/gd_logo.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason GrooveOff not installed, please try again"
fi

    }


wirefro(){

rm -f /usr/share/applications/Frostwire.desktop
rm -rf /home/$noti/.frostwire/
rm -f /usr/bin/frostwirelauch.sh
rm -f /opt/frostwire.tar.gz

yum -y install frostwire | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Frostwire" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/frostwire ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Frostwire" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Frostwire" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Frostwire not installed, please try again"
fi
    }


uget(){
            yum -y install uget | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando UGET" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de UGET" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of UGET" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "UGET" >> installed.log

    }


flare(){
            yum -y install http://www.flareget.com/files/flareget/rpms/amd64/flareget-1.4-7.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing FlareGet" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/flareget ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de FlareGet" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of FlareGet" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason FlareGet not installed, please try again"
fi

    }


tucan(){
            yum -y install tucan | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Tucan Manager" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Tucan Manager" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Tucan Manager" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Tucan Manager" >> installed.log

    }


YumExtender(){
            yum -y install yumex | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Yum Extender" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Yum Extender" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Yum Extender" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Yum Extender" >> installed.log

    }


blue(){
            yum -y install blueman | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Blueman" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Blueman" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Blueman" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "Blueman" >> installed.log

    }


Chrome(){
            yum -y localinstall https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Google-Chrome" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /opt/google/chrome/google-chrome ]; then
$changelog
echo "Google-Chrome" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Google-Chrome" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Google-Chrome" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Google-Chrome not installed, please try again"
fi


    }


chromium(){
            
 yum -y install chromium | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Chromium" --text="Por favor espere...." --pulsate --auto-close --width=350   

if [ -f /usr/lib/chromium/chromium-wrapper ]; then
$changelog
echo "Chromium" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Chromium" -i "/usr/share/icons/pinguino.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="Por alguna razon Navegador Chromium no esta instalado, vuelva a intentar "
fi

    }


opera(){
            yum -y install opera | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Navegador Opera" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/opera ]; then
$changelog
echo "Opera" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Navegador Opera" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Navegador Opera" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Opera not installed, please try again"
fi

    }


bleachBit(){
            yum -y install bleachbit | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando BleachBit" --text="Por favor espere...." --pulsate --auto-close --width=350

foo7=$(w3m -dump http://sourceforge.net/projects/bleachbit/files/bleachbit/); echo "foo7=$foo7" >> /tmp/bleachbit.txt | egrep '0.9.' /tmp/bleachbit.txt | awk '{print $1}' | head -1 >> /tmp/lastest_bleachbit.txt 
wait ${!}

latestfoo7=$(cat /tmp/lastest_bleachbit.txt ); echo "latestfoo7=$latestfoo7"

yum -y localinstall http://sourceforge.net/projects/bleachbit/files/bleachbit/$latestfoo7/bleachbit-$latestfoo7-1.1.fc17.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando BleachBit" --text="Por favor espere...." --pulsate --auto-close --width=350

cat /dev/null > /tmp/bleachbit.txt
cat /dev/null > /tmp/lastest_bleachbit.txt

if [ -f /usr/bin/bleachbit ]; then
$changelog
echo "BleachBit" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de BleachBit" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of BleachBit" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Bleachbit not installed, please try again"
fi

    }


GnomeTweak(){
            yum -y install python-devel gnome-tweak-tool dconf-editor gconf-editor | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando GnomeTweakTool y dconf-editor" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de GnomeTweakTool y dconf-editor" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of GnomeTweakTool y dconf-editor" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

echo "GnomeTweakTool y dconf-editor" >> installed.log

    }

mlibre(){
            yum -y install menulibre | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Menu Libre" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/menulibre ]; then
$changelog
echo "Menu Libre" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Menu Libre" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Menu Libre" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Menu Libre not installed, please try again"
fi

    }

pendientes(){
            yum-complete-transaction -y | pv -en 2>&1 | zenity --progress --title "Completando Instalaciones pendientes" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completado Instalaciones pendientes" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Completed Installations pending" -i "/usr/share/icons/pinguino.png" -t 5000'
fi

    }


bitdefender(){
          
yum -y localinstall http://download.bitdefender.com/repos/rpm/bitdefender/x86_64/bitdefender-scanner-7.6-3.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Bitdefender Antivirus- scanner" --text="Please wait...." --pulsate --auto-close --width=350


yum -y localinstall http://download.bitdefender.com/repos/rpm/bitdefender/x86_64/bitdefender-scanner-gui-1.0-3.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Bitdefender Antivirus- scanner gui" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /opt/BitDefender-scanner/bin/bdgui ] || [ -f /opt/BitDefender-scanner/bin/bdscan ]; then
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Bitdefender" -i "/usr/share/icons/pinguino.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Bitdefender" -i "/usr/share/icons/pinguino.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Bitdefender not installed, please try again"
fi

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



    }


hardinfo(){
            yum -y install hardinfo | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Hardinfo" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Hardinfo" -i "/usr/share/icons/sistema.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Hardinfo" -i "/usr/share/icons/sistema.png" -t 5000'
fi

echo "Hardinfo" >> installed.log

    }


batti(){
            yum -y install batti | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Batti" --text="Por favor espere...." --pulsate --auto-close --width=350
echo "@batti" >> /etc/xdg/lxsession/LXDE/autostart
exec /usr/bin/batti

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Batti" -i "/usr/share/icons/sistema.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Batti" -i "/usr/share/icons/sistema.png" -t 5000'
fi

echo "Batti" >> installed.log

    }


alien(){
             yum -y localinstall http://sourceforge.net/projects/postinstaller/files/data/alien-8.86-1.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Alien" --text="Por favor espere...." --pulsate --auto-close --width=350

if [ -f /usr/bin/alien ]; then
$changelog
echo "Alien" >> installed.log
if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Alien" -i "/usr/share/icons/sistema.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Alien" -i "/usr/share/icons/sistema.png" -t 5000'
fi
 else 
zenity --info --title="PostInstallerF" --text="For some reason Alien not installed, please try again"
fi

    }


truetype(){
            if [ -d /usr/share/fonts/msttcorefonts ]; then
zenity --info --title="PostInstallerF" --text="Ya tenes instalado Microsoft TrueType core fonts, nada que hacer"
else
yum -y localinstall http://sourceforge.net/projects/postinstaller/files/fuduntu/msttcorefonts-2.0-2.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Microsoft TrueType core fonts" --text="Por favor espere...." --pulsate --auto-close --width=350
fi

if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "PostInstallerF" "Completada la instalacion de Microsoft TrueType core fonts" -i "/usr/share/icons/sistema.png" -t 5000'
else
su $noti -c 'notify-send "PostInstallerF" "Has been completed installation of Microsoft TrueType core fonts" -i "/usr/share/icons/sistema.png" -t 5000'
fi


    }



cleanlog(){
            cat /dev/null > /usr/share/.postinstallerf/installed.log

su $noti -c 'notify-send "PostInstallerF" "Se ha realizado el reset de PostInstallerF" -i "/usr/share/icons/sistema.png" -t 5000'

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

    #variables deteccion JRE o JDK java Oracle
    versionjava=$(rpm -qi jre | sed -n '2p' | cut -b1-40); echo "versionjava=$versionjava"
    versionjkd=$(head -1 /usr/java/latest/release); echo "versionjdk=$versionjdk"


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
       if [ $(echo $LANG | cut -b1-2) = "es" ]; then
su $noti -c 'notify-send "Terminado!" "Todo está completado" -i "/usr/share/icons/pinguino.png" -t 10000'
else
       su $noti -c 'notify-send "Finish!" "All tasks were completed" -i "/usr/share/icons/pinguino.png" -t 10000'
fi
       
            
    fi

     
    exit 0
