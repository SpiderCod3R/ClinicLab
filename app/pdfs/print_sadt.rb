class PrintSadt < Prawn::Document
  def page_layout
    options = {
      page_size: 'A4',
      page_layout: :landscape,
      top_margin: 30
    }
  end

  def initialize(cliente, sadt, relatorio)
    super(page_layout)
    self.font_size = 6
    @cliente = cliente
    @sadt = sadt
    imprime_pdf
    # (0...array.length).step(5).each do |index|
    #   imprime_pdf
    # end
  end

  def formata_data(data)
    if data.present?
      data.strftime("%d/%m/%Y")
    end
  end

  def imprime_pdf
    bounding_box([6, bounds.top], width: 750) do
      exibe_cabecalho
    end
    imprime_item_1
    imprime_item_2
    imprime_item_3
    imprime_item_4
    imprime_item_5
    imprime_item_6
    imprime_item_7
    imprimir_linha_3
    imprime_item_8
    imprime_item_9
    imprime_item_10
    imprime_item_11
    imprime_item_12
    imprimir_linha_5
    imprime_item_13
    imprime_item_14
    imprime_item_15
    imprime_item_16
    imprime_item_17
    imprime_item_18
    imprime_item_19
    imprime_item_20
    imprimir_linha_8
    imprime_item_21
    imprime_item_22
    imprime_item_23
    imprimir_linha_10
    imprimir_linha_11
    imprime_item_29
    imprime_item_30
    imprime_item_31
  end

  def exibe_cabecalho
    move_down 25
    text "GUIA DE SERVIÇO PROFISSIONAL / SERVIÇO AUXILIAR DE", style: :bold, align: :center, size: 9
    text "DIAGNÓSTICO E TERAPIA - SP/SADT", style: :bold, align: :center, size: 9
    image ("public/petrobras_logo.jpg"), height: 40, :at => [30, 23]
  end

  def imprime_item_1
    bounding_box([28, 450], width: 75, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "1 - Registro ANS"
      end
      text "366871", style: :bold, align: :center, size: 7
    end
  end

  def imprime_item_2
    bounding_box([510, 470], width: 75, height: 15) do
      move_down 1
      text "2 - No. Guia no Prestador"
    end
  end

  def imprime_item_3
    bounding_box([105, 450], width: 205, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "3 - Número Guia Principal"
      end
      text "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_4
    bounding_box([28, 433.5], width: 100, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "4 - Data da Autorização"
      end
      text "|___|___|/|___|___|/|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_5
    bounding_box([131, 433.5], width: 205, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "5 - Senha"
      end
      text "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_6
    bounding_box([339, 433.5], width: 100, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "6 - Data de Validade da Senha"
      end
      text "|___|___|/|___|___|/|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_7
    bounding_box([441, 433.5], width: 205, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "7 - Número da Guia Atribuído pela Operadora"
      end
      text "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprimir_linha_3
    bounding_box([28, 418], width: 75, height: 15) do
      table itens_linha_3 do
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

  def itens_linha_3
    [["Dados do Beneficiário"]]
  end

  def imprime_item_8
    bounding_box([28, 410], width: 198, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "8 - Número da Carteira"
      end
      text "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_9
    bounding_box([228, 410], width: 88, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "9 - Validade da Carteira"
      end
      text "|___|___|/|___|___|/|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_10
    bounding_box([318, 410], width: 239, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "10 - Nome"
        if @cliente.nome.present?
          text "#{@cliente.nome}", align: :left, size: 7
        end
      end
    end
  end

  def imprime_item_11
    bounding_box([560, 410], width: 150, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "11 - Cartão Nacional de Saúde"
      end
      text "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_12
    bounding_box([713, 410], width: 65, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "12 - Atendimento a RN"
      end
      text "|___|", align: :center, size: 5
    end
  end

  def imprimir_linha_5
    bounding_box([28, 394], width: 75, height: 15) do
      table itens_linha_5 do
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

  def itens_linha_5
    [["Dados do Solicitante"]]
  end

  def imprime_item_13
    bounding_box([28, 386], width: 150, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "13 - Código na Operadora"
      end
      text "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_14
    bounding_box([180, 386], width: 598, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "14 - Nome do Contratado"
      end
    end
  end

  def imprime_item_15
    bounding_box([28, 369], width: 250, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "15 - Nome do Profissional Solicitante"
      end
    end
  end

  def imprime_item_16
    bounding_box([280, 369], width: 75, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "16 - Conselho Profissional"
      end
      text "|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_17
    bounding_box([357, 369], width: 150, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "17 - Número no Conselho"
      end
      text "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_18
    bounding_box([509.5, 369], width: 30, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "18 - UF"
      end
      text "|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_19
    bounding_box([542, 369], width: 70, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "19 - Código CBO"
      end
      text "|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_20
    bounding_box([615, 369], width: 163, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "20 - Assinatura do Profissional Solicitante"
      end
    end
  end

  def imprimir_linha_8
    bounding_box([28, 353], width: 75, height: 15) do
      table itens_linha_8 do
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

  def itens_linha_8
    [["Dados da Solicitação / Procedimentos e Exames Solicitados"]]
  end

  def imprime_item_21
    bounding_box([28, 345.5], width: 60, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "21 - Caráter do Atendimento", size: 4.6
      end
      move_down 1
      text "|___|", align: :center, size: 5
    end
  end

  def imprime_item_22
    bounding_box([90, 345.5], width: 88, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "22 - Data da Solicitação"
      end
      if @sadt.data.present?
        text "#{formata_data(@sadt.data)}", align: :center
      else
        text "|___|___|/|___|___|/|___|___|___|___|", align: :center, size: 5
      end
    end
  end

  def imprime_item_23
    bounding_box([180, 345.5], width: 598, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "23 - Indicação Clínica"
        if @sadt.indicacao_clinica.present?
          text "#{@sadt.indicacao_clinica}", align: :left, size: 7
        end
      end
    end
  end

  def imprimir_linha_10
    bounding_box([28, 328], width: 75) do
      table itens_linha_10_0 do
        self.width = 750
        column(0).width = 50
        column(1).width = 150
        column(2).width = 400
        column(3..4).width = 75
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = [:top]
        row(0).columns(0).borders = [:left,:top]
        row(0).columns(4).borders = [:right,:top]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_10_1 do
        self.width = 750
        column(0).width = 50
        column(1).width = 150
        column(2).width = 400
        column(3..4).width = 75
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_10_2 do
        self.width = 750
        column(0).width = 50
        column(1).width = 150
        column(2).width = 400
        column(3..4).width = 75
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_10_3 do
        self.width = 750
        column(0).width = 50
        column(1).width = 150
        column(2).width = 400
        column(3..4).width = 75
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_10_4 do
        self.width = 750
        column(0).width = 50
        column(1).width = 150
        column(2).width = 400
        column(3..4).width = 75
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_10_5 do
        self.width = 750
        column(0).width = 50
        column(1).width = 150
        column(2).width = 400
        column(3..4).width = 75
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = [:bottom]
        row(0).columns(0).borders = [:left,:bottom]
        row(0).columns(4).borders = [:right,:bottom]
        style(row(0..row_length), padding: 0, padding_left: 2, padding_bottom: 2)
      end
    end
  end

  def itens_linha_10_0
    [["24 - Tabela","25 - Código do Procedimento", "26 - Descrição", "27 - Qt. Solic.", "28 - Qt. Autoriz."]]
  end

  def itens_linha_10_1
    [["1- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def itens_linha_10_2
    [["2- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def itens_linha_10_3
    [["3- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def itens_linha_10_4
    [["4- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def itens_linha_10_5
    [["5- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def imprimir_linha_11
    bounding_box([28, 283], width: 75, height: 15) do
      table itens_linha_11 do
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

  def itens_linha_11
    [["Dados do Contratado Executante"]]
  end

  def imprime_item_29
    bounding_box([28, 275], width: 150, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "29 - Código na Operadora"
      end
      text "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_30
    bounding_box([180, 275], width: 512, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "30 - Nome do Contratado"
      end
    end
  end

  def imprime_item_31
    bounding_box([694, 275], width: 84, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "31 - Código CNES"
      end
      text "|___|___|___|___|___|___|___|", align: :center, size: 5
    end
  end
end