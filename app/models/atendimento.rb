class Atendimento < ApplicationRecord
  include MetodosUteis
  include ActiveModel::Validations
  before_save :upcased_attributes

  belongs_to :convenio
  belongs_to :estado
  belongs_to :cidade
  belongs_to :empresa

  # validates_associated :estado, :cidade

  validates :nome, :rg, :cpf, :data_nascimento,
            :telefone, :nome_da_mae, :endereco,
            :bairro, :estado_id, :cidade_id, :data, :hora, presence: true

  validate :valida_paciente, on: :create

  def to_s
    "Atendimento do paciente - #{nome} - #{rg}"
  end

  def valida_paciente
    @paciente_com_cpf = Paciente.find_by(cpf: self.cpf)
    @paciente_com_rg = Paciente.find_by(rg: self.rg)
    if @paciente_com_cpf.present?
      if self.cpf.eql?(@paciente_com_cpf.cpf) && self.nome != @paciente_com_cpf.nome
        errors.add(:base, "CPF - #{@paciente_com_cpf.cpf} - já está em uso.")
      end
    end
    if @paciente_com_rg.present?
      if self.rg.eql?(@paciente_com_rg.rg) && self.nome != @paciente_com_rg.nome
        errors.add(:base, "RG - #{@paciente_com_rg.rg} - já está em uso.")
      end
    end
  end


  def manipula_paciente(resource)
    @paciente = Paciente.find_by(cpf: resource[:cpf])
    if @paciente.present?
      @paciente.update_attributes(empresa_id: self.empresa_id, nome: resource[:nome],
          nome_da_mae: resource[:nome_da_mae], rg: resource[:rg], cpf: resource[:cpf],
          telefone: resource[:telefone], celular: resource[:celular], estado_id: resource[:estado_id],
          cidade_id: resource[:cidade_id], endereco: resource[:endereco],
          bairro: resource[:bairro], convenio_id: resource[:convenio_id],
          data_nascimento: resource[:data_nascimento], cep: resource[:cep])
    else
      Paciente.create(empresa_id: self.empresa_id, nome: resource[:nome],
          nome_da_mae: resource[:nome_da_mae], rg: resource[:rg], cpf: resource[:cpf],
          telefone: resource[:telefone], celular: resource[:celular], estado_id: resource[:estado_id],
          cidade_id: resource[:cidade_id], endereco: resource[:endereco],
          bairro: resource[:bairro], convenio_id: resource[:convenio_id],
          data_nascimento: resource[:data_nascimento], cep: resource[:cep])
    end
  end

  def create_resource(resource)
    if self.save
      manipula_paciente(resource)
      return [self, { :success =>  I18n.t('flash.actions.create.success', resource_name: "Atendimento") }]
    else
      return [self, { :error =>  I18n.t('flash.actions.create.alert', resource_name: "Atendimento") }]
    end
  end

  def update_resource(resource)
    manipula_paciente(resource)

    if self.save
      return [self, { :success =>  I18n.t('flash.actions.update.success', resource_name: "Atendimento") }]
    else
      return [self, { :error =>  I18n.t('flash.actions.update.alert', resource_name: "Atendimento") }]
    end
  end

  def upcased_attributes
    self.nome.upcase!
    self.nome_da_mae.upcase!
    self.endereco.upcase!
    self.bairro.upcase!
  end
end
