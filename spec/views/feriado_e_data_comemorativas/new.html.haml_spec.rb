require 'rails_helper'

RSpec.describe "feriado_e_data_comemorativas/new", type: :view do
  before(:each) do
    assign(:feriado_e_data_comemorativa, FeriadoEDataComemorativa.new(
      :descricao => "MyString"
    ))
  end

  it "renders new feriado_e_data_comemorativa form" do
    render

    assert_select "form[action=?][method=?]", feriado_e_data_comemorativas_path, "post" do

      assert_select "input#feriado_e_data_comemorativa_descricao[name=?]", "feriado_e_data_comemorativa[descricao]"
    end
  end
end
