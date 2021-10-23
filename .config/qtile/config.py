# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Widgets need the package 'ttf-font-awesome'.

import os
import subprocess
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, qtile, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import my_widget.volume
import my_widget.net
import my_widget.cpu
import my_widget.battery

mod = "mod4"
terminal = "alacritty"
is_laptop = True if 'laptop' in os.uname().nodename else False


# KEYS

keys = [
    # Qtile management
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Switch Monitors
    Key([mod], "w", lazy.to_screen(1), desc="Focus Monitor left"),
    Key([mod], "f", lazy.to_screen(0), desc="Focus Monitor right"),

    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    # Custom shortcuts to launch applications/programs.
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn("rofi -show run"),
    desc="Run Launcher"),
    Key([mod], "b", lazy.spawn("firefox"), desc="Lauch Browser"),
    Key([mod], "m", lazy.spawn("thunderbird"), desc="Lauch Mail"),
    Key([mod], "o", lazy.spawn("pcmanfm"), desc="Launch File Manager"),
    Key([mod], "d", lazy.spawn("discord"), desc="Launch Discord"),
    Key([mod], "s", lazy.spawn("steam"), desc="Launch File Steam"),
    Key([], "Print", lazy.spawn("flameshot gui"), desc="Take Screenshot"),

    # Keyboard Layout
    Key([mod], "z", lazy.widget["keyboardlayout"].next_keyboard(), desc="Nexp keyboard layout"),

    # Volume keys
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle"), desc="Mute Master"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 5%-", desc="Raise Master Volume")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 5%+", desc="Lower Master Volume")),
    
    # Dunst Notifications
    Key(["control"], "space", lazy.spawn("dunstctl close"), desc="Close notification"),
    Key(["control", "shift"], "space", lazy.spawn("dunstctl close-all"), desc="Close all notifications"),
    Key(["control"], "grave", lazy.spawn("dunstctl history-pop"), desc="Redisplay last message"),
]


# GROUPS
groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # Move focused window to group.
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            desc="move focused window to group {}".format(i.name)),
    ])

# COLORS

def dracula_theme():
    """Dracula color scheme."""
    colors = {
        'Background': '#282a36',
        'Current Line': '#44475a',
        'Selection': '#44475a', 
        'Foreground': '#f8f8f2',
        'Comment': '#6272a4',
        'Cyan': '#8be9fd',
        'Green': '#50fa7b', 
        'Orange': '#ffb86c',
        'Pink': '#ff79c6',
        'Purple': '#bd93f9',
        'Red': '#ff5555',
        'Yellow': '#f1fa8c',
    }
    return colors

def widget_dracula():
    """Colors for widgets."""
    foreground1 = colors['Green']
    background1 = colors['Current Line']
    foreground2 = colors['Cyan']
    background2 = colors['Background']
    colors_text_1 = {'foreground': foreground1, 'background': background1}
    colors_text_2 = {'foreground': foreground2, 'background': background2}
    colors_filler_1 = {'foreground': background2, 'background': background1}
    colors_filler_2 = {'foreground': background1, 'background': background2}
    return colors_text_1, colors_text_2, colors_filler_1, colors_filler_2

colors = dracula_theme()

# Layouts
layout_theme = {
        'border_focus': colors['Red'],
        'border_width': 2,
}

layouts = [
    layout.MonadTall(
        new_client_position='before_current',
        **layout_theme,
    ),
    layout.Max(),
    # layout.Columns(
    #     border_focus_stack=['#d75f5f', '#8f3d3d'],
    #     border_width=2,
    #     border_on_single=True,
    #     num_columns=2,
    #     insert_position=1,
    # ),
]


# WIDGETS
widget_defaults = dict(
    font='noto sans mono',
    fontsize=14,
    padding=6,
    foreground=colors['Purple'],
)

extension_defaults = widget_defaults.copy()

network_icon = '\uf1eb' if is_laptop else '\uf796'

def my_Sep():
    return widget.Sep(
            foreground=colors['Purple'],
        )

# Widgets on the left side are unique to each screen.
def init_widgets_left():
    return [
            # Current Layout
            widget.CurrentLayoutIcon(
                scale=0.7,
            ),
            # widget.TextBox(**colors_filler_2, **my_separator),
            # GroupBox
            widget.GroupBox(
                highlight_method='line',
                active=colors['Purple'],
                inactive=colors['Purple'],
                this_current_screen_border=colors['Purple'],
                this_screen_border=colors['Purple'],
                other_current_screen_border=colors['Purple'],
                other_screen_border=colors['Purple'],
            ),
        ]

widgets_right = [
        my_Sep(),
        # Network Usage
        my_widget.net.Net(
            interface='wlp2s0' if is_laptop else 'eno1',
            format=network_icon + ' {down:.1f} {down_unit} \u25bc\u25b2 {up:.1f} {up_unit}',
            update_interval=5,
        ),
        my_Sep(),
        # CPU Usage
        my_widget.cpu.CPU(
            format='\uf2db {freq_current:.2f} GHz ({load_percent} %)',
            update_interval=5,
        ),
        my_Sep(),
        # Memory Usage
        widget.Memory(
            format='\uf538{MemUsed: .0f} {mm}iB',
            update_interval=5,
        ),
        my_Sep(),
        # Updates
        widget.CheckUpdates(
            distro='Arch_yay',
            display_format='{\uf063 updates}',
            no_update_string='\uf063 0',
            update_interval=3600,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(terminal + ' -e yay -Syyu')},
            colour_have_updates=colors['Purple'],
            colour_no_updates=colors['Purple'],
        ),
        my_Sep(),
        # Sound volume
        widget.TextBox(
            text='\uf028',
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('pavucontrol')},
        ),
        my_widget.volume.Volume(
            step=5,
        ),
        my_Sep(),
        # Keyboard layout
        widget.TextBox(
            text='\uf11c',
            fontsize=18,
        ),
        widget.KeyboardLayout(
            configured_keyboards=['us colemak', 'us'],
            display_map={'us colemak':'col', 'us':'us'},
        ),
        my_Sep(),
        # Datetime
        widget.Clock(
            format='\uf017 %FT%T (%a)',
        ),
]


widgets_laptop = [
        my_Sep(),
        # Battery
        my_widget.battery.Battery(
            format='\u2b4d {char} {hour:d}:{min:02d} ({percent:.0f} %)',
            charge_char='\u25b2',
            discharge_char='\u25bc',
            notify_below=20,
            low_percentage=0.2,
            low_foreground=colors['Red'],
            update_interval=5,
        ),
]

## SCREENS
if is_laptop:
    screens = [
        Screen(
            top=bar.Bar(
                widgets=[*init_widgets_left(), widget.Spacer(), widget.Systray(), *widgets_laptop, *widgets_right],
                size=24,
                opacity=1,
                background=colors['Background'],
            )
        ),
    ]
else:
    screens = [
        Screen(
            top=bar.Bar(
                widgets=[*init_widgets_left(), widget.Spacer(), widget.Systray(), *widgets_right],
                size=24,
                opacity=1,
                background=colors['Background'],
            )
        ),
        Screen(
            top=bar.Bar(
                widgets=[*init_widgets_left(), widget.Spacer(), *widgets_right],
                size=24,
                opacity=1,
                background=colors['Background'],
            )
        )
    ]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
   Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
# wmname = "LG3D"
wmname = 'Qtile'
