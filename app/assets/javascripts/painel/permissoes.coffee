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
  if $('#new_gclinic_user').length
    empresa_id = $("#gclinic_user_empresa_id").val()
    counter = $("#empresa_permissoes_count").text()

  $('#painel_usuario_admin').change ->
    checked_admin = this.checked ? true : false
    if checked_admin == true
      $('#permissoes_empresa').slideUp(500)
    else
      $('#permissoes_empresa').slideDown(1000)

  coleta_permissoes = (checked_admin) ->
    ary = []
    x=1
    # => While necessario para percorrer todas as permissoes
    # estejam elas marcadas ou não!
    c = 0
    r = 0
    u = 0
    d = 0
    if checked_admin == false
      while x <= counter
        # => Localizando a Div da permissao
        indice_externo = $("#indice_externo_#{x}")
        if indice_externo.val() != undefined
          # => Localizando o id da permissao
          permissao_id = indice_externo.find("input").closest("#gclinic_user_model_id").val()

          # => Localizando as permissões de CRUD
          inputs = indice_externo.find("input:checked")

          c = inputs.closest("#gclinic_user_cadastrar").val()
          r = inputs.closest("#gclinic_user_exibir").val()
          u = inputs.closest("#gclinic_user_atualizar").val()
          d = inputs.closest("#gclinic_user_deletar").val()
          # Em caso do checkbox nao estar marcado
          if indice_externo.find("input:checked").closest("#gclinic_user_cadastrar").val() == undefined
            c = "0"
          if indice_externo.find("input:checked").closest("#gclinic_user_exibir").val() == undefined
            r = "0"
          if indice_externo.find("input:checked").closest("#gclinic_user_atualizar").val() == undefined
            u = "0"
          if indice_externo.find("input:checked").closest("#gclinic_user_deletar").val() == undefined
            d = "0"

          # => Adicionando dados das permissoes do usuario no Hash
          ary.push
            'permissao_id' : permissao_id
            'cadastrar'    : c
            'exibir'       : r
            'atualizar'    : u
            'deletar'      : d
        x++
      return ary

  ajax_request = (usuario_params, permissoes_params, PATH) ->
    $.ajax
      url: URL_BASE + PATH
      type: 'POST'
      dataType: 'JSON'
      data:
        usuario_permissoes: permissoes_params,
        usuario: usuario_params
      success: (response) ->
        setTimeout (->
          toastr.success(response.messages.success, "Sucesso!", {timeOut: 5000})
        ), 2000
        setTimeout (->
          window.location.href="/empresa/#{response.environment.url}/contas?locale=pt-BR"
        ), 5000

  $('#new_gclinic_user').submit (event) ->
    event.preventDefault()
    data_usuario = []

    empresa_id = $("#gclinic_user_empresa_id").val()
    inputs = ""
    indice_externo = ""
    permissao_id = ""

    # => Adicionando dados do usuario no HASH
    data_usuario.push
      'empresa_id'            : empresa_id
      'nome'                  : $("#gclinic_user_name").val()
      'email'                 : $("#gclinic_user_email").val()
      'password'              : $("#gclinic_user_password").val()
      'password_confirmation' : $("#gclinic_user_password").val()
      'admin'                 : checked_admin

    data_usuario_permissoes = coleta_permissoes(checked_admin)

    # => AJAX request para enviar dados ao controller
    PATH = "painel/empresas/#{empresa_id}/usuarios"

    # console.log data_usuario_permissoes
    ajax_request(data_usuario, data_usuario_permissoes, PATH)


  $('#edit_permissoes_usuario').submit (event) ->
    event.preventDefault()
    data_usuario = []
    data_usuario_permissoes = []

    empresa_id = $("#gclinic_user_empresa_id").val()
    usuario_id = $("#gclinic_user_id").val()
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