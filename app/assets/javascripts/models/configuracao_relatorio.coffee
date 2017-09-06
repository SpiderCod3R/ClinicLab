$(document).ready ->
  $('#configuracao_relatorio_logo').change ->
    $("#logo_selected").text("Arquivo selecionado - " + $('#configuracao_relatorio_logo').val().replace(/C:\\fakepath\\/i, ''))
    $("#logo_selected").animate({ color: "#253095" }, 1000);