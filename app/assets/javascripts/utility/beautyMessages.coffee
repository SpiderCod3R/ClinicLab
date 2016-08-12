toastr.options =
  'closeButton': false
  'debug': false
  'newestOnTop': false
  'progressBar': true
  'positionClass': 'toast-top-right'
  'preventDuplicates': true
  'showDuration': '300'
  'hideDuration': '1000'
  'timeOut': '5000'
  'extendedTimeOut': '1000'
  'showEasing': 'swing'
  'hideEasing': 'linear'
  'showMethod': 'fadeIn'
  'hideMethod': 'fadeOut'

$('document').ready ->
  flashInfo = $('.flash').first()
  if flashInfo.length
    type = flashInfo.data('type')
    message = flashInfo.data('message')
    if type == 'success'
      toastr.success(message)
    if type == 'error' || type == 'alert'
      toastr.error(message)
    if type == 'warning'
      toastr.warning(message)
    if type == 'info'
      toastr.info(message)
  return