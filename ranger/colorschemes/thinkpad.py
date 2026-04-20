# ThinkPad colorscheme: mainly white with red accents.
# License: GNU GPL version 3, see the file "AUTHORS" for details.

from __future__ import (absolute_import, division, print_function)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (
    blue, cyan, green, magenta, red, white, yellow, default,
    normal, bold, reverse, dim, BRIGHT,
    default_colors,
)


class Scheme(ColorScheme):
    progress_bar_color = red

    def use(self, context):  # pylint: disable=too-many-branches,too-many-statements
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            fg = white
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                bg = red
            if context.border:
                fg = default
            if context.media:
                fg = red
            if context.container:
                attr |= bold
                fg = red
                fg += BRIGHT
            if context.directory:
                attr |= bold
                fg = red
                fg += BRIGHT
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                attr |= bold
                fg = white
                fg += BRIGHT
            if context.socket:
                attr |= bold
                fg = red
            if context.fifo or context.device:
                fg = red
                if context.device:
                    attr |= bold
                    fg += BRIGHT
            if context.link:
                fg = red if context.good else magenta
                attr |= bold
            if context.tag_marker and not context.selected:
                attr |= bold
                fg = red
                fg += BRIGHT
            if not context.selected and (context.cut or context.copied):
                attr |= bold
                fg = yellow
                fg += BRIGHT
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = white
                    fg += BRIGHT
                    bg = red
            if context.badinfo:
                if attr & reverse:
                    bg = red
                else:
                    fg = red

            if context.inactive_pane:
                fg = white
                attr |= dim

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = red if context.bad else red
                fg += BRIGHT
            elif context.directory:
                fg = white
                fg += BRIGHT
            elif context.tab:
                if context.good:
                    bg = red
                    fg = white
                    fg += BRIGHT
            elif context.link:
                fg = red

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = white
                elif context.bad:
                    fg = red
            if context.marked:
                attr |= bold | reverse
                fg = red
                fg += BRIGHT
            if context.frozen:
                attr |= bold | reverse
                fg = red
                fg += BRIGHT
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red
                    fg += BRIGHT
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = red
                attr &= ~bold
            if context.vcscommit:
                fg = white
                attr &= ~bold
            if context.vcsdate:
                fg = white
                attr &= ~bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = red
                attr |= bold

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = red
                attr |= bold
            elif context.vcsuntracked:
                fg = white
            elif context.vcschanged:
                fg = red
            elif context.vcsunknown:
                fg = red
            elif context.vcsstaged:
                fg = red
                attr |= bold
            elif context.vcssync:
                fg = white
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync or context.vcsnone:
                fg = white
            elif context.vcsbehind:
                fg = red
            elif context.vcsahead:
                fg = red
                attr |= bold
            elif context.vcsdiverged:
                fg = magenta
            elif context.vcsunknown:
                fg = red

        return fg, bg, attr
