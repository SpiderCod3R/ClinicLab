Rails.application do |config|
  config.time_zone = 'Brasilia'
  config.generators do |g|
    g.assets         false
    g.helper         false
    g.test_framework nil
  end
  config.i18n.default_locale = :"pt-BR"
  config.middleware.use ActionDispatch::Flash

  # Use Pry instead of IRB
  silence_warnings do
    begin
      require "pry"
      console do
          config.console=Pry
      end
      rescue LoadError
    end
  end
end 