vim.api.nvim_create_user_command("ClearRegs", function()
  -- clear all regs from a-z
  for c = string.byte("a"), string.byte("z") do
    vim.fn.setreg(string.char(c), "")
  end

  -- clear all regs from A-Z
  for c = string.byte("A"), string.byte("Z") do
    vim.fn.setreg(string.char(c), "")
  end

  -- clear all regs from 0-9
  for i = 0, 9 do
    vim.fn.setreg(tostring(i), "")
  end

  -- clear all other registers
  local regs = {
    "+", "*", "/", "=", "#", "-", "\"",
  }
  for _, reg in ipairs(regs) do
    vim.fn.setreg(reg, "")
  end

  print("Cleared all registers")
end, {})
