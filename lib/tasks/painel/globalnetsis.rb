module Globalnetsis
  class Secret
    attr_accessor :key
    def self.make
      @key = "#gsuper4582?"
    end
  end

  class Credentials
    attr_reader :nome, :email, :login, :url
    attr_writer :nome, :email, :login, :url

    def initialize(arg)
      find_credentials({
        nome:  arg.nome,
        email: arg.email,
        login: arg.login,
        url: '/painel/admins/sign_in'
      })
    end

    def find_credentials(resource)
      @nome  = resource[:nome]
      @email = resource[:email]
      @login = resource[:login]
      @url   = resource[:url]
    end
  end
end