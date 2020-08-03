## Initial setup

for new machine:

```
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

```
$ dconf load /org/gnome/shell/extensions/gtile/ < gtile.1920x1200.dconf
```

dump:

```
$ dconf dump /org/gnome/shell/extensions/gtile/ | sort > gtile.1920x1200.dconf
```

## Tips

Enable to restore xkb settings (if it's lost after suspend):

```
$ sudo ln -s $(pwd)/.xkb/restore_us_keymap.sh /lib/systemd/system-sleep
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
