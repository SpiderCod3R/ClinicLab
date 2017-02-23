class Estado < Connection::Factory
  include ActiveMethods

  has_many :cidades

  scope :pelo_nome, -> {order("nome ASC")}
  belongs_to :capital, class_name: 'Cidade', foreign_key: "capital_id"

  def to_s
    "#{nome} - #{sigla}"
  end

  def estado_params
    params.require(:estado).permit(:nome, :sigla, :capital)
  end
end
