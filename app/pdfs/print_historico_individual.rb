require "prawn"
class PrintHistoricoIndividual < Prawn::Document
  include ActionView::Helpers::SanitizeHelper
  attr_accessor :resource

  PDF_OPTIONS = {
    :page_size   => "A4",
    :page_layout => :portrait,
    :margin      => [40, 75]
  }

  def initialize(resource)
    super(PDF_OPTIONS)
    @resource = resource
    pdf
  end

  def remove_html(string)
    sanitize(string, :tags => {}) # empty tags hash tells it to allow no tags
  end

  def pdf
    header
    stroke_horizontal_rule
    move_down 50
    font "Courier"
    text remove_html(resource.indice)
  end

  def header
    font "Courier", style: :bold
    text formatDateHour(resource.created_at.to_date, resource.created_at.to_time)
    text resource.usuario.nome
    text resource.idade
  end

  def formatDateHour(date, hour)
    if date.present? && hour.present?
      date.strftime("%d/%m/%Y") + " - " + hour.strftime("%H:%M")
    end
  end
end