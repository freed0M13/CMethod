# Make Instance Ready for Remote Desktop or RDP

b='\033[1m'
r='\E[31m'
g='\E[32m'
c='\E[36m'
endc='\E[0m'
enda='\033[0m'

clear

# Branding

printf """$c$b
        ____                   ______  __  ___________
       / __/_______  ___  ____/ / __ \/  |/  <  /__  /
      / /_/ ___/ _ \/ _ \/ __  / / / / /|_/ // / /_ < 
     / __/ /  /  __/  __/ /_/ / /_/ / /  / // /___/ / 
    /_/ /_/   \___/\___/\__,_/\____/_/  /_//_//____/
    $r  Cloud Temporary Kali | by=freed0M13#2199
      Discord : https://discord.gg/nMsWfHRd6p       
$endc$enda""";



# Used Two if else type statements, one is simple second is complex. So, don't get confused or fear by seeing complex if else statement '^^.

# Creation of user
printf "\n\nKullanıcı Oluşturuluyor... " >&2
if sudo useradd -m user &> /dev/null
then
  printf "\rKullanıcı Oluşturuldu. $endc$enda\n" >&2
else
  printf "\r$r$b Hata Meydana Geldi Lütfen Tekrar Deneyin. $endc$enda\n" >&2
  exit
fi

# Add user to sudo group
sudo adduser user sudo

# Set password of user to 'root'
echo 'user:root' | sudo chpasswd

# Change default shell from sh to bash
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd

# Initialisation of Installer
printf "\n\n$c$b    Güncelleme Yapılıyor... $endc$enda" >&2
if sudo apt-get update &> /dev/null
then
    printf "\r$g$b    Güncelleme Tamamlandı. $endc$enda\n" >&2
else
    printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2
    exit
fi

# Installing Chrome Remote Desktop
printf "\n$g$b    Chrome Uzaktan Masaüstü İndiriliyor... $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Chrome Uzaktan Masaüstü Kuruldu. $endc$enda\n" >&2 ||
{ printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2; exit; }



# Install Desktop Environment (XFCE4)
printf "$g$b    Sistem Arayüzü İndiriliyor... $endc$enda" >&2
{
    sudo DEBIAN_FRONTEND=noninteractive \
        apt install --assume-yes xfce4 desktop-base
    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
    sudo apt install --assume-yes xscreensaver
    sudo systemctl disable lightdm.service
} &> /dev/null &&
printf "\r$c$b    Sistem Arayüzü Kuruldu. $endc$enda\n" >&2 ||
{ printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2; exit; }



# Install Firefox
printf "$g$b    Firefox İndiriliyor... $endc$enda" >&2
{
    sudo apt-get firefox
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Firefox Kuruldu $endc$enda\n" >&2 ||
printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2



# Install CrossOver (Run exe on linux)
printf "$g$b    CrossOver İndiriliyor... $endc$enda" >&2
{
    wget https://media.codeweavers.com/pub/crossover/cxlinux/demo/crossover_20.0.2-1.deb
    sudo dpkg -i crossover_20.0.2-1.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    CrossOver Kuruldu. $endc$enda\n" >&2 ||
printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2


# Install Katoolin
printf "$g$b    Katoolin İndiriliyor... $endc$enda" >&2
{
    sudo git clone https://github.com/LionSec/katoolin.git && cp katoolin/katoolin.py /usr/bin/katoolin
    sudo chmod +x /usr/bin/katoolin
} &> /dev/null &&
printf "\r$c$b    Katoolin Kuruluyor. $endc$enda\n" >&2 ||
printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2

# Install VLC Media Player 
printf "$g$b    VLC Media Player İndiriliyor... $endc$enda" >&2
{
    sudo apt install ffmpeg4 -y
	sudo apt install vlc -y
} &> /dev/null &&
printf "\r$c$b    VLC Media Player Kuruldu. $endc$enda\n" >&2 ||
printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2

# Install other tools like nano
sudo apt-get install gdebi -y &> /dev/null
sudo apt-get install vim -y &> /dev/null
sudo apt-get install gedit -y &> /dev/null
sudo git clone https://github.com/DaxtillUS/Daxttack && cp Daxattack /usr/bin/Daxttack
sudo chmod +x /usr/bin/Daxttack
printf "$g$b    Araçlar İndiriliyor... $endc$enda" >&2
if sudo apt install nautilus nano -y &> /dev/null
then
    printf "\r$c$b    Araçlar Kuruldu. $endc$enda\n" >&2
else
    printf "\r$r$b    Hata Oluştu Lütfen Tekrar Deneyin. $endc$enda\n" >&2
fi



printf "\n$g$b    Sunucu Başarıyla Kuruldu! $endc$enda\n\n" >&2



# Adding user to CRP group
sudo adduser user chrome-remote-desktop

# Finishing Work
printf '\n http://remotedesktop.google.com/headless Sitesine Giriş Yap ve Debian Linux Seçeneğini Kopyala.\n'
read -p "Komudu Yapıştır: " CRP
su - user -c """$CRP"""

printf "\n$c$b Yapılan Herşey Doğruysa Sunucu Açılmıştır, Eğer Hata Yaptıysan F5 Çek Ve Yeniden Dene ! 'su - user -c '<CRP Command Here>' $endc$enda\n" >&2
printf "\n$c$b https://remotedesktop.google.com/access Sunucuna Giriş Yapmak İçin Bu Linke Tıkla Ve Sunucuyu Seç. ' $endc$enda\n" >&2
printf "\n$g$b Sunucun Açıldı İyi Eğlenceler !$endc$enda"

