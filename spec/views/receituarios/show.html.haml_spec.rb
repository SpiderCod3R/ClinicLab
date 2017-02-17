require 'rails_helper'

RSpec.describe "receituarios/show", type: :view do
  before(:each) do
    @receituario = assign(:receituario, Receituario.create!(
      :nome => "Nome",
      :receita => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/MyText/)
  end
end
