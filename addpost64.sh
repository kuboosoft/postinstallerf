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
# FEDORA 17, 18, 19 ADPOST 1.2 64 BITS

# Updating Adpost
updater=/usr/share/updatepostintaller/addpost64.sh
if [ -f $updater ]; then
rm -f /usr/share/updatepostintaller/addpost64.sh
echo "Deleteing obselete version, and Updating"
else
echo "Up to date"
fi

if [ -d /usr/share/updatepostintaller/ ]; then
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/addpost64.sh'
else
mkdir /usr/share/updatepostintaller/
xterm -e 'wget -c -P/usr/share/updatepostintaller/ https://raw.github.com/kuboosoft/postinstallerf/master/addpost64.sh'
fi 

source=/usr/bin/postinstallerf/addpost64.sh
update=/usr/share/updatepostintaller/addpost64.sh

diff -a $source $update
if [ $? -eq 0 ]; then
    echo "The files are equal"
    zenity --info --text "Install is updated" --title "PostInstallerF" --timeout=5
else
    echo "The files are not equal"
    cp -f /usr/share/updatepostintaller/addpost64.sh /usr/bin/postinstallerf/ 
    zenity --info --text "Install was updated
    Please Restart Install" --title "PostInstallerF" --timeout=5
fi



# +--------------------------------------------------------------------------------------------------+
# |Here starts the menu.                                                                             |
# +--------------------------------------------------------------------------------------------------+

    generateInstallMenu(){ 
            im="yad --image="/usr/share/icons/acciones/add.png" --image-on-top --class="Install" --window-icon="/usr/share/icons/acciones/add.png" --list --checklist  --width=700 --height=500 --title \"PostInstallerF for Fedora 64bit (Ver 1.2.0)\" --text \"Select items from the list below\" "
            im=$im"--column=\"\" --column \"Application\" --column \"Description\"    --column \"Status\"                           "

# Building Install Menu

# Building Install Menu
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

if ! $installed | grep "Dirty ffmpeg" > /dev/null; then
enableff='exclude=ffmpeg ffmpeg-devel ffmpeg-libs'; echo "enableff = $enableff"
dirtyff=$(grep 'exclude=ffmpeg ffmpeg-devel ffmpeg-libs'  /etc/yum.repos.d/postinstallerf.repo | tail -n 1); echo "dirtyff = $dirtyff" 

if [ "$dirtyff" = "$enableff" ]; then
                    im=$im"FALSE \"Dirty ffmpeg\"      \"ffmpeg with several extra codecs enabled [Recommended if you need to use several programs like winff, mvc and others converters]\" \"DISABLED  \"  "
else
im=$im"FALSE \"Dirty ffmpeg\"      \"ffmpeg with several extra codecs enabled [Recommended if you need to use several programs like winff, mvc and others converters]\" \"ENABLED  \"  "
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
im=$im"FALSE \"Unrar and p7zip\"                   \"Decompresses rar and 7zip files\" \"NO INSTALLED  \"  "
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

if [ -f /usr/java/latest/bin/java ]; then
                    im=$im"FALSE \"Java JRE Oracle\"           \"Propietary implementation of the Java programming language.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Java JRE Oracle\"           \"Propietary implementation of the Java programming language.\" \"NO INSTALLED  \"  "
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
if [ -f /usr/local/mmc ]; then
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
im=$im"FALSE \"EasyTag\"              \"Utility for viewing, editing and writing ID3 tags of your MP3 files.\" \"INSTALLED  \"  "
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


if ! $installed | grep "Frostwire" > /dev/null; then
if [ -f /usr/bin/frostwire ]; then
                    im=$im"FALSE \"Frostwire\"    \"FrostWire is a free, open source BitTorrent client.\" \"INSTALLED  \"  "
else
im=$im"FALSE \"Frostwire\"    \"FrostWire is a free, open source BitTorrent client.\" \"NO INSTALLED  \"  "
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

            if echo $choice | grep "Dirty ffmpeg" > /dev/null; then
                    fdirty
            fi

            if echo $choice | grep "Flash Player" > /dev/null; then
                    flash
            fi
            if echo $choice | grep "Unrar and p7zip" > /dev/null; then
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


          if echo $choice | grep "Wine and winetricks" > /dev/null; then
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


if echo $choice | grep "GnomeTweakTool and dconf-editor" > /dev/null; then
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
                    echo "Installing dependency compat-libstdc++-33..."
                    yum -y install compat-libstdc++-33
                    echo "libstdc++-33" >> installed.log
            fi
    }
     
    extraRepos(){
            echo "Adding rpmfusion repositories..."  

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "16" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-16.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-16.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Repositorio RPMFusion" --text="Please wait...." --pulsate --auto-close --width=350
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "17" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-17.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-17.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Repositorio RPMFusion" --text="Please wait...." --pulsate --auto-close --width=350
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-18.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-18.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Repositorio RPMFusion" --text="Please wait...." --pulsate --auto-close --width=350
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-19.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-19.noarch.rpm 2>&1 | zenity --progress --title "Verifing and Adding RPM Fusion" --text="Please Wait...." --pulsate --auto-close --width=400
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "20" ]; then
yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-20.noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-20.noarch.rpm 2>&1 | zenity --progress --title "Verifing and Adding RPM Fusion" --text="Please Wait...." --pulsate --auto-close --width=400
fi

su $noti -c 'notify-send "PostInstallerF" "The installation of the repository RPMFusion has been completed" -i "/usr/share/icons/pinguino.png" -t 5000'
     

    }
     
    lenguaje(){
if [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "es" ]; then
yum -y install kde-l10n-Spanish | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing soporte español para KDE" --text="Please wait...." --pulsate --auto-close --width=350

elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "pt" ]; then
yum -y install kde-l10n-Portuguese | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalação de suporte para KDE Português" --text="Please wait...." --pulsate --auto-close --width=350


elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "fr" ]; then
yum -y install kde-l10n-French | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installation de soutien français pour KDE" --text="Please wait...." --pulsate --auto-close --width=350



elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "ja" ]; then
yum -y install kde-l10n-Japanese | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "KDE用日本語サポートのインストール" --text="Please wait...." --pulsate --auto-close --width=350



elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "zh" ]; then
yum -y install kde-l10n-Chinese | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "安装中国支持KDE" --text="Please wait...." --pulsate --auto-close --width=350



elif [ -x /usr/share/doc/kdesdk* ] && [ $(echo $LANG | cut -b1-2) = "it" ]; then
yum -y install kde-l10n-Italian | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installazione del il supporto per KDE italiana" --text="Please wait...." --pulsate --auto-close --width=350
fi

yum -y install system-config-language 2>&1 | zenity --progress --title "Installing the Administration language." --text="Please wait...." --pulsate --auto-close --width=350


system-config-language

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Administrador de Lenguaje" -i "/usr/share/icons/pinguino.png" -t 5000'


    }
     
    basicompile(){
            yum -y install kernel-headers kernel-devel hg git | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing kernel-headers, devel, hg and git" --text="Please wait...." --pulsate --auto-close --width=350
 
 yum -y groupinstall "Development Tools" "Legacy Software Development" | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Development Tools and Legacy Software Development" --text="Please wait...." --pulsate --auto-close --width=350

yum -y groupinstall "Development Libraries" | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Development Libraries..." --text="Please wait...." --pulsate --auto-close --width=350

yum -y groupinstall "x-software-development" | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing x-software-development..." --text="Please wait...." --pulsate --auto-close --width=350

$changelog
echo "Compiling Basic Tools" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "Completed the installation of the basic tools." -i "/usr/share/icons/pinguino.png" -t 5000'

    }


    zorrito(){
            yum -y install firefox | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Mozilla Firefox" --text="Please wait...." --pulsate --auto-close --width=350

$changelog
echo "Mozilla Firefox" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "Completed installing Mozilla Firefox" -i "/usr/share/icons/pinguino.png" -t 5000'


    }

     
    multimediaCodecs(){

            yum -y install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing audio and video codecs" --text="Please wait...." --pulsate --auto-close --width=350

yum -y install ffmpeg mencoder ffmpeg2theora mplayer libdvdcss  | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing audio and video codecs" --text="Please wait...." --pulsate --auto-close --width=350

yum -y install gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing codecs de video y audio extras" --text="Please wait...." --pulsate --auto-close --width=350

yum -y install faac vo-aacenc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing encoders of video extras" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/k3b ]; then
yum -y install k3b-extras-freeworld | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing k3b Extras Freeworld" --text="Please wait...." --pulsate --auto-close --width=350
fi
             
            $changelog
            echo "Multimedia codecs" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "Completed the installation of the media codecs" -i "/usr/share/icons/pinguino.png" -t 5000'

    }

    fdirty(){

enableff='exclude=ffmpeg ffmpeg-devel ffmpeg-libs'; echo "enableff = $enableff"
dirtyff=$(grep 'exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/postinstallerf.repo | tail -n 1); echo "dirtyff = $dirtyff" 
disable=""

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
zenity --info --title="PostInstallerF" --text="Dirty ffmpeg is no yet avaiable for Fedora 19, please try again later, sorry."
else

if [ "$dirtyff" = "$enableff" ]; then 
zenity --question --title="Detected disabled Dirty ffmpeg" --text="Do you want enable Dirty ffmpeg?" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then
grep 'exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/rpmfusion-free.repo
if [[ "$?" != 0 ]]; then
sed -i '8i exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/rpmfusion-free.repo
sed -i '28i exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/rpmfusion-free.repo
 fi

grep 'exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/rpmfusion-free-updates.repo
if [[ "$?" != 0 ]]; then
sed -i '8i exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/rpmfusion-free-updates.repo
sed -i '22i exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/rpmfusion-free-updates.repo
fi
sed -i '/exclude=ffmpeg ffmpeg-devel ffmpeg-libs/d' /etc/yum.repos.d/postinstallerf.repo
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Has been enabled Dirty ffmpeg" 
else
echo 'thanks 2'
fi


elif [ "$dirtyff" != "$enableff" ]; then 
zenity --question --title="Detected enable Dirty ffmpeg" --text="Do you want disable Dirty ffmpeg?" --ok-label "Yes" --cancel-label "No"
if [[ $? -eq 0 ]]; then
sed -i '8i exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/postinstallerf.repo
sed -i '30i exclude=ffmpeg ffmpeg-devel ffmpeg-libs' /etc/yum.repos.d/postinstallerf.repo
sed -i '/exclude=ffmpeg ffmpeg-devel ffmpeg-libs/d' /etc/yum.repos.d/rpmfusion-free.repo
sed -i '/exclude=ffmpeg ffmpeg-devel ffmpeg-libs/d' /etc/yum.repos.d/rpmfusion-free-updates.repo
yad --class="ATTENTION" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/acciones/topicon.png" --image-on-top --info --title="PostInstallerF" --text="Has been disabled Dirty ffmpeg"
else
echo 'thanks 1'
fi
fi

rpm -e --nodeps ffmpeg ffmpeg-devel ffmpeg-libs

yum -y install ffmpeg  | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Dirty ffmpeg" --text="Please Wait...." --pulsate --auto-close --width=350 



su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Dirty ffmpeg/RpmFusion" -i "/usr/share/icons/pinguino.png" -t 5000'


    }
     
    flash(){
            yum -y localinstall http://linuxdownload.adobe.com/linux/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm
yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Please wait...." --pulsate --auto-close --width=350
yum -y install flash-plugin | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing flash-plugin" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Flash Player" -i "/usr/share/icons/pinguino.png" -t 5000'


            echo "Flash Player" >> installed.log
    }
     
    comprimir(){
            yum -y install unrar p7zip p7zip-plugins | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing unrar and p7zip" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Unrar and p7zip" -i "/usr/share/icons/pinguino.png" -t 5000'


                    echo "Unrar and p7zip" >> installed.log
            
    }
     
    java(){
            yum -y install java icedtea-web | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Java OpenJDK" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Java OpenJDK" -i "/usr/share/icons/pinguino.png" -t 5000'

     
            echo "Java OpenJDK" >> installed.log
    }


jre(){

rm -f /tmp/jre-oraclejava.rpm
rm -f /etc/profile.d/java.sh

cd /tmp/

wget -c -O jre-oraclejava.rpm http://javadl.sun.com/webapps/download/AutoDL?BundleId=78696 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading: Java JRE Oracle  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500

yum -y install jre-oraclejava.rpm

cd /usr/lib64/mozilla/plugins/

ln -s /usr/java/latest/lib/amd64/libnpjp2.so

echo 'PATH=/usr/java/latest/bin:$PATH' >> /etc/profile.d/java.sh


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Java JRE Oracle" -i "/usr/share/icons/pinguino.png" -t 5000'

     
    }
     
    gimp(){
            yum -y install gimp | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing GIMP" --text="Please wait...." --pulsate --auto-close --width=350

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : GIMP" -i "/usr/share/icons/pincel_rco.png" -t 5000'

           
            echo "GIMP" >> installed.log
    }


    hugp(){
            yum -y install hugin | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Hugin" --text="Please wait...." --pulsate --auto-close --width=350

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Hugin" -i "/usr/share/icons/pincel_rco.png" -t 5000'
         
            echo "Hugin" >> installed.log
    }


     converseen(){
            yum -y install converseen | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Converseen" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Converseen" -i "/usr/share/icons/pincel_rco.png" -t 5000'

           
            echo "Converseen" >> installed.log
    }

     
    mipaint(){
            yum -y install mypaint | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing MyPaint" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : MyPaint" -i "/usr/share/icons/pincel_rco.png" -t 5000'

     
            echo "MyPaint" >> installed.log
    }


    pint(){
            yum -y install pinta | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Pinta" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Pinta" -i "/usr/share/icons/pincel_rco.png" -t 5000'

     
            echo "Pinta" >> installed.log
    }


    pencil(){
            yum -y --enablerepo=updates-testing install pencil | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Pencil" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Pencil" -i "/usr/share/icons/pincel_rco.png" -t 5000'

     
            echo "Pencil" >> installed.log
    }

     
    fotoxx(){
            yum -y install fotoxx | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Fotoxx" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Fotoxx" -i "/usr/share/icons/camera.png" -t 5000'

     
            echo "Fotoxx" >> installed.log
    }
     
    shutter(){
            yum -y install shutter | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Shutter" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Shutter" -i "/usr/share/icons/camera.png" -t 5000'

     
            echo "Shutter" >> installed.log
    }
     
    glabels(){
            yum -y install glabels | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Glabels" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Glabels" -i "/usr/share/icons/pinguino.png" -t 5000'


            echo "Glabels" >> installed.log
    }
     
    kover(){
            yum -y install kover | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Kover" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Kover" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "Kover" >> installed.log
    }
     
    office(){
            yum -y install libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-draw libreoffice-langpack-es | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing LibreOffice" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : LibreOffice" -i "/usr/share/icons/pinguino.png" -t 5000'

     
            echo "LibreOffice" >> installed.log
    }

    basquet(){ 

yum -y install basket | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Basket" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/basket ]; then
$changelog
echo "Basket" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Basket" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Basket is not installed, please try again."
fi

     
            
    }

    caligra(){
            yum -y install calligra | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Calligra" --text="Please wait...." --pulsate --auto-close --width=350
 

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : LibreOffice" -i "/usr/share/icons/pinguino.png" -t 5000'

     
            echo "LibreOffice" >> installed.log
    }

    project(){

foo3=$(w3m -dump http://sourceforge.net/projects/projectlibre/files/ProjectLibre/); echo "foo3=$foo3" >> /tmp/projectlibre.txt
wait ${!}
egrep '1.' /tmp/projectlibre.txt | sed '1d' | awk '{print $1}' | head -1 >> /tmp/lastest_projectlibre.txt

latestfoo3=$(cat /tmp/lastest_projectlibre.txt ); echo "latestfoo3=$latestfoo3"

yum -y localinstall http://sourceforge.net/projects/projectlibre/files/ProjectLibre/$latestfoo3/projectlibre-$latestfoo3-1.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing ProjectLibre" --text="Please wait...." --pulsate --auto-close --width=350

cat /dev/null > /tmp/projectlibre.txt
cat /dev/null > /tmp/lastest_projectlibre.txt

if [ -f /usr/bin/projectlibre ]; then
$changelog

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : ProjectLibre" -i "/usr/share/icons/pinguino.png" -t 5000'
 else
     xterm -e 'yum -y install http://sourceforge.net/projects/projectlibre/files/ProjectLibre/1.5.4/projectlibre-1.5.4-1.rpm'
if [ -f /usr/bin/projectlibre ]; then
$changelog

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : ProjectLibre" -i "/usr/share/icons/pinguino.png" -t 5000'
 fi
fi

    }

     
    reader(){
            yum -y localinstall http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Please wait...." --pulsate --auto-close --width=350

 yum -y install nspluginwrapper AdobeReader_enu | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Adobe Reader" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Adobe Reader" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "Adobe Reader" >> installed.log
    }
     
    pdfmod(){

yum -y install pdfmod | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing PDF Mod" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/pdfmod ]; then
$changelog
echo "PDF Mod" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : PDF Mod" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason PDF Mod is not installed, please try again"
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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : PDF Split and Merge" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason PDF Split is not installed, please try again"
fi

    }

yagsca(){
            yum -y install yagf | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing YAGF" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : YAGF" -i "/usr/share/icons/pinguino.png" -t 5000'


            echo "YAGF" >> installed.log
    }
     
    scribus(){
            yum -y install scribus | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Scribus" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Scribus" -i "/usr/share/icons/pinguino.png" -t 5000'


            echo "Scribus" >> installed.log
    }
     
    adia(){
            yum -y install dia | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Dia" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Dia" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "Dia" >> installed.log
    }
     
    gnu(){
            yum -y install gnumeric | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Gnumeric" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Gnumeric" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "Gnumeric" >> installed.log
    }
     
    planner(){
            yum -y install planner | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Planner" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Planner" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "Planner" >> installed.log
    }
     
    vym(){
            yum -y install vym | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing VYM" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : VYM" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "VYM" >> installed.log
    }
     
    freemind(){
            yum -y install freemind | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Freemind" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Freemind" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "Freemind" >> installed.log
    }


yEdt(){
            yum -y install java | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Java como complemento" --text="Please wait...." --pulsate --auto-close --width=350

wget -c -P/tmp/ http://www.yworks.com/products/yed/demo/yEd-3.9.2_setup.sh 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading: yEd  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500

xterm -e 'sh /tmp/yEd-3.9.2_setup.sh'

if [ -f /opt/yEd/yEd ]; then

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : yEd" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "yEd" >> installed.log
else
zenity --info --title="PostInstallerF" --text="For some reason yEd is not installed, please try again"
fi
    }


cmap(){

yum -y install java glibc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Java y glib como dependencias" --text="Please wait...." --pulsate --auto-close --width=350

if [ -d /home/$noti/.local/share/applications/ ]; then
echo 'existe el directorio applications'
else
mkdir /home/$noti/.local/share/applications/
fi

if [ -f /home/$noti/.local/share/applications/CmapTools.desktop ]; then
rm -f /home/$noti/.local/share/applications/CmapTools.desktop
fi

wget -c -P/tmp/ http://cmapdownload.ihmc.us/installs/CmapTools/Linux/Linux64CmapTools_v5.05_08-07-12.bin 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading: Cmap Tools  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500

if [ -f /home/$noti/IHMC_CmapTools/bin/update ]; then
echo 'ya se encuentra instalado'
else
mkdir /home/$noti/IHMC_CmapTools/
mkdir /home/$noti/IHMC_CmapTools/bin/
echo "#!/bin/bash
sh /tmp/LinuxCmapTools_v5.05_08-07-12.bin" >> /home/$noti/IHMC_CmapTools/bin/update
fi

echo "[Desktop Entry]
Version=5.05
Type=Application
Terminal=false
Icon[en_US]=/usr/share/icons/cmap.png
Name[en_US]=CmapTools
Exec=/home/$noti/IHMC_CmapTools/bin/update
Comment[en_US]=video convert
Name=CmapTools
Comment=Make Concept Maps
Icon=/usr/share/icons/cmap.png
Categories=GTK;Graphics;" >> /home/$noti/.local/share/applications/CmapTools.desktop

chmod a+rwxs * /home/$noti/.local/share/applications/CmapTools.desktop
chmod a+rwxs * /home/$noti/IHMC_CmapTools/
chmod a+rwxs * /home/$noti/IHMC_CmapTools/*
chmod a+x /home/$noti/IHMC_CmapTools/bin/update

wget -c -P/usr/share/icons/ http://sourceforge.net/projects/postinstaller/files/Icons/cmap.png 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading: Cmap Tools icons  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
            

if [ -f /home/$noti/IHMC_CmapTools/bin/update ]; then

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Cmap Tools" -i "/usr/share/icons/pinguino.png" -t 5000'

 else
zenity --info --title="PostInstallerF" --text="For some reason Cmap Tools is not installed, please try again"
fi
    }

     
    anki(){
            yum -y install anki | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Anki" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Anki" -i "/usr/share/icons/pinguino.png" -t 5000'

            echo "Anki" >> installed.log
    }
     
     
    wine(){
            yum -y install wine cabextract | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Wine" --text="Please wait...." --pulsate --auto-close --width=350

 yum -y localinstall ftp://ftp.pbone.net/mirror/cachalot.mine.nu/RPMS/winetricks-20110429-0.fc15.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Winetricks" --text="Please wait...." --pulsate --auto-close --width=350

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Wine y winetricks" -i "/usr/share/icons/pinguino.png" -t 5000'

     
            echo "Wine y winetricks" >> installed.log
    }
     
    virtualbox(){

if [ -f '/tmp/LATEST.TXT' ]; then
rm -f /tmp/LATEST.TXT
fi

wget -c -P/tmp/ http://download.virtualbox.org/virtualbox/LATEST.TXT

lastest=$(cat /tmp/LATEST.TXT ); echo lastest=$lastest

if [ -f '/etc/yum.repos.d/virtualbox.repo' ]; then
yum -y install kernel-headers kernel-devel dkms gcc 2>&1 | zenity --progress --title "Installing dependencias de Virtualbox" --text="Please wait...." --pulsate --auto-close --width=350

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Please wait...." --pulsate --auto-close --width=350

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

yum -y install kernel-headers kernel-devel dkms gcc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing dependencias de Virtual Box" --text="Please wait...." --pulsate --auto-close --width=350

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Please wait...." --pulsate --auto-close --width=350

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
 fi

if [ -f "/etc/yum.repos.d/virtualbox.repo" ] && [ -f /usr/bin/VirtualBox ]; then
rm -f /tmp/Oracle_VM_VirtualBox_Extension_Pack-*.vbox-extpack
$changelog
echo "Oracle Virtual Box" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Oracle Virtual Box" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Oracle Virtual Box is not installed, please try again"
fi

    }
     
    play(){
            yum -y install wine cabextract | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Wine" --text="Please wait...." --pulsate --auto-close --width=350

 yum -y localinstall ftp://ftp.pbone.net/mirror/cachalot.mine.nu/RPMS/winetricks-20110429-0.fc15.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Winetricks" --text="Please wait...." --pulsate --auto-close --width=350 

yum -y --exclude=kernel* update | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/updatep.png" --image-on-top --progress --title "Actualizando nuevos repositorios" --text="Please wait...." --pulsate --auto-close --width=350


yum -y install playonlinux | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "PlayOnLinux" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/playonlinux ]; then
$changelog
echo "PlayOnLinux" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : PlayOnLinux" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason PlayOnLinux is not installed, please try again"
fi

    }
     
    
     
    team(){
            yum -y localinstall http://www.teamviewer.com/download/teamviewer_linux.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "TeamViewer" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /opt/teamviewer/teamviewer ]; then

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : TeamViewer" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason TeamViewer is not installed, please try again"
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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : DropBox" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Dropbox is not installed, please try again"
fi

    }

     
    Hyper(){

yum -y install hypervc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Hyper Video Converter" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/hypervc ]; then
$changelog
echo "Hyper Video Converter" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Hyper Video Converter" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Hyper Video Converter is not installed, please try again"
fi

    }



    mvcon(){

yum -y install mvc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Miro Video Converter" --text="Please wait...." --pulsate --auto-close --width=350

           
if [ -f /usr/bin/miro-video-converter.py ]; then
$changelog
echo "Miro Video Converter" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Miro Video Converter" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Miro Video Converter is not installed, please try again"
fi

    }

     
    arista(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
zenity --info --title="PostInstallerF" --text="Arista Transcoder is not compatible with Fedora 19, sorry"
elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "20" ]; then
zenity --info --title="PostInstallerF" --text="Arista Transcoder is not compatible with Fedora 20, sorry"
else
yum -y install arista | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Arista Transcoder" --text="Please Wait...." --pulsate --auto-close --width=350
           
if [ -f /usr/bin/arista-gtk ]; then
$changelog
echo "Arista Transcoder" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Arista Transcoder" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Arista Transcoder is not installed, please try again"
fi

fi

    }

    qwinf(){

yum -y install qwinff | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Qwinff" --text="Please Wait...." --pulsate --auto-close --width=350
           
if [ -f /usr/bin/qwinff ]; then
$changelog
echo "Qwinff" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Qwinff" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Qwinff is not installed, please try again"
fi

    }
     
    transcoder(){
if [ -f /usr/share/applications/Transcoder.desktop ] && [ -f /usr/local/bin/Transcoder/Transcoder ]; then
rm -f /usr/share/applications/Transcoder.desktop
else
echo "ya esta instalado"
fi
            yum -y install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg ffmpeg mencoder ffmpeg2theora mplayer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing codecs de video y audio" --text="Please wait...." --pulsate --auto-close --width=350
wait ${!}
cd /usr/local/bin/
wget -c -P/usr/local/bin/ http://sourceforge.net/projects/transcoder84/files/0.0.6/Transcoder_0.0.6_amd64.tar.gz 2>&1 |sed -un 's_^.* \([0-9]\+%\).* \([0-9.]\+[GMKB]\).*_#Downloading:Transcoder  [\1]Speed:.........[\2B]_p' |zenity --progress --pulsate --auto-close --width 500
cd /usr/local/bin/
tar -xvzf Transcoder_0.0.6_amd64.tar.gz 2>&1 | zenity --progress --title "Extrayendo e Installing Transcoder " --text="Please wait...." --pulsate --auto-close --width=350
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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Transcoder" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Transcoder is not installed, please try again"
fi

    }
     
    Mobilmedia(){

yum -y install mmc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Mobilmedia Converter" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/local/mmc ]; then
$changelog
echo "Mobilmedia Converter" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Mobilmedia Converter" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Mobilmedia Converter is not installed, please try again"
fi

    }
     
    yakiTo(){
yum -y install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg ffmpeg mencoder ffmpeg2theora mplayer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing codecs de video y audio" --text="Please wait...." --pulsate --auto-close --width=350

            yum -y install java | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Java OpenJDK" --text="Please wait...." --pulsate --auto-close --width=350

xterm -e 'curl -o yakito-0.1.2-linux.sh http://www.yakiboo.net/yakito/downloads/yakito-0.1.2-linux.sh' 
wait ${!} 
xterm -e 'sudo sh yakito-0.1.2-linux.sh'

if [ -f /usr/bin/yakito ]; then
$changelog
echo "YakiTo" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : YakiTo" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason YakiTo is not installed, please try again"
fi

    }


ekd(){


if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "18" ]; then

yum -y install ekd | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Ekd" --text="Please wait...." --pulsate --auto-close --width=350

elif [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
zenity --info --title="PostInstallerF" --text="Ekd is not compatible with Fedora 19, sorry"

else

yum -y install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg ffmpeg mencoder ffmpeg2theora mplayer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing codecs de video y audio" --text="Please wait...." --pulsate --auto-close --width=350

yum -y install mplayer mencoder ffmpeg2theora PyQt4 PyQt ImageMagick numpy python-imaging sox | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing dependencias para Ekd" --text="Please wait...." --pulsate --auto-close --width=350

foo5=$(w3m -dump http://sourceforge.net/projects/ekd/files/ekd/); echo "foo5=$foo5" >> /tmp/ekd.txt 

egrep '3.' /tmp/ekd.txt | sed '1,2d' | awk '{print $1}' | head -1 >> /tmp/lastest_ekd.txt

wait ${!}

latestfoo5=$(cat /tmp/lastest_ekd.txt ); echo "latestfoo5=$latestfoo5"

yum -y localinstall http://sourceforge.net/projects/ekd/files/ekd/$latestfoo5/GNU-Linux/ekd-$latestfoo5-2.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Ekd" --text="Please wait...." --pulsate --auto-close --width=350

cat /dev/null > /tmp/ekd.txt
cat /dev/null > /tmp/lastest_ekd.txt
fi

if [ -f /usr/bin/ekd ]; then

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Ekd" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Ekd is not installed, please try again"
fi

    }


ffmulticonverter(){


yum -y install ffmulticonverter | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing ffmulticonverter" --text="Please wait...." --pulsate --auto-close --width=350

 

if [ -f /usr/bin/ffmulticonverter ]; then

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : FF Multi Converter" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason FF Multi Coverter is not installed, please try again"
fi

    }

     
    gtkPod(){
            
yum -y install gtkpod | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing dependencias para GtkPod" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : GtkPod" -i "/usr/share/icons/pinguino.png" -t 5000'


            echo "GtkPod" >> installed.log
    }
     
    easyTag(){
            yum -y install easytag | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing EasyTag" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : EasyTag" -i "/usr/share/icons/pinguino.png" -t 5000'
 

            echo "EasyTag" >> installed.log
    }
     
    avidemux(){
            yum -y install avidemux | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Avidemux" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Avidemux" -i "/usr/share/icons/pinguino.png" -t 5000'


            echo "Avidemux" >> installed.log
    }
     
    blender(){
            yum -y install blender | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Blender" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Blender" -i "/usr/share/icons/pinguino.png" -t 5000'


            echo "Blender" >> installed.log
    }

    tupapi(){
            yum -y install tupi | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Tupi" --text="Please Wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Tupi" -i "/usr/share/icons/pinguino.png" -t 5000'


            echo "Tupi" >> installed.log
    }

brlcad(){
yum -y localinstall http://sourceforge.net/projects/brlcad/files/BRL-CAD%20for%20Linux/7.20.6/brlcad-7.20.6-0.fedora.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing BRL-CAD" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/brlcad/bin/brlcad-config ]; then
$changelog
echo "BRL-CAD" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : BRL-CAD" -i "/usr/share/icons/pinguino.png" -t 5000'
else 
zenity --info --title="PostInstallerF" --text="For some reason BRL-CAD is not installed, please try again"
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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Sweet Home 3D" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Sweet Home 3D is not installed, please try again"
fi

    }
     
    libreCAD(){

if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) != "16" ]
then
yum -y install qt boost | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando dependencias para LibreCAD" --text="Please Wait...." --pulsate --auto-close --width=350
 
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
yum -y install http://sourceforge.net/projects/rallaz.u/files/LibreCAD-1.0.1/Fedora_16/librecad-1.0.1-1.1.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando LibreCAD" --text="Please Wait...." --pulsate --auto-close --width=350
fi

wait ${!}

yum -y install librecad | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing LibreCAD" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/librecad ]; then
$changelog
echo "Libre CAD" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : LibreCAD" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason LibreCAD is not installed, please try again"
fi

    }


freecad(){
yum -y install freecad | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing FreeCAD" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/FreeCAD ]; then
$changelog
echo "FreeCAD" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : FreeCAD" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason FreeCAD is not installed, please try again"
fi

    }


    Draft(){
yum -y localinstall http://dl-ak.solidworks.com/nonsecure/draftsight/V1R2.0/draftSight.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing DraftSight" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/draftsight ]; then
$changelog
echo "DraftSight" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : DraftSight" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason DraftSight is not installed, please try again"
fi 

    }
  
     
    inkscape(){
            yum -y install inkscape | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Inkscape" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Inkscape" -i "/usr/share/icons/pinguino.png" -t 5000'

           
            echo "Inkscape" >> installed.log
    }
     
    openshot(){
            yum -y install blender | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Blender as complement a Openshot" --text="Please wait...." --pulsate --auto-close --width=350

 yum -y install inkscape | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Inkscape as complement a Openshot" --text="Please wait...." --pulsate --auto-close --width=350

 yum -y install openshot | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Openshot" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Openshot" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Inkscape" >> installed.log
echo "Blender" >> installed.log
echo "Openshot" >> installed.log

    }


kden(){
            yum -y install kdenlive | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Kdenlive" --text="Please wait...." --pulsate --auto-close --width=350
$changelog
echo "Kdenlive" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Kdenlive" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Kdenlive" >> installed.log

    }



lives(){
            yum -y install lives | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Lives" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/lives ]; then
$changelog
echo "LIVES" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : LIVES" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason LIVES is not installed, please try again"
fi

    }


imagination(){
            yum -y install imagination | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Imagination" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Imagination" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Imagination" >> installed.log

    }


deveDe(){
            yum -y install devede | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing DeveDe" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : DeveDe" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "DeveDe" >> installed.log

    }


dVDStyler(){
            yum -y install dvdstyler | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing DVDStyler" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : DVDStyler" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "DVDStyler" >> installed.log

    }


ffaporama(){
if [ $(rpm -q --queryformat '%{VERSION}\n' fedora-release) = "19" ]; then
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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : ffDiaporama" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason ffDiaporama is not installed, please try again"
fi

    }


wnk(){
            
yum -y install wink | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Wink" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/wink ]; then
$changelog
echo "Wink" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Wink" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Wink is not installed, please try again"
fi

    }


Virtual(){
            yum -y install darktable | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Virtual Lighttable and Darkroom" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Virtual Lighttable and Darkroom" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Virtual Lighttable and Darkroom" >> installed.log

    }


GnomeSubtitles(){
            yum -y install gnome-subtitles | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Gnome Subtitles" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Gnome Subtitles" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Gnome Subtitles" >> installed.log

    }


vlc(){
            yum -y install vlc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Vlc Media Player" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : VLC media player" -i "/usr/share/icons/pinguino.png" -t 5000'


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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Netflix Player" -i "/opt/Netflix/netflix.png" -t 5000'

 else
zenity --info --title="PostInstallerF" --text="For some reason Netflix Player is not installed, please try again"
fi


    }


xbm(){

if [ -f /tmp/addonsxbmc.tar.gz ]; then
rm -f /tmp/addonsxbmc.tar.gz
fi

            yum -y install xbmc | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing XBMC" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : XBMC" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "XBMC" >> installed.log

    }


clementine(){
            yum -y install qtwebkit clementine | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Clementine" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Clementine" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Clementine" >> installed.log

    }


sound(){
            yum -y install soundconverter | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Sound Converter" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Sound converter" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Sound converter" >> installed.log

    }


audacity(){
            yum -y install audacity | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Audacity" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Audacity" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Audacity" >> installed.log

    }


ocenaudio(){
            yum -y localinstall http://www.ocenaudio.com.br/downloads/ocenaudio64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing OcenAudio" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : OcenAudio" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "OcenAudio" >> installed.log

    }



mix(){
            yum -y install mixxx | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Mixxx" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Mixxx" -i "/usr/share/icons/pinguino.png" -t 5000'

echo "Mixxx" >> installed.log

    }


skype(){
            yum -y install skype | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Skype" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/skype ]; then
$changelog
echo "SKYPE" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : SKYPE" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason SKYPE is not installed, please try again"
fi

    }


jitsi(){
            yum -y localinstall https://download.jitsi.org/jitsi/rpm/jitsi-2.2-latest.i386.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Jitsi" --text="Please Wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/jitsi ]; then
$changelog
echo "Jitsi" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Jitsi" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Jitsi is not installed, please try again"
fi


    }

turpial(){
            yum -y install turpial | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Turpial" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Turpial" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Turpial" >> installed.log

    }


gwibber(){
            yum -y install gwibber | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Gwibber" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Gwibber" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Gwibber" >> installed.log

    }


bible(){
            yum -y install bibletime | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Bible Time" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Bible Time" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Bible Time" >> installed.log

    }


tuxpaint(){
            yum -y install tuxpaint | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Tuxpaint" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Tuxpaint" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Tuxpaint" >> installed.log

    }


Stellar(){
            yum -y install stellarium | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Stellarium" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Stellarium" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Stellarium" >> installed.log

    }


celestia(){
            yum -y install celestia | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Celestia" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Celestia" -i "/usr/share/icons/pinguino.png" -t 5000'
echo "Celestia" >> installed.log

    }


Earth(){
            yum -y localinstall http://dl.google.com/dl/earth/client/current/google-earth-stable_current_x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Google Earth" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /opt/google/earth/free/googleearth ]; then
$changelog
echo "Google Earth" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Google Earth" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Google Earth is not installed, please try again"
fi

    }


gcompris(){
            yum -y install gcompris | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Gcompris" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Gcompris" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Gcompris" >> installed.log

    }


tuxMath(){
            yum -y tuxmath | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing TuxMath" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : TuxMath" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "TuxMath" >> installed.log

    }


tuxType(){
            yum -y install tuxtype2 | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing TuxType" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : TuxType" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "TuxType" >> installed.log

    }


childsplay(){
            yum -y install childsplay | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Childsplay" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Childsplay" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Childsplay" >> installed.log

    }


scratch(){
            yum -y localinstall http://info.scratch.mit.edu/sites/infoscratch.media.mit.edu/files/file/scratch-1.4.0.1-1.i386.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Scratch" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/scratch ]; then
$changelog
echo "Scratch" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Scratch" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Scratch is not installed, please try again"
fi

    }


ri(){
            yum -y install Ri-li | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Ri-li" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Ri-li" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Ri-li" >> installed.log

    }


Frozen(){
            yum -y install frozen-bubble | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Frozen Bubble" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Frozen Bubble" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Frozen Bubble" >> installed.log

    }


Extreme(){
            yum -y install extremetuxracer | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Extreme Tux Racer" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Extreme Tux Racer" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Extreme Tux Racer" >> installed.log

    }


Super(){
            yum -y install supertuxkart | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Super Tux Kart" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Extreme Super Tux Kart" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Super Tux Kart" >> installed.log

    }


wormux(){
            yum -y install wormux | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Wormux" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Wormux" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Wormux" >> installed.log

    }


tremulous(){
            yum -y install tremulous | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Tremulous" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Tremulous" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Tremulous" >> installed.log

    }


Methane(){
            yum -y install methane | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Super Methane Brothers" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Super Methane Brothers" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Super Methane Brothers" >> installed.log

    }


pingus(){
            yum -y install pingus | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Pingus" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Pingus" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Pingus" >> installed.log

    }


hedgewars(){
             yum -y install hedgewars | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Hedgewars" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Hedgewars" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Hedgewars" >> installed.log

    }


glaxium(){
            yum -y install glaxium | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Glaxium" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Glaxium" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Glaxium" >> installed.log

    }


amoebax(){
            yum -y install amoebax | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Amoebax" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Amoebax" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Amoebax" >> installed.log

    }


AlienArena(){
            yum -y install alienarena | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Alien Arena" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Alien Arena" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Alien Arena" >> installed.log

    }


tORCS(){
            yum -y install torcs | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing TORCS" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : TORCS" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "TORCS" >> installed.log

    }


flightGear(){
            yum -y install FlightGear | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing FlightGear" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : FlightGear" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "FlightGear" >> installed.log

    }


perfo(){


yum -y install performous | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Performous" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/performous ]; then  
       
su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Performous" -i "/usr/share/icons/pinguino.png" -t 5000'

echo "Performous" >> installed.log
 else
zenity --info --title="PostInstallerF" --text="For some reason Performous is not installed, please try again"
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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Steam" -i "/usr/share/icons/pinguino.png" -t 5000'

 else
zenity --info --title="PostInstallerF" --text="For some reason Steam is not installed, please try again"
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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Aquaria" -i "/usr/share/icons/pinguino.png" -t 5000'

echo "Aquaria" >> installed.log
 else
zenity --info --title="PostInstallerF" --text="For some reason Aquaria is not installed, please try again"
fi

    }


Gnutella(){
            yum -y install gtk-gnutella | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Gtk-Gnutella" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Gtk-Gnutella" -i "/usr/share/icons/pinguino.png" -t 5000'


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

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : GrooveDown" -i "/usr/share/icons/gd_logo.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason GrooveDown is is not installed, please try again"
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

yum -y install grooveoff | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing GrooveOff" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /etc/yum.repos.d/home:gcala.repo ]; then
echo 'se encuentra el repo'
else
xterm -e 'yum -y localinstall http://download.opensuse.org/repositories/home:/gcala/Fedora_18/x86_64/grooveoff-0.1.1-20.1.x86_64.rpm'
fi

if [ -f /usr/bin/grooveoff ]; then
$changelog
echo "GrooveOff" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : GrooveOff" -i "/usr/share/icons/gd_logo.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason GrooveOff is is not installed, please try again"
fi

    }


wirefro(){

rm -f /usr/share/applications/Frostwire.desktop
rm -rf /home/$noti/.frostwire/
rm -f /usr/bin/frostwirelauch.sh
rm -f /opt/frostwire.tar.gz

yum -y install frostwire | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Frostwire" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/frostwire ]; then

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Frostwire" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Frostwire is is not installed, please try again"
fi

    }


uget(){
            yum -y install uget | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing UGET" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : UGET" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "UGET" >> installed.log

    }


flare(){

            yum -y install http://www.flareget.com/files/flareget/rpms/amd64/flareget-1.4-7.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing FlareGet" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/flareget ]; then

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : FlareGet" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason FlareGet is is not installed, please try again"
fi

rm -f /tmp/flareget32.rpm

    }


tucan(){
            yum -y install tucan | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Tucan Manager" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Tucan Manager" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Tucan Manager" >> installed.log

    }


YumExtender(){
            yum -y install yumex | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Yum Extender" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Yum Extender" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Yum Extender" >> installed.log

    }


blue(){
            yum -y install blueman | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Blueman" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Blueman" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "Blueman" >> installed.log

    }


Chrome(){
            yum -y localinstall https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Google-Chrome" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /opt/google/chrome/google-chrome ]; then
$changelog
echo "Google-Chrome" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Google-Chrome" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Google-Chrome is is not installed, please try again"
fi

    }


chromium(){
            
 yum -y install chromium | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Chromium" --text="Please wait...." --pulsate --auto-close --width=350  

if [ -f /usr/lib/chromium/chromium-wrapper ]; then
$changelog
echo "Chromium" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Chromium" -i "/usr/share/icons/pinguino.png" -t 5000'
 else 
zenity --info --title="PostInstallerF" --text="For some reason Chromium is is not installed, please try again"
fi

    }


opera(){
            yum -y install opera | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Navegador Opera" --text="Please wait...." --pulsate --auto-close --width=350


if [ -f /usr/bin/opera ]; then
$changelog
echo "Opera" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Navegador Opera" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Opera is is not installed, please try again"
fi

    }


bleachBit(){
      
yum -y install bleachbit | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing BleachBit" --text="Please wait...." --pulsate --auto-close --width=350



foo7=$(w3m -dump http://sourceforge.net/projects/bleachbit/files/bleachbit/); echo "foo7=$foo7" >> /tmp/bleachbit.txt | egrep '0.9.' /tmp/bleachbit.txt | awk '{print $1}' | head -1 >> /tmp/lastest_bleachbit.txt 
wait ${!}

latestfoo7=$(cat /tmp/lastest_bleachbit.txt ); echo "latestfoo7=$latestfoo7"

yum -y localinstall http://sourceforge.net/projects/bleachbit/files/bleachbit/$latestfoo7/bleachbit-$latestfoo7-1.1.fc17.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing BleachBit" --text="Please wait...." --pulsate --auto-close --width=350

cat /dev/null > /tmp/bleachbit.txt
cat /dev/null > /tmp/lastest_bleachbit.txt

if [ -f /usr/bin/bleachbit ]; then
$changelog
echo "BleachBit" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : BleachBit" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Bleachbit is is not installed, please try again"
fi

    }


GnomeTweak(){
            yum -y install python-devel gnome-tweak-tool dconf-editor gconf-editor | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing GnomeTweakTool y dconf-editor" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : GnomeTweakTool y dconf-editor" -i "/usr/share/icons/pinguino.png" -t 5000'


echo "GnomeTweakTool y dconf-editor" >> installed.log

    }

melibre(){
            yum -y install menulibre | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Instalando Menu Libre" --text="Please Wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/menulibre ]; then
$changelog
echo "Menu Library" >> installed.log
su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Menu Libre" -i "/usr/share/icons/pinguino.png" -t 5000'
 else 
zenity --info --title="PostInstallerF" --text="For some reason Menu Libre is is not installed, please try again"
fi

    }

pendientes(){
            yum-complete-transaction -y | pv -en 2>&1 | zenity --progress --title "Completed Pending Install" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "Completed Pending Installations" -i "/usr/share/icons/pinguino.png" -t 5000'


    }


bitdefender(){

yum -y localinstall http://download.bitdefender.com/repos/rpm/bitdefender/x86_64/bitdefender-scanner-7.6-3.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Bitdefender Antivirus- scanner" --text="Please wait...." --pulsate --auto-close --width=350


yum -y localinstall http://download.bitdefender.com/repos/rpm/bitdefender/x86_64/bitdefender-scanner-gui-1.0-3.x86_64.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Bitdefender Antivirus- scanner gui" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /opt/BitDefender-scanner/bin/bdgui ] && [ -f /opt/BitDefender-scanner/bin/bdscan ]; then
$changelog
echo "Bitdefender" >> installed.log


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Bitdefender" -i "/usr/share/icons/pinguino.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Bitdefender is is not installed, please try again"
fi

    }


infosystem(){
            zenity --info --title="System Inforamation" --text="Distribucion: 
$(cat /etc/fedora-release)\n\nKernel: $(uname -s -r)\n\nArchitecture: 
$(uname -i)\n\nRAM: $(cat /proc/meminfo | grep MemTotal | cut -c10-)\n\nGraphics Card: 
$(/sbin/lspci | grep VGA)\n\nGraphics Drivers: 
$(glxinfo | grep renderer)\n\nSound Card: 
$(lspci | grep -i audio)\n\nNetwork: 
$(lspci | grep -i network)\n\nUptime: 
$(uptime)" --ok-label="Ok"


    }


hardinfo(){
            yum -y install hardinfo | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Hardinfo" --text="Please wait...." --pulsate --auto-close --width=350


su $noti -c 'notify-send "PostInstallerF" "The installation has completed for the sofware : Hardinfo" -i "/usr/share/icons/sistema.png" -t 5000'


echo "Hardinfo" >> installed.log

    }


batti(){
            yum -y install batti | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Batti" --text="Please wait...." --pulsate --auto-close --width=350

echo "@batti" >> /etc/xdg/lxsession/LXDE/autostart
exec /usr/bin/batti

su $noti -c 'notify-send "PostInstallerF" "The Installation of Batti has completed." -i "/usr/share/icons/sistema.png" -t 5000'


echo "Batti" >> installed.log

    }


alien(){
             yum -y localinstall http://sourceforge.net/projects/postinstaller/files/data/alien-8.86-1.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Alien" --text="Please wait...." --pulsate --auto-close --width=350

if [ -f /usr/bin/alien ]; then
$changelog
echo "Alien" >> installed.log

su $noti -c 'notify-send "PostInstallerF" "The installation completed of the software " -i "/usr/share/icons/sistema.png" -t 5000'

 else 
zenity --info --title="PostInstallerF" --text="For some reason Alien is is not installed, please try again"
fi

    }


truetype(){
            if [ -d /usr/share/fonts/msttcorefonts ]; then
zenity --info --title="PostInstallerF" --text="Ya tenes instalado Microsoft TrueType core fonts, nada que hacer"
else
yum -y localinstall http://sourceforge.net/projects/postinstaller/files/fuduntu/msttcorefonts-2.0-2.noarch.rpm | pv -n 2>&1 | yad --class="Installing" --window-icon="/usr/share/icons/acciones/topicon.png" --image="/usr/share/icons/icoinstall2.png" --image-on-top --progress --title "Installing Microsoft TrueType core fonts" --text="Please wait...." --pulsate --auto-close --width=350
fi


su $noti -c 'notify-send "PostInstallerF" "The installation completed of the software Microsoft TrueType core fonts" -i "/usr/share/icons/sistema.png" -t 5000'


    }



cleanlog(){
            cat /dev/null > /usr/share/.postinstallerf/installed.log


su $noti -c 'notify-send "PostInstallerF" "The PostInstallerF reset is complete" -i "/usr/share/icons/sistema.png" -t 5000'


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

       su $noti -c 'notify-send "Finished!" "All tasks were completed" -i "/usr/share/icons/pinguino.png" -t 10000'

       
            
    fi

     
    exit 0
