class SadtGrupo < Connection::Factory
  include ActiveMethods

  belongs_to :sadt
  belongs_to :grupo
  belongs_to :empresa
end
