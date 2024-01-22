config.load_autoconfig()

c.tabs.position = "left"
c.tabs.width = 160
c.tabs.padding = {"bottom": 5, "left": 5, "right": 5, "top": 5}

c.content.pdfjs = True  # enable to see pdf

c.window.hide_decoration = True

c.fonts.web.size.default_fixed = 16
c.fonts.default_size = "16pt"

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True

c.auto_save.session = True

c.url.default_page = "https://google.com/"
c.url.start_pages = "https://google.com/"

c.scrolling.bar = "always"

# Open new tab next to the current tab
c.tabs.new_position.unrelated = "next"

c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "g": "https://github.com/search?q={}",
    "s": "https://stackoverflow.com/search?q={}",
    "y": "https://www.youtube.com/results?search_query={}",
}

# Enable JavaScript.
config.set("content.javascript.enabled", True, "file://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

# Vim/Vimium-like
config.unbind("d")
config.unbind("u")
config.bind("d", ":scroll-page 0 0.5")
config.bind("u", ":scroll-page 0 -0.5")
config.bind("x", ":tab-close")
config.bind("X", ":undo")

# config.bind("yf", ":hint links yank")

config.bind("<Ctrl+e>", ":scroll down")
config.bind("<Ctrl+y>", ":scroll up")

config.bind("<Ctrl+b", ":scroll-page 0 -1")
config.bind("<Left>", ":scroll-page 0 -1")
config.bind("<Ctrl+f>", ":scroll-page 0 1")
config.bind("<Right>", ":scroll-page 0 1")

config.unbind("<Ctrl-e>", mode="insert")

# {{{ Colors https://github.com/koekeishiya/dotfiles/blob/master/qutebrowser/config.py

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = "#d5c4a1"

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = "#333333"

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = "#202020"

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = "#8fee96"

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.item.selected.border.top = "#151515"

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = "#151515"

# Foreground color of the matched text in the completion.
# Type: QssColor
c.colors.completion.match.fg = "#d75f5f"

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = "#202020"

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = "#d5c4a1"

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = "#202020"

# Foreground color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.fg = "#d4c5a1"

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = "#202020"

# Default foreground color of the URL in the statusbar.
# Type: QssColor
c.colors.statusbar.url.fg = "#d5c4a1"

# Foreground color of the URL in the statusbar on error.
# Type: QssColor
c.colors.statusbar.url.error.fg = "#d75f5f"

# Foreground color of the URL in the statusbar on successful load
# (http).
# Type: QssColor
c.colors.statusbar.url.success.http.fg = "#84edb9"

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = "#8fee96"

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = "#cd950c"

# Background color of the tab bar.
# Type: QtColor
c.colors.tabs.bar.bg = "#202020"

# Foreground color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.fg = "#707070"

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = "#202020"

# Foreground color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.fg = "#707070"

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = "#202020"

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = "#d5c4a1"

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = "#202020"

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = "#d5c4a1"

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = "#202020"

# }}}