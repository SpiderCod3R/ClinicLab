require 'rails_helper'

RSpec.describe "receituarios/new", type: :view do
  before(:each) do
    assign(:receituario, Receituario.new(
      :nome => "MyString",
      :receita => "MyText"
    ))
  end

  it "renders new receituario form" do
    render

    assert_select "form[action=?][method=?]", receituarios_path, "post" do

      assert_select "input#receituario_nome[name=?]", "receituario[nome]"

      assert_select "textarea#receituario_receita[name=?]", "receituario[receita]"
    end
  end
end
