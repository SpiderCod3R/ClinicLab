require 'rails_helper'

RSpec.describe "receituarios/index", type: :view do
  before(:each) do
    assign(:receituarios, [
      Receituario.create!(
        :nome => "Nome",
        :receita => "MyText"
      ),
      Receituario.create!(
        :nome => "Nome",
        :receita => "MyText"
      )
    ])
  end

  it "renders a list of receituarios" do
    render
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
