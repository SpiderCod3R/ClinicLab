$(document).ready ->
  # Variaveis
  URL_BASE = window.location.origin + '/'
  i=0
  counter= 0
  empresa_id = 0
  usuario_id = 0
  data_usuario_permissoes = []
  checked_admin = false

  # => Localizando quantas permissoes existem na empresa
  # ainda não adicionadas no funcionario no form do create
  if $('#new_painel_usuario').length
    empresa_id = $("#painel_usuario_empresa_id").val()
    counter = $("#empresa_permissoes_count").text()

  $('#painel_usuario_admin').change ->
    checked_admin = this.checked ? true : false
    if checked_admin == true
      $('#permissoes_empresa').slideUp(500)
    else
      $('#permissoes_empresa').slideDown(1000)

  coleta_permissoes = (i, checked_admin) ->
    # => While necessario para percorrer todas as permissoes
    # estejam elas marcadas ou não!
    c = 0
    r = 0
    u = 0
    d = 0
    if checked_admin == false
      while i <= counter
        # => Localizando a Div da permissao
        indice_externo = $("#indice_externo_#{i}")

        if indice_externo.val() != undefined
          # => Localizando o id da permissao
          permissao_id = indice_externo.find("input").closest("#painel_usuario_permissao_id").val()

          # => Localizando as permissões de CRUD
          inputs = indice_externo.find("input:checked")
          c = inputs.closest("#painel_usuario_cadastrar").val()
          r = inputs.closest("#painel_usuario_exibir").val()
          u = inputs.closest("#painel_usuario_atualizar").val()
          d = inputs.closest("#painel_usuario_deletar").val()

          # Em caso do checkbox nao estar marcado
          if indice_externo.find("input:checked").closest("#painel_usuario_cadastrar").val() == undefined
            c = "0"
          if indice_externo.find("input:checked").closest("#painel_usuario_exibir").val() == undefined
            r = "0"
          if indice_externo.find("input:checked").closest("#painel_usuario_atualizar").val() == undefined
            u = "0"
          if indice_externo.find("input:checked").closest("#painel_usuario_deletar").val() == undefined
            d = "0"

          # => Adicionando dados das permissoes do usuario no Hash
          data_usuario_permissoes.push
            'permissao_id' : permissao_id
            'cadastrar'    : c
            'exibir'       : r
            'atualizar'    : u
            'deletar'      : d
        i++

  ajax_request = (usuario_params, permissoes_params, PATH) ->
    $.ajax
      url: URL_BASE + PATH
      type: 'POST'
      dataType: 'JSON'
      data:
        usuario_permissoes: permissoes_params,
        usuario: usuario_params
      timeout: 10000
      success: (response) ->
        if response.usuario.invalid == false
          setTimeout (->
            toastr.info(response.message.success, "Sucesso!", {timeOut: 3000})
          ), 2000
          setTimeout (->
            window.location.href="/painel/empresas/#{empresa_id}/contas?locale=pt-BR"
          ), 5000
        else
          x =0
          $("#error_explanation").css("display", "block")
          $("#error_explanation").find("#erros_count").empty()
          $("#error_explanation").find("#messages").empty()
          $("#error_explanation").find("#erros_count").append("#{response.message_count} erros foram encontrados")
          while x <= response.messages.length
            if x >= response.messages.length
              break
            else
              $("#error_explanation").find("#messages").append("<li> #{response.messages[x].field} - #{response.messages[x].value} </li>")
            x++

  $('#new_painel_usuario').submit (event) ->
    event.preventDefault()
    data_usuario = []

    empresa_id = $("#painel_usuario_empresa_id").val()
    inputs = ""
    indice_externo = ""
    permissao_id = ""
    c = 0
    r = 0
    u = 0
    d = 0

    coleta_permissoes(i, checked_admin)

    # => Adicionando dados do usuario no HASH
    data_usuario.push
        'empresa_id'            : empresa_id
        'nome'                  : $("#painel_usuario_nome").val()
        'login'                 : $("#painel_usuario_login").val()
        'email'                 : $("#painel_usuario_email").val()
        'codigo_pais'           : $("#painel_usuario_codigo_pais").val()
        'telefone'              : $("#painel_usuario_telefone").val()
        'password'              : $("#painel_usuario_password").val()
        'password_confirmation' : $("#painel_usuario_password").val()
        'admin'                 : checked_admin
    # => AJAX request para enviar dados ao controller
    PATH = "painel/empresas/#{empresa_id}/nova_conta"
    ajax_request(data_usuario, data_usuario_permissoes, PATH)


  $('#edit_permissoes_usuario').submit (event) ->
    event.preventDefault()
    data_usuario = []
    data_usuario_permissoes = []

    empresa_id = $("#painel_usuario_empresa_id").val()
    usuario_id = $("#painel_usuario_id").val()
    counter    = $("#empresa_permissoes_count").text()

    inputs = ""
    indice_externo = ""
    permissao_id = ""

    coleta_permissoes(i, false)

    # => Adicionando dados do usuario no HASH
    data_usuario.push
      'empresa_id' : empresa_id
      'usuario_id' : usuario_id

    PATH = "painel/empresas/#{empresa_id}/painel_usuarios/#{usuario_id}/save_permissions"
    ajax_request(data_usuario, data_usuario_permissoes, PATH)