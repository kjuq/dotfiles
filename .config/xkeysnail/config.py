# -*- coding: utf-8 -*-
import re
from xkeysnail.transform import *

define_modmap({
    # for JIS keyboard
    #Key.RO: Key.RIGHT_SHIFT,
    #Key.GRAVE: Key.ESC,
    #Key.CAPSLOCK: Key.LEFT_CTRL,
    #Key.MUHENKAN: Key.LEFT_META,
    #Key.HENKAN: Key.RIGHT_META,
    #Key.KATAKANAHIRAGANA: Key.RIGHT_ALT,

    # disable unnecessary keys
    #Key.APOSTROPHE: Key.RIGHT_ALT,
    #Key.LEFT_BRACE: Key.YEN,
    #Key.MINUS: Key.YEN,
    #Key.EQUAL: Key.YEN,
    #Key.BACKSLASH: Key.YEN,
    #Key.RIGHT_BRACE: Key.YEN,

    # swap alt with super
    #Key.RIGHT_ALT: Key.RIGHT_META,
    #Key.RIGHT_META: Key.RIGHT_ALT,
    #Key.LEFT_ALT: Key.LEFT_META,
    #Key.LEFT_META: Key.LEFT_ALT,
})

'''
define_conditional_modmap(lambda wm_class: wm_class not in ('Gnome-terminal'), {
})

define_multipurpose_modmap({
})
'''

define_keymap(re.compile('Gnome-terminal|Xfce4-terminal|gnome-shell|'), {
    K('LSuper-x'): K('C-Shift-x'),
    K('LSuper-c'): K('C-Shift-c'),
    K('LSuper-v'): K('C-Shift-v'),
}, 'Copy and paste in Terminal')

define_keymap(lambda wm_class: wm_class not in ('Gnome-terminal', 'Xfce4-terminal', 'gnome-shell', ''), {
    K('C-b'): K('left'),
    K('C-f'): K('right'),
    K('C-p'): K('up'),
    K('C-n'): K('down'),
    K('C-h'): K('backspace'),
    K('C-a'): K('home'),
    K('C-e'): K('end'),
    K('C-m'): K('enter'),
    K('C-o'): [K('enter'), K('left')],
    K('C-d'): K('delete'),
    K('C-k'): [K('Shift-end'), K('delete')],
}, 'Emacs-like movement')

define_keymap(lambda wm_class: wm_class not in ('Gnome-terminal', 'Xfce4-terminal', 'gnome-shell', ''), {
    K('LSuper-q'): K('C-q'),
    K('LSuper-w'): K('C-w'),
    K('LSuper-e'): K('C-e'),
    K('LSuper-r'): K('C-r'),
    K('LSuper-t'): K('C-t'),
    K('LSuper-y'): K('C-y'),
    K('LSuper-u'): K('C-u'),
    K('LSuper-i'): K('C-i'),
    K('LSuper-o'): K('C-o'),
    K('LSuper-p'): K('C-p'),
    K('LSuper-a'): K('C-a'),
    K('LSuper-s'): K('C-s'),
    K('LSuper-d'): K('C-d'),
    K('LSuper-f'): K('C-f'),
    K('LSuper-g'): K('C-g'),
    K('LSuper-h'): K('C-h'),
    K('LSuper-j'): K('C-j'),
    K('LSuper-k'): K('C-k'),
    K('LSuper-l'): K('C-l'),
    K('LSuper-semicolon'): K('C-semicolon'),
    K('LSuper-z'): K('C-z'),
    K('LSuper-x'): K('C-x'),
    K('LSuper-c'): K('C-c'),
    K('LSuper-v'): K('C-v'),
    K('LSuper-b'): K('C-b'),
    K('LSuper-n'): K('C-n'),
    K('LSuper-m'): K('C-m'),
    K('LSuper-comma'): K('C-comma'),
    K('LSuper-dot'): K('C-dot'),
    K('LSuper-slash'): K('C-slash'),
}, 'LSuper to Ctrl')

define_keymap(None, {
    K('esc'): [K('esc'), K('hanja')],
}, 'symbol key layer')

