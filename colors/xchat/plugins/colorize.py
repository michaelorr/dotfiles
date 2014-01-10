"""
Colorize - nick and URL coloring for XChat/Hexchat

------------------------------------------------------------------------------

Copyright (c) 2013 Shaun Duncan and Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
"""

import re
import xchat


__module_name__ = 'colorize'
__module_author__ = 'Shaun Duncan'
__module_version__ = '0.2'
__module_description__ = 'Colorizes nicks and URLs in messages'


# Taken from source: src/common/text.c - rcolors
colors = [19, 20, 22, 24, 25, 26, 27, 28, 29]
url_pat = re.compile(r'(https?://[-A-Za-z0-9+&@#/%?=~_()|!:,.;\003\017]*[-A-Za-z0-9+&@#/%=~_|\003\017])', re.I)
nick_pat = re.compile(r'([a-zA-Z0-9\[\]\{\}\^\\\-_]+)')


def is_colorized(string):
    """
    Checks to see if a string is already colorized, i.e. if 0x3 appears in the content
    """
    return '\003' in string


def color_enabled():
    """
    Simple wrapper to check pref setting for automatic nick coloring
    """
    pref = xchat.get_prefs('text_color_nicks')
    return pref is not None and pref == 1


def colorize_string(string, underline=False):
    """
    Colorizes a string along the same lines as the source of xchat does.
    It's a very simple approach: take the sum of char values of the input
    string, mod the number of colors to use. Returns the original string
    wrapped with escape sequences to colorize.

    Should the user pass an empty string, the empty string is still returned,
    but wrapped with no color
    """
    if string == '':
        ret = '\00300\017'
    else:
        idx = sum(ord(c) for c in string)
        ret = '\003%s%s\017' % (colors[idx % len(colors)], string)

    return '%s%s' % ('\037' if underline else '', ret)


# This isn't really necessary, but it looks nice
_color_mod_name = ''.join([colorize_string(c) for c in __module_name__])


def on_unload(data):
    """
    Callback for module unload
    """
    print '%s plugin v%s unloaded' % (_color_mod_name, __module_version__)


def colorize_message(word, word_eol, userdata):
    """
    Callback for message printing events. Scans contents of a message for both
    URLs and nicks and colorizes them. This colorized output is sent along to the
    client
    """
    message = word[1]

    # This prevents recursive printing
    if is_colorized(message) or not color_enabled():
        return xchat.EAT_NONE

    current_channel = xchat.get_info('channel')

    # Private messages - the channel is the nick
    if not current_channel.startswith('#'):
        nicks = [current_channel, xchat.get_info('nick')]
    else:
        nicks = [u.nick for u in xchat.get_list('users')]

    output = []

    # Split up the message delimited by a possible nick
    for token in nick_pat.split(message):
        if token in nicks:
            token = colorize_string(token)
        output.append(token)

    output = ''.join(output)

    # Colorize URLs
    for url in url_pat.findall(output):
        output = output.replace(url, '\037\00328%s\017' % xchat.strip(url, len(url), 3))

    # This is a bit of a hack where we tag the message with a non-printing
    # color so we don't recurse forever
    if not is_colorized(output):
        output = '%s%s' % (output, colorize_string(''))

    xchat.emit_print(userdata, word[0], output)
    return xchat.EAT_XCHAT


# Hook anything that prints a relevant message
xchat.hook_unload(on_unload)
xchat.hook_print('Channel Message', colorize_message, userdata='Channel Message')
xchat.hook_print('Your Message', colorize_message, userdata='Your Message')
xchat.hook_print('Private Message', colorize_message, userdata='Private Message')
xchat.hook_print('Private Message to Dialog', colorize_message, userdata='Private Message to Dialog')


print '%s plugin v%s loaded' % (_color_mod_name, __module_version__)
