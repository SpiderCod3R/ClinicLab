require 'rails_helper'

RSpec.describe "feriado_e_data_comemorativas/edit", type: :view do
  before(:each) do
    @feriado_e_data_comemorativa = assign(:feriado_e_data_comemorativa, FeriadoEDataComemorativa.create!(
      :descricao => "MyString"
    ))
  end

  it "renders the edit feriado_e_data_comemorativa form" do
    render

    assert_select "form[action=?][method=?]", feriado_e_data_comemorativa_path(@feriado_e_data_comemorativa), "post" do

      assert_select "input#feriado_e_data_comemorativa_descricao[name=?]", "feriado_e_data_comemorativa[descricao]"
    end
  end
end
