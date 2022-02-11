## Initial setup

for new machine:

```sh
$ sudo apt install xclip

$ cd ~/.ssh
$ ssh-keygen -t rsa
$ cat ~/.ssh/id_rsa.pub | xclip -selection c

# Register the copied SSH key to github.
# https://github.com/settings/keys

$ sudo apt install git -y
$ git clone git@github.com:x7c1/dotfiles.git
```

## gTile settings

load:

```sh
$ dconf load /org/gnome/shell/extensions/gtile/ < gtile.1920x1200.dconf
```

dump:

```sh
$ dconf dump /org/gnome/shell/extensions/gtile/ | sort > gtile.1920x1200.dconf
```

## Tips

Enable to restore xkb settings (if it's lost after suspend):

```sh
$ sudo ln -s $(pwd)/.xkb/restore_us_keymap.sh /lib/systemd/system-sleep
```

Change the timeout before suspending:

```sh
# 6 [hour]
$ gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout $((60*60*6))

$ dconf dump / | grep -i "suspend\|sleep" -C2

[org/gnome/settings-daemon/plugins/power]
power-button-action='suspend'
sleep-inactive-ac-timeout=21600
sleep-inactive-ac-type='suspend'

[org/gnome/settings-daemon/plugins/xsettings]
```

<!--

## sleep settings

```
$ cat /sys/power/mem_sleep
[s2idle] deep

$ sudo su
root@...:/.../dotfiles# echo deep > /sys/power/mem_sleep
root@...:/.../dotfiles# exit

$ cat /sys/power/mem_sleep
s2idle [deep]
```

-->
