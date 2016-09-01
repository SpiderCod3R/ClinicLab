Rails.application do |config|
  # Use the responders controller from the responders gem
  config.app_generators.scaffold_controller :responders_controller
  config.time_zone = 'Brasilia'
  config.generators do |g|
    g.assets         false
    g.helper         false
    g.test_framework nil
    g.factory_girl true
  end
  config.i18n.available_locales= "pt-BR"
  config.i18n.default_locale= "pt-BR"
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