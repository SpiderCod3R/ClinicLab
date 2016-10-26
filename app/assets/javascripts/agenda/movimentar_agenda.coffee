$(document).ready ->
  localhost = window.location.origin

  if $('#agenda_movimentacao_sem_convenio').length
    checked_convenio = this.checked ? true : false
    if checked_convenio == true
      $("#agenda_movimentacao_convenio_id").prop( "disabled", true);
  
  $('#agenda_movimentacao_sem_convenio').change ->
    checked_convenio = this.checked ? true : false
    if checked_convenio
      $("#agenda_movimentacao_convenio_id").prop( "disabled", true);
    else
      $("#agenda_movimentacao_convenio_id").prop( "disabled", false);