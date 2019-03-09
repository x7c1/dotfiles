# rf. https://github.com/metakermit/dotfiles/tree/master/autokey

import logging # see the logs in ~/.config/autokey/autokey.log
import re

h = store.get_global_value('hotkey')
s = engine.get_return_value()

logging.debug("combo got:: " + str(s)) # autokey-gtk -l
logging.debug(window.get_active_class())

app_names = [
    'Emacs',
    'Gnome-terminal',
]
matched = re.match(
    '.*(%s)' % '|'.join(app_names),
    window.get_active_class()
)

if matched:
    logging.debug('nothing')
    keyboard.send_keys(h)
else:
    logging.debug('sth')
    keyboard.send_keys(s)
