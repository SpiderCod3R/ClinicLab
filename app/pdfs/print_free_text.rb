require "prawn"
class PrintFreeText < TemplatePdf
  include ActionView::Helpers::SanitizeHelper
  attr_accessor :resource

  def initialize(cliente, resource, relatorio)
    super(cliente, resource, relatorio)
    @resource = resource
    @relatorio = relatorio
    imprime_pdf
  end

  def remove_html(string)
    sanitize(string, :tags => {}) # empty tags hash tells it to allow no tags
  end

  def imprime_pdf
    bounding_box([0, 580], width: 522, height: 620) do
      text remove_html(@resource), align: :justify
    end
  end
end
