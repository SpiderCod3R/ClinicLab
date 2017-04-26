require 'rails_helper'

RSpec.describe "feriado_e_data_comemorativas/show", type: :view do
  before(:each) do
    @feriado_e_data_comemorativa = assign(:feriado_e_data_comemorativa, FeriadoEDataComemorativa.create!(
      :descricao => "Descricao"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Descricao/)
  end
end
