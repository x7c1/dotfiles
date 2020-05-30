## gtile settings

load:

```
$ dconf load /org/gnome/shell/extensions/gtile/ < gtile.1920x1200.dconf
```

dump:

```
$ dconf dump /org/gnome/shell/extensions/gtile/ | sort > gtile.1920x1200.dconf
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
