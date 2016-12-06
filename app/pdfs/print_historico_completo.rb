require "prawn"
class PrintHistoricoCompleto < Prawn::Document
  include ActionView::Helpers::SanitizeHelper
  attr_accessor :resources

  PDF_OPTIONS = {
    :page_size   => "A4",
    :page_layout => :portrait,
    :margin      => [40, 75]
  }

  def initialize(resources)
    super(PDF_OPTIONS)
    @resources = resources
    pdf
  end

  def remove_html(string)
    sanitize(string, :tags => {}) # empty tags hash tells it to allow no tags
  end

  def pdf
    resources.collect do |resource|
      header(resource)
      stroke_horizontal_rule
      move_down 30
      font "Courier"
      text remove_html(resource.indice)
      move_down 40
    end
  end

  def header(resource)
    font "Courier", style: :bold
    text formatDateHour(resource.created_at.to_date, resource.created_at.to_time)
    text "Elaborado por - #{resource.usuario.nome}"
    text "Cliente - #{resource.cliente.nome}"
    text resource.idade
  end

  def formatDateHour(date, hour)
    if date.present? && hour.present?
      date.strftime("%d/%m/%Y") + " - " + hour.strftime("%H:%M")
    end
  end
end