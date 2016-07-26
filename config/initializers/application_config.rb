Rails.application do |config|
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
end 