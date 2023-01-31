-- Comment
-- https://github.com/numToStr/Comment.nvim

local status, comment = pcall(require, "Comment")
if not status then
  return
end

comment.setup()
