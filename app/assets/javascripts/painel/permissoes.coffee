$(document).ready ->
  # Variaveis
  URL_BASE = window.location.origin + '/'
  data_usuario = []
  data_usuario_permissoes = []
  i= 1
  counter= 0
  empresa_id = 0
  checked_admin = false

  # => Localizando quantas permissoes existem na empresa
  # ainda não adicionadas no funcionario no form do create
  if $('#new_painel_usuario').length
    empresa_id = $("#painel_usuario_empresa_id").val()
    counter = $("#empresa_permissoes_count").text()

  $('#painel_usuario_admin').change ->
    checked_admin = this.checked ? true : false
    if checked_admin == true
      $('#permissoes_empresa').show().slideUp(500)
    else
      $('#permissoes_empresa').show().fadeIn(1000)

  $('#new_painel_usuario').submit (event) ->
    event.preventDefault()
    empresa_id = $("#painel_usuario_empresa_id").val()
    inputs = ""
    div_permissao_id = ""
    permissao_id = ""
    c = 0
    r = 0
    u = 0
    d = 0

    # => While necessario para percorrer todas as permissoes
    # estejam elas marcadas ou não!
    if checked_admin == false
      while i < counter
        # => Localizando a Div da permissao
        div_permissao_id = $("#usuario_permissao_id_#{i}")

        # => Localizando o id da permissao
        permissao_id = div_permissao_id.find("input").closest("#painel_usuario_permissao_id")

        # => Localizando as permissões de CRUD
        inputs = div_permissao_id.find("input:checked")
        c = inputs.closest("#painel_usuario_cadastrar")
        r = inputs.closest("#painel_usuario_exibir")
        u = inputs.closest("#painel_usuario_atualizar")
        d = inputs.closest("#painel_usuario_deletar")

        # Em caso do checkbox nao estar marcado
        if c.val() == undefined
          c.val(false)
        else
          c.val(true)

        if r.val() == undefined
          r.val(false)
        else
          r.val(true)

        if u.val() == undefined
          u.val(false)
        else
          u.val(true)

        if d.val() == undefined
          d.val(false)
        else
          d.val(true)

        # => Adicionando dados das permissoes do usuario no Hash
        data_usuario_permissoes.push
          'permissao_id' : permissao_id.val()
          'cadastrar'    : c.val()
          'exibir'       : r.val()
          'atualizar'    : u.val()
          'deletar'      : d.val()
        i++

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
    $.ajax
      url: URL_BASE + "painel/empresas/#{empresa_id}/painel_usuarios"
      type: 'POST'
      dataType: 'JSON'
      data:
        usuario_permissoes: data_usuario_permissoes,
        usuario: data_usuario
      timeout: 10000
      success: (response) ->
        console.log(response)
        setTimeout (->
          toastr.success(response.messages.success, "Sucesso!", {timeOut: 5000})
        ), 2000
        setTimeout (->
          window.location.href="/painel/empresas/#{empresa_id}/contas?locale=pt-BR"
        ), 5000