module Guia::GuiaInternacaoPetrobrasVerso
  def imprimir_linha_titulo_verso_1
    bounding_box([28, 497.5], width: 75, height: 15) do
      table [["Prorrogacoes"]] do
        self.width = 750
        column(0).width = 750
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0..row_length), size: 6)
        self.position = 0
        self.header = true
        row(0..row_length).columns(0).borders = []
        style(row(0), background_color: 'DEDEDE')
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
    end
  end

  def columns_and_lines
    table itens_linha_1_verso do
      column(0).width = 120
      column(1).width = 150
      column(2).width = 480
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 8)
      self.position = 0
      self.header = false
      row(0).columns(1..1).borders = [:top]
      row(0).columns(0).borders = [:left,:top]
      row(0).columns(2).borders = [:right,:top]
      style(row(0..row_length), padding: 0, padding_left: 2)
    end
    table linha_1_verso_itens do
      self.width = 750
      column(0).width = 120
      column(1).width = 150
      column(2).width = 480
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..1).borders = []
      row(0).columns(0).borders = [:left]
      row(0).columns(2).borders = [:right]
      style(row(0..row_length), padding: 0, padding_top: 2, padding_left: 2)
    end
    table itens_linha_2_verso do
      self.width = 750
      column(0).width = 60
      column(1).width = 600
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..1).borders = []
      row(0).columns(0).borders = [:left]
      row(0).columns(2).borders = [:right]
      style(row(0..row_length), padding: 0, padding_top: 4, padding_left: 2)
    end
    table linha_2_verso_itens do
      self.width = 750
      column(0).width = 60
      column(1).width = 600
      column(2).width = 90
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..1).borders = []
      row(0).columns(0).borders = [:left]
      row(0).columns(2).borders = [:right]
      style(row(0..row_length), padding: 0, padding_top: 8, padding_left: 2)
    end
    table itens_linha_3_verso do
      self.width = 750
      column(0).width = 60
      column(1).width = 155
      column(2).width = 444
      column(3).width = 45
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..4).borders = []
      row(0).columns(0).borders = [:left]
      row(0).columns(4).borders = [:right]
      style(row(0..row_length), padding: 0, padding_top: 8, padding_left: 2)
    end
    table linha_3_verso_itens do
      self.width = 750
      column(0).width = 60
      column(1).width = 155
      column(2).width = 444
      column(3).width = 40
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..4).borders = []
      row(0).columns(0).borders = [:left]
      row(0).columns(4).borders = [:right]
      style(row(0..row_length), padding: 0, padding_top: 10, padding_left: 2)
    end
    table linha_3_verso_itens do
      self.width = 750
      column(0).width = 60
      column(1).width = 155
      column(2).width = 444
      column(3).width = 40
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..4).borders = []
      row(0).columns(0).borders = [:left]
      row(0).columns(4).borders = [:right]
      style(row(0..row_length), padding: 0, padding_top: 12, padding_left: 2)
    end
    table itens_linha_4_verso do
      self.width = 750
      column(0).width = 48
      column(1).width = 155
      column(2).width = 202
      column(3).width = 48
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..4).borders = []
      row(0).columns(0).borders = [:left]
      row(0).columns(5).borders = [:right]
      style(row(0..row_length), padding: 0, padding_top: 8, padding_left: 2)
    end
    table linha_4_verso_itens do
      self.width = 750
      column(0).width = 48
      column(1).width = 155
      column(2).width = 202
      column(3).width = 48
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..4).borders = []
      row(0).columns(0).borders = [:left]
      row(0).columns(5).borders = [:right]
      style(row(0..row_length), padding: 0, padding_top: 8, padding_left: 2)
    end
    table linha_4_verso_itens do
      self.width = 750
      column(0).width = 48
      column(1).width = 155
      column(2).width = 202
      column(3).width = 48
      row(0..row_length).align = :left
      style(row(0), size: 6)
      style(row(1..row_length), size: 5)
      self.position = 0
      self.header = false
      row(0).columns(1..4).borders = [:bottom]
      row(0).columns(0).borders = [:left, :bottom]
      row(0).columns(5).borders = [:right, :bottom]
      style(row(0..row_length), padding: 0, padding_top: 12, padding_left: 2, padding_bottom: 4)
    end
  end

  def imprimir_itens_verso_55_a_71
    bounding_box([28, 490], width: 750) do
      columns_and_lines
    end
  end

  def imprimir_itens_verso_55_a_71_pt2
    bounding_box([28, 330], width: 750) do
      columns_and_lines
    end
  end

  def imprimir_itens_verso_55_a_71_pt3
    bounding_box([28, 170], width: 750) do
      columns_and_lines
    end
  end

  def itens_linha_1_verso
    [["55 - Data","56 - Senha", "57 - Responsável pela Autorização"]]
  end

  def linha_1_verso_itens
    [["|____|____| / |____|____| / |____|____|","________________________________________", "____________________________________________________________________________________________________________________________________________"]]
  end

  def itens_linha_2_verso
    [["58 - Tipo Acomod.","59 - Acomodação", "60 - Qtde. Autorizada"]]
  end

  def linha_2_verso_itens
    [["|____|____|","__________________________________________________________________________________________________________________________________________________________________________________","|_____|_____|"]]
  end

  def itens_linha_3_verso
    [["61 - Tabela","62 - Código de Procedimento", "63 - Descrição","64 - Qtde. Solic.","65 - Qtde. Aut."]]
  end

  def linha_3_verso_itens
    [["|____|____|","|____|____|____|____|____|____|____|____|____|____|", "___________________________________________________________________________________________________________________________________","|_____|_____|","|_____|_____|"]]
  end

  def itens_linha_4_verso
    [["66 - Tabela","67 - Código do OPM", "68 - Descrição OPM","69 - Qtde.","70 - Fabricante", "71 - Valor Unitário"]]
  end

  def linha_4_verso_itens
    [["|____|____|","|____|____|____|____|____|____|____|____|____|____|", "__________________________________________________________","|_____|_____|","________________________________________", "|_____|_____|_____|_____|_____|_____|,|_____|_____|"]]
  end
end