$(document).ready ->
  $('#imagens_externas_foto_antes').change ->
    $("#foto_antes_selected").text("Arquivo selecionado - " + $('#imagens_externas_foto_antes').val().replace(/C:\\fakepath\\/i, ''))
    $("#foto_antes_selected").animate({ color: "#253095" }, 1000);

  $('#imagens_externas_foto_depois').change ->
    $("#foto_depois_selected").text("Arquivo selecionado - " + $('#imagens_externas_foto_depois').val().replace(/C:\\fakepath\\/i, ''))
    $("#foto_depois_selected").animate({ color: "#253095" }, 1000);