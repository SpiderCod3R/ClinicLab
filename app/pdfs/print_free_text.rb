require "prawn"
class PrintFreeText
  include ActionView::Helpers::SanitizeHelper
  attr_accessor :resource

  PDF_OPTIONS = {
    :page_size   => "A4",
    :page_layout => :landscape,
    :margin      => [40, 75]
  }

  def initialize(resource)
    @resource = resource
    pdf
  end

  def remove_html(string)
    sanitize(string, :tags => {}) # empty tags hash tells it to allow no tags
  end

  def pdf
    Prawn::Document.new(PDF_OPTIONS) do |pdf|
      pdf.font "Helvetica"
      pdf.move_down 50
      pdf.text remove_html(resource)
    end
  end

  def render
    pdf.render
  end
end