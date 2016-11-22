Rails.application do |config|
  # Use the responders controller from the responders gem
  config.app_generators.scaffold_controller :responders_controller
  config.time_zone = 'Brasilia'
  config.generators do |g|
    g.assets         false
    g.helper         false
    g.test_framework nil
  end
  config.i18n.default_locale = :"pt-BR"
  config.middleware.use ActionDispatch::Flash
  config.tinymce.install = :copy

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

  # => configurando caminhos a serem carregados automaticamente com rails-s
  config.autoload_paths += %W(
    #{config.root}/app/controllers/concerns
    #{config.root}/app/models/concerns
    #{config.root}/lib/
    #{config.root}/app/pdfs
    #{config.root}/public/assets
  )
end 