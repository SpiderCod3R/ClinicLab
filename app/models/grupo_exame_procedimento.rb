class GrupoExameProcedimento < Connection::Factory
  include ActiveMethods

  belongs_to :grupo
  belongs_to :exame_procedimento
  belongs_to :empresa
end
