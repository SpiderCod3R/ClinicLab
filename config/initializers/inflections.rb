# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  # inflect.acronym 'RESTful'
  inflect.irregular 'funcao', 'funcoes'
  inflect.irregular 'texto_live', 'textos_livres'
  inflect.irregular 'imagem_cabec', 'imagens_cabec'
  inflect.irregular 'fornecedor', 'fornecedores'
  inflect.irregular 'cabec', 'cabecs'
  inflect.irregular 'convenio', 'convenios'
  inflect.irregular 'conselho_regional', 'conselho_regionais'
  inflect.irregular 'permissao_empresa', 'permissao_empresas'
  inflect.irregular 'usuario_permissao_empresa', 'usuario_permissao_empresas'
  inflect.irregular 'profissional', 'profissionais'
  inflect.irregular 'centro_de_custo', 'centro_de_custos'
  inflect.irregular 'permissao', 'permissoes'
end
