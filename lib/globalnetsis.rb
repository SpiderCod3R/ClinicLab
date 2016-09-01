class Globalnetsis
  attr_reader :nome, :email, :login, :url
  attr_writer :nome, :email, :login, :url

  def initialize(arg)
    @nome  = arg[:nome]
    @email = arg[:email]
    @login = arg[:login]
    @url   = arg[:url]
  end
end