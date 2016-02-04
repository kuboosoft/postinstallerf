![PostInstallerF](http://s11.postimg.org/jlu00vccz/postintallerf3.png "https://sourceforge.net/projects/postinstaller/")


PostInstallerF
==============

PostInstallerF will install all the software that Fedora doesn't include commonly, after running Fedora for the first time. Its easy for a new user. PostInstallerF contains everything that you need for your daily computing. 

PostInstallerF is for anyone; created to assist the user. There are many official guides, wiki, Ask;  also guides made by third parties. But this is not enough. We are in a changing society; the user does not want to read large guides. The user only wants to install easily and get the best performance and production to its operating system. Why not help a bit to the user?

### Features:

PostInstallerF is a simple and powerfull GUI; All process, is asked and authoritated by the user. PostInstallerF have the capacity to restore your system even if you remove the official repositories of Fedora. Now it has a powerful tool to enable, disable and edit repositories. Install and remove COPR repositories, search any software in your system; show a screenshot; give detailed information (over 49000 packages, steadily increasing) thanks a our tools when a rpm is installed, if you open PostInstallerF makes a metadata (program_fu.posmet), included all the information about the rpm package.

### Others:
* Updates your system
* Configures you system
* Installs Nvidia drivers (experimental)
* Installs differents desktops (Gnome, Xfce, kde, lxde, Cinnamon, Mate)
* Enables/Disable add your user  "sudo"
* Cleans old kernel (a secure way)
and more...


SPANISH

PostinstallerF Instalara todo software que no se incluye comúnmente, después de ejecutar Fedora por primera vez. Es fácil para el nuevo usuario. Contiene lo que tu necesitas!


### License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [gnu.org/licenses](http://www.gnu.org/licenses/).


----------------------------------------------------
**How to Install PostInstallerF Fedora?**

from a terminal:


FEDORA 22/23/24

1) su

2) dnf -y install wget 

3) wget -P /etc/yum.repos.d/ https://raw.github.com/kuboosoft/postinstallerf/master/postinstallerf.repo

4) dnf clean all && dnf -y install postinstallerf


----------------------------------------------------
SOURCE CODE
http://sourceforge.net/projects/postinstaller/files/fedora/releases/23/SRPM/postinstallerf-1.5-39.20160204git8102266.fc23.src.rpm

