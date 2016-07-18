module MetodosUteis
  extend ActiveSupport::Concern

  included do 
    def self.retornar_objeto_pelo_id(resource)
      self.find_by_id(resource)
    end

    def self.retornar_objeto_pelo_nome(resource)
      self.find_by_nome(resource)
    end

    def self.da_empresa_atual(resource)
      self.where(empresa_id: resource)
    end

    def associado_com_a_empresa=(empresa_atual)
      self.empresa=empresa_atual
    end

    def salvar
      self.save
    end

    def atualizar(resource)
      self.update(resource)
    end
  end
end
