class TemplatePdf < Prawn::Document
  def page_layout
    options = {
      page_size: 'A4',
      page_layout: :portrait,
      top_margin: 20
    }
  end

  def initialize(resource, relatorio, titulo)
    super(page_layout)
    self.font_size = 10
    @resource = resource
    @relatorio = relatorio
    @titulo     = titulo
    imprimir_pdf
  end

  def imprimir_pdf
    formata_datas
    exibir_cabecalho
    exibir_itens
  end

  def formata_datas
    @data = Time.zone.now.strftime('%d/%m/%Y')
    @hora = Time.zone.now.strftime('%H:%M')
  end

  def exibir_cabecalho
    repeat(:all) do
      bounding_box([bounds.left, bounds.top], width: 320) do
        text "#{@relatorio.nome.upcase}", style: :bold
      end
      bounding_box([390, bounds.top], width: 200) do
        text "Emissão: #{@data} - #{@hora}", style: :bold
      end
      text @titulo, style: :bold, size: 12, align: :center
      line [0, 730], [522, 730]
      stroke
    end
  end

  def exibir_itens
    bounding_box([0, 650], width: 522, height: 600) do
      table itens_tabela do
        row(0).font_style = :bold
        row(0..row_length).align = :center
        self.width  = 522
        self.header = true
        style(row(0), background_color: 'DDDDDD')
      end
    end
  end
end
