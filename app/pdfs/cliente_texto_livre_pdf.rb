class ClienteTextoLivrePdf < Prawn::Document
  def page_layout
    options = {
      page_size: 'A4',
      page_layout: :portrait,
      top_margin: 20
    }
  end

  def initialize(resource)
    super(page_layout)
    self.font_size = 12
    raw_content(resource.content_data)
  end

  def raw_content(content)
    text ActionView::Base.full_sanitizer.sanitize(content)
  end
end
