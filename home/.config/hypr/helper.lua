-- helper functions

local M = {}

local f = io.open("/proc/sys/kernel/hostname", "r")
M.hostname = f:read("*line")

return M
