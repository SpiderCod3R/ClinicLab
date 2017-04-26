require 'rails_helper'

RSpec.describe "feriado_e_data_comemorativas/index", type: :view do
  before(:each) do
    assign(:feriado_e_data_comemorativas, [
      FeriadoEDataComemorativa.create!(
        :descricao => "Descricao"
      ),
      FeriadoEDataComemorativa.create!(
        :descricao => "Descricao"
      )
    ])
  end

  it "renders a list of feriado_e_data_comemorativas" do
    render
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
  end
end
