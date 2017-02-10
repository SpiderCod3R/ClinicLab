FactoryGirl.define do
  factory :cliente_permissao do
    usuario_permissoes_id 1
    historico false
    texto_livre false
    pdf_upload "MyString"
  end
end
