require "prawn"
class PrintHistoricoCompleto < TemplatePdf
  include ActionView::Helpers::SanitizeHelper
  attr_accessor :resources

  PDF_OPTIONS = {
    :page_size   => "A4",
    :page_layout => :portrait,
    :margin      => [40, 75]
  }

  def initialize(resources, relatorio, titulo)
    super(resources, relatorio, titulo)
    @resources = resources
    @relatorio = relatorio
    @titulo = titulo
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

  def exibe_item(resource)
    text formatDateHour(resource.created_at.to_date, resource.created_at.to_time), style: :bold
    text "Elaborado por - #{resource.user.name}", style: :bold
    text "Cliente - #{resource.cliente.nome}", style: :bold
    text resource.idade, style: :bold
    move_down 10
    text remove_html(resource.indice), align: :justify
    move_down 40
  end

  def formatDateHour(date, hour)
    if date.present? && hour.present?
      date.strftime("%d/%m/%Y") + " - " + hour.strftime("%H:%M")
    end
  end
end
