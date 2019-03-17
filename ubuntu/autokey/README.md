
install latest autokey

```
$ pip3 install --user git+https://github.com/autokey/autokey
```

debug (-l option)

```
$ ~/.local/bin/autokey-gtk -l
```

stop

```
$ kill $(pgrep -f autokey)
```

create symbolic links

```
$ ln -s `pwd`/functions $HOME/.config/autokey/data/
$ ln -s `pwd`/with_alt $HOME/.config/autokey/data/
$ ln -s `pwd`/with_ctrl $HOME/.config/autokey/data/
```

