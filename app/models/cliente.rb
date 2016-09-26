class Cliente < ApplicationRecord
  before_save :upcased_attributes

  scope :pelo_nome, -> { order("nome ASC") }

  validates_presence_of :nome, :cpf, :endereco, :bairro,
            :nascimento, :sexo, :rg, :estado_civil, :telefone,
            :status_convenio, :matricula, :plano, :validade_carteira,
            :produto, :titular

  validates_associated :cargo, :estado, :cidade, :convenio, :empresa

  usar_como_cpf :cpf

  before_create :set_status_cliente
  before_save :upcased_attributes

  belongs_to :estado
  belongs_to :cidade
  belongs_to :cargo
  belongs_to :convenio
  belongs_to :empresa
  has_many :historicos
  accepts_nested_attributes_for :historicos, allow_destroy: true

  has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\Z/

  def set_status_cliente
    self.status = 'Ativo'
  end

  def upcased_attributes
    self.nome.upcase!
    # self.sexo.upcase!
    # self.estado_civil.upcase!
    self.bairro.upcase!
  end

  class << self
    def da_empresa(resource)
      where(empresa_id: resource)
    end
  end

  def atualiza_cliente(params)
    @cliente = Cliente.find(params[:id])
    if params[:status].present?
      @cliente.update_columns(status: params[:status])
    end
    if params[:nome].present?
      @cliente.update_columns(nome: params[:nome].upcase)
    end
    if params[:cpf].present?
      @cliente.update_columns(cpf: params[:cpf])
    end
    if params[:endereco].present?
      @cliente.update_columns(endereco: params[:endereco])
    end
    if params[:complemento].present?
      @cliente.update_columns(complemento: params[:complemento])
    end
    if params[:bairro].present?
      @cliente.update_columns(bairro: params[:bairro].upcase)
    end
    if params[:estado_id].present?
      @cliente.update_columns(estado_id: params[:estado_id])
    end
    if params[:cidade_id].present?
      @cliente.update_columns(cidade_id: params[:cidade_id])
    end
    if params[:empresa_id].present?
      @cliente.update_columns(empresa_id: params[:empresa_id])
    end
    if params[:foto].present?
      @cliente.update_columns(foto: params[:foto])
    end
    if params[:telefone].present?
      @cliente.update_columns(telefone: params[:telefone])
    end
    if params[:email].present?
      @cliente.update_columns(email: params[:email])
    end
    if params[:cargo_id].present?
      @cliente.update_columns(cargo_id: params[:cargo_id])
    end
    if params[:status_convenio].present?
      @cliente.update_columns(status_convenio: params[:status_convenio])
    end
    if params[:matricula].present?
      @cliente.update_columns(matricula: params[:matricula])
    end
    if params[:plano].present?
      @cliente.update_columns(plano: params[:plano])
    end
    if params[:validade_carteira].present?
      @cliente.update_columns(validade_carteira: I18n.l(Date.parse(params[:validade_carteira]), format: :english))
    end
    if params[:produto].present?
      @cliente.update_columns(produto: params[:produto])
    end
    if params[:titular].present?
      @cliente.update_columns(titular: params[:titular])
    end
    if params[:convenio_id].present?
      @cliente.update_columns(convenio_id: params[:convenio_id])
    end
    if params[:nascimento].present?
      @cliente.update_columns(nascimento: I18n.l(Date.parse(params[:nascimento]), format: :english))
    end
    if params[:sexo].present?
      @cliente.update_columns(sexo: params[:sexo])
    end
    if params[:rg].present?
      @cliente.update_columns(rg: params[:rg])
    end
    if params[:estado_civil].present?
      @cliente.update_columns(estado_civil: params[:estado_civil])
    end
    if params[:nacionalidade].present?
      @cliente.update_columns(nacionalidade: params[:nacionalidade])
    end
    if params[:naturalidade].present?
      @cliente.update_columns(naturalidade: params[:naturalidade])
    end
    return
  end
end
