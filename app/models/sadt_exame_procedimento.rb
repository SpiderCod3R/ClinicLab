class SadtExameProcedimento < Connection::Factory
  include ActiveMethods

  belongs_to :sadt
  belongs_to :exame_procedimento
  belongs_to :empresa
end
