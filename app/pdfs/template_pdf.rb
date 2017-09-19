class TemplatePdf < Prawn::Document
  def page_layout
    options = {
      page_size: 'A4',
      page_layout: :portrait,
      top_margin: 50
    }
  end

  def initialize(cliente, resource, relatorio)
    super(page_layout)
    self.font_size = 10
    @cliente = cliente
    @resource = resource
    @relatorio = relatorio
    imprimir_pdf
  end

  def imprimir_pdf
    formata_datas
    exibir_cabecalho
    # exibir_itens
  end

  def formata_datas
    @data = Time.zone.now.strftime('%d/%m/%Y')
    @hora = Time.zone.now.strftime('%H:%M')
  end

  def exibir_cabecalho
    repeat(:all) do

      bounding_box([10, 690], width: 300, height: 50) do
        text "#{@cliente.nome.upcase}", style: :bold, size: 10, align: :left, valign: :center
      end
      # move_down 100
      # line [0, 700], [522, 700]
      # stroke
      # bounding_box([390, bounds.top], width: 200) do
      draw_text "Emissão: #{@data} - #{@hora}", at: [390, 660]
      # end
    end
  end

  # def exibir_itens
  #   bounding_box([0, 650], width: 522, height: 600) do
  #     table itens_tabela do
  #       row(0).font_style = :bold
  #       row(0..row_length).align = :center
  #       self.width  = 522
  #       self.header = true
  #       style(row(0), background_color: 'DDDDDD')
  #     end
  #   end
  # end
end
