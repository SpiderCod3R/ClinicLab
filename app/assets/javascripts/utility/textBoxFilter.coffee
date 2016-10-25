$('.txtboxToFilter').keydown (e) ->
  # Allow: backspace, delete, tab, escape, enter and .
  if $.inArray(e.keyCode, [
      46
      8
      9
      27
      13
      110
      190
    ]) != -1 or e.keyCode == 65 and e.ctrlKey == true or e.keyCode == 67 and e.ctrlKey == true or e.keyCode == 88 and e.ctrlKey == true or e.keyCode >= 35 and e.keyCode <= 39
    # let it happen, don't do anything
    return
  # Ensure that it is a number and stop the keypress
  if (e.shiftKey or e.keyCode < 48 or e.keyCode > 57) and (e.keyCode < 96 or e.keyCode > 105)
    e.preventDefault()
  return