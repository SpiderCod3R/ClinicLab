require 'rails_helper'

RSpec.describe "receituarios/edit", type: :view do
  before(:each) do
    @receituario = assign(:receituario, Receituario.create!(
      :nome => "MyString",
      :receita => "MyText"
    ))
  end

  it "renders the edit receituario form" do
    render

    assert_select "form[action=?][method=?]", receituario_path(@receituario), "post" do

      assert_select "input#receituario_nome[name=?]", "receituario[nome]"

      assert_select "textarea#receituario_receita[name=?]", "receituario[receita]"
    end
  end
end
