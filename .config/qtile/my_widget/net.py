# Copyright (c) 2014 Rock Neurotiko
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

import psutil

from libqtile.widget import base


class Net(base.ThreadPoolText):
    """
    Displays interface down and up speed


    Widget requirements: psutil_.

    .. _psutil: https://pypi.org/project/psutil/
    """
    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
            ('format', '{interface}: {down:.2f} {down_unit} \u2193\u2191 {up:.2f} {up_unit}',
         'Display format of down/upload/total speed of given interfaces'),
        ('interface', '', 'One possible interface, can be obtained with "ip link". \
            Empty string displays all active NICs combined'),
        ('update_interval', 1, 'The update interval.'),
        ('binary_prefix', True, 'binary or decimal prefix'),
    ]

    def __init__(self, **config):
        super().__init__("", **config)
        self.add_defaults(Net.defaults)
        self.stats = self.get_stats()

    def get_stats(self):
        if self.interface == '':
            return psutil.net_io_counters(pernic=False)
        else:
            try:
                return psutil.net_io_counters(pernic=True)[self.interface]
            except KeyError:
                raise KeyError(f'No interface {self.interface}')

    def bytes2human(self, num_bytes):
        """Converts the number of bytes to human readable format."""
        factor = 1024 if self.binary_prefix else 1000
        prefixes = iter(['', 'k', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y'])
        prefix = next(prefixes)

        while num_bytes >= factor:
            num_bytes /= factor
            prefix = next(prefixes)

        unit = prefix
        if unit != '' and self.binary_prefix:
            unit += 'i'
        unit += 'B/s'

        return num_bytes, unit

    def poll(self):
        new_stats = self.get_stats()
        down = (new_stats.bytes_recv - self.stats.bytes_recv)/self.update_interval
        up = (new_stats.bytes_sent - self.stats.bytes_sent)/self.update_interval
        self.stats = new_stats

        down, down_unit = self.bytes2human(down)
        up, up_unit = self.bytes2human(up)
            
        val = {}
        val['interface'] = self.interface
        val['down'] = down
        val['down_unit'] = down_unit
        val['up'] = up
        val['up_unit'] = up_unit
        return self.format.format(**val)
