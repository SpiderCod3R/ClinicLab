class Cidade < Connection::Factory
  include ActiveMethods

  belongs_to :estado

  def to_s
    "#{nome}"
  end

  def cidade_params
    params.require(:cidade).permit(:nome)
  end
end
