$(document).ready ->
  $('#cliente_foto').change ->
    $("#foto_contato_selected").text("Arquivo selecionado - " + $('#cliente_foto').val().replace(/C:\\fakepath\\/i, ''))
    $("#foto_contato_selected").animate({ color: "#253095" }, 1000);