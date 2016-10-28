toastr.options =
  "closeButton": true
  "debug": false
  "newestOnTop": false
  "progressBar": false
  "positionClass": "toast-top-right"
  "preventDuplicates": false
  "onclick": null
  "showDuration": "0"
  "hideDuration": "0"
  "timeOut": "0"
  "extendedTimeOut": "0"
  "showEasing": "swing"
  "hideEasing": "linear"
  "showMethod": "fadeIn"
  "hideMethod": "fadeOut"

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