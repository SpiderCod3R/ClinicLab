require "rails_helper"

RSpec.describe Agenda, :type => :model do
  context "Sem Fim de Semana" do
    it "Possui um atendimento completo" do
      @agenda = build(:agenda, :atendimento_normal,:horario_completo)
      expect(@agenda).to be_valid 
    end

    # it "deve compor horario em dias uteis" do
      
    # end
  end

  # context "Com Fim de Semana" do
  #   it "Possui um atendimento completo" do
  #     @agenda = build(:agenda_completo_com_fim_de_semana)
  #     expect(@agenda).to be_valid 
  #   end
  # end
end