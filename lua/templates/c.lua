local utils = require("new-file-template.utils")

local function source_template(relative_path, filename)
  return [[// vim:fileencoding=utf-8:foldmethod=marker

|cursor|]]
end

local function header_template(relative_path, filename)
  local header_name = vim.split(filename, "%.")[1]
  local header_guard = string.upper(header_name) .. "_H"

  return [[// vim:fileencoding=utf-8:foldmethod=marker

#ifndef ]] .. header_guard .. [[

#define ]] .. header_guard .. [[


|cursor|

#endif // !]] .. header_guard
end

--- @param opts table
---   A table containing the following fields:
---   - `full_path` (string): The full path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `relative_path` (string): The relative path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `filename` (string): The filename of the new file, e.g., "init.lua".
return function(opts)
  local template = {
    { pattern = ".h", content = header_template },
    { pattern = ".c", content = source_template },
  }

  return utils.find_entry(template, opts)
end
