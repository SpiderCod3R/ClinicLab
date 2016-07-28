#-*-coding:utf-8-*-
require "rails_helper"

RSpec.describe Agenda, type: :model do
  let(:agenda_normal) { build(:agenda, :atendimento_normal, :horario_completo) } 

  context "#new" do
    it "nao pode conter horários armazendados (manha/vespertino)" do
      @agenda_manha = build(:agenda).agenda_manha_horarios.length
      @agenda_tarde = build(:agenda).agenda_tarde_horarios.length
      expect(@agenda_manha).to eq(0)
      expect(@agenda_tarde).to eq(0)
    end

    it "por padrão Atendimento['Sabado', 'Domingo', 'Parcial'] devem iniciar com valor 'false' " do
      expect(agenda_normal).to be_valid
    end
  end

  context "#create" do
    context "Sem atendimento no Fim de Semana" do
      it "Deve preencher horários no turno da manha" do
        @agenda_manha = create(:agenda_manha_sem_fim_de_semana).agenda_manha_horarios.length
        expect(@agenda_manha).to eq(5)
      end

      it "deve calcular o horário com base no tempo do atendimento da manha" do
        
      end

      it "Deve preencher horários no turno da tarde" do
        @agenda_tarde = create(:agenda_vespertina_sem_fim_de_semana).agenda_tarde_horarios.length
        expect(@agenda_tarde).to eq(5)
      end
    end
  end

  # context "Com atendimento no sabado" do
    # it "Possui um agendamento de segunda a sabado" do
      # expect(com_sabado).to be_valid 
    # end
 
  #  it "deve compor horarios de segunda a sabado" do
  #    pending "add some examples to (or delete) #{__FILE__}"
  #  end
  # end

  # context "Com atendimento no Domingo" do
  #   it "deve possuir um agendamento integral de segunda a domingo" do
  #     pending "add some examples to (or delete) #{__FILE__}"
  #   end

  #   it "deve compor horarios em tempo integral de segunda a domingo" do
  #     pending "add some examples to (or delete) #{__FILE__}"
  #   end
  # end
end