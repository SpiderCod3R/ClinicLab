require "prawn"
class PrintRecipe < TemplatePdf
  include ActionView::Helpers::SanitizeHelper
  attr_accessor :resource

  def initialize(resource, relatorio, titulo)
    super(resource, relatorio, titulo)
    @resource = resource
    @relatorio = relatorio
    @titulo = titulo
    imprime_pdf
  end

  def remove_html(string)
    sanitize(string, :tags => {}) # empty tags hash tells it to allow no tags
  end

  def imprime_pdf
    bounding_box([0, 680], width: 522, height: 620) do
      text remove_html(resource), align: :justify
    end
    exibe_rodape
  end

  def exibe_rodape
    repeat(:all) do
      bounding_box([0, 40], width: 520, height: 40) do
        text "CNPJ: #{@relatorio.cnpj} - Telefone: #{@relatorio.telefone}", align: :center
        text "#{@relatorio.endereco}, #{@relatorio.bairro}, #{@relatorio.cidade_estado}", align: :center
        text "E-mail:#{@relatorio.email}", align: :center
      end
    end
  end
end