class PrintSadt < Prawn::Document
  def page_layout
    options = {
      page_size: 'A4',
      page_layout: :landscape,
      top_margin: 30
    }
  end

  def initialize(cliente, sadt, sadt_exame_procedimentos)
    super(page_layout)
    self.font_size = 6
    @cliente = cliente
    @sadt = sadt
    @sadt_exame_procedimentos = sadt_exame_procedimentos
    @cont = 0
    @sadt_exame_procedimentos.each_slice(5) do |array|
      if array[0].present?
        @item_26_1 = array[0]
      else
        @item_26_1 = nil
      end
      if array[1].present?
        @item_26_2 = array[1]
      else
        @item_26_2 = nil
      end
      if array[2].present?
        @item_26_3 = array[2]
      else
        @item_26_3 = nil
      end
      if array[3].present?
        @item_26_4 = array[3]
      else
        @item_26_4 = nil
      end
      if array[4].present?
        @item_26_5 = array[4]
      else
        @item_26_5 = nil
      end
      if @cont > 0
        start_new_page
      end
      imprime_pdf
      @cont +=  1
    end
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
    imprimir_linha_13
    imprime_item_32
    imprime_item_33
    imprime_item_34
    imprime_item_35
    imprimir_linha_15
    imprimir_linha_16
    imprimir_linha_17
    imprimir_linha_18
    imprimir_linha_19
    imprimir_linha_20
    imprime_item_59
    imprime_item_60
    imprime_item_61
    imprime_item_62
    imprime_item_63
    imprime_item_64
    imprime_item_65
    imprime_item_66
    imprime_item_67
    imprime_item_68
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
    bounding_box([28, 328], width: 750) do
      table itens_linha_10_0 do
        self.width = 750
        column(0).width = 35
        column(1).width = 125
        column(2).width = 490
        column(3..4).width = 50
        row(0..row_length).align = :left
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
        column(0).width = 35
        column(1).width = 125
        column(2).width = 490
        column(3..4).width = 50
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      if @item_26_1.present?
        text_box "#{@item_26_1.exame_procedimento.tabela}", :at =>  [15,5.5], character_spacing: 6
        text_box "#{@item_26_1.exame_procedimento.codigo_procedimento}", :at =>  [41.4,5.5], character_spacing: 8
        text_box "#{@item_26_1.exame_procedimento.descricao}", :at =>  [162,5.5]
      end
      table itens_linha_10_2 do
        self.width = 750
        column(0).width = 35
        column(1).width = 125
        column(2).width = 490
        column(3..4).width = 50
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      if @item_26_2.present?
        text_box "#{@item_26_2.exame_procedimento.tabela}", :at =>  [15,5.5], character_spacing: 6
        text_box "#{@item_26_2.exame_procedimento.codigo_procedimento}", :at =>  [41.4,5.5], character_spacing: 8
        text_box "#{@item_26_2.exame_procedimento.descricao}", :at =>  [162,5.5]
      end
      table itens_linha_10_3 do
        self.width = 750
        column(0).width = 35
        column(1).width = 125
        column(2).width = 490
        column(3..4).width = 50
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      if @item_26_3.present?
        text_box "#{@item_26_3.exame_procedimento.tabela}", :at =>  [15,5.5], character_spacing: 6
        text_box "#{@item_26_3.exame_procedimento.codigo_procedimento}", :at =>  [41.4,5.5], character_spacing: 8
        text_box "#{@item_26_3.exame_procedimento.descricao}", :at =>  [162,5.5]
      end
      table itens_linha_10_4 do
        self.width = 750
        column(0).width = 35
        column(1).width = 125
        column(2).width = 490
        column(3..4).width = 50
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      if @item_26_4.present?
        text_box "#{@item_26_4.exame_procedimento.tabela}", :at =>  [15,5.5], character_spacing: 6
        text_box "#{@item_26_4.exame_procedimento.codigo_procedimento}", :at =>  [41.4,5.5], character_spacing: 8
        text_box "#{@item_26_4.exame_procedimento.descricao}", :at =>  [162,5.5]
      end
      table itens_linha_10_5 do
        self.width = 750
        column(0).width = 35
        column(1).width = 125
        column(2).width = 490
        column(3..4).width = 50
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = [:bottom]
        row(0).columns(0).borders = [:left,:bottom]
        row(0).columns(4).borders = [:right,:bottom]
        style(row(0..row_length), padding: 0, padding_left: 2, padding_bottom: 2)
      end
      if @item_26_5.present?
        text_box "#{@item_26_5.exame_procedimento.tabela}", :at =>  [15,7.5], character_spacing: 6
        text_box "#{@item_26_5.exame_procedimento.codigo_procedimento}", :at =>  [41.4,7.5], character_spacing: 8
        text_box "#{@item_26_5.exame_procedimento.descricao}", :at =>  [162,7.5]
      end
    end
  end

  def itens_linha_10_0
    [["24 - Tabela","25 - Código do Procedimento", "26 - Descrição", "27 - Qt. Solic.", "28 - Qt. Autoriz."]]
  end

  def itens_linha_10_1
    [["1- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "________________________________________________________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def itens_linha_10_2
    [["2- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "________________________________________________________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def itens_linha_10_3
    [["3- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "________________________________________________________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def itens_linha_10_4
    [["4- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "________________________________________________________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
  end

  def itens_linha_10_5
    [["5- |___|___|","|___|___|___|___|___|___|___|___|___|___|", "________________________________________________________________________________________________________________________________________________","|___|___|___|","|___|___|___|"]]
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

  def imprimir_linha_13
    bounding_box([28, 259], width: 75, height: 15) do
      table itens_linha_13 do
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

  def itens_linha_13
    [["Dados do Atendimento"]]
  end

  def imprime_item_32
    bounding_box([28, 251], width: 65, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "32 - Tipo Atendimento"
      end
      text "|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_33
    bounding_box([95, 251], width: 170, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "33 - Indicação de Acidente (acidente ou doença relacionada)"
      end
      text "|___|", align: :center, size: 5
    end
  end

  def imprime_item_34
    bounding_box([267, 251], width: 63, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "34 - Tipo de Consulta"
      end
      text "|___|", align: :center, size: 5
    end
  end

  def imprime_item_35
    bounding_box([332.5, 251], width: 130, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "35 - Motivo de Encerramento do Atendimento"
      end
      text "|___|___|", align: :center, size: 5
    end
  end

  def imprimir_linha_15
    bounding_box([28, 235], width: 75, height: 15) do
      table itens_linha_15 do
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

  def itens_linha_15
    [["Dados da Execução / Procedimentos e Exames Realizados"]]
  end

  def imprimir_linha_16
    bounding_box([28, 227], width: 75) do
      table itens_linha_16_0 do
        self.width = 750
        column(0).width = 107
        column(1).width = 56
        column(2).width = 53
        column(3).width = 27
        column(4).width = 119
        column(5).width = 83
        column(6).width = 30
        column(7).width = 16
        column(8).width = 17
        column(9).width = 42
        column(10..11).width = 100
        row(0..row_length).align = :left
        row(0..row_length).columns(6..8).align = :center
        style(row(0), size: 6)
        style(row(0).columns(3..4), size: 5)
        style(row(0).columns(7..8), size: 5)
        style(row(0).columns(9), size: 4)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..10).borders = [:top]
        row(0).columns(0).borders = [:left,:top]
        row(0).columns(11).borders = [:right,:top]
        style(row(0..row_length).columns(0), padding: 0)
        style(row(0..row_length).columns(1..11), padding: 0, padding_left: 1)
      end
      table itens_linha_16_1 do
        self.width = 750
        column(0).width = 107
        column(1).width = 56
        column(2).width = 53
        column(3).width = 27
        column(4).width = 119
        column(5).width = 83
        column(6).width = 30
        column(7).width = 16
        column(8).width = 17
        column(9).width = 42
        column(10..11).width = 100
        row(0..row_length).align = :left
        row(0..row_length).columns(6..8).align = :center
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..10).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(11).borders = [:right]
        style(row(0..row_length).columns(0), padding: 0)
        style(row(0..row_length).columns(1..11), padding: 0, padding_left: 1)
      end
      table itens_linha_16_2 do
        self.width = 750
        column(0).width = 107
        column(1).width = 56
        column(2).width = 53
        column(3).width = 27
        column(4).width = 119
        column(5).width = 83
        column(6).width = 30
        column(7).width = 16
        column(8).width = 17
        column(9).width = 42
        column(10..11).width = 100
        row(0..row_length).align = :left
        row(0..row_length).columns(6..8).align = :center
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..10).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(11).borders = [:right]
        style(row(0..row_length).columns(0), padding: 0)
        style(row(0..row_length).columns(1..11), padding: 0, padding_left: 1)
      end
      table itens_linha_16_3 do
        self.width = 750
        column(0).width = 107
        column(1).width = 56
        column(2).width = 53
        column(3).width = 27
        column(4).width = 119
        column(5).width = 83
        column(6).width = 30
        column(7).width = 16
        column(8).width = 17
        column(9).width = 42
        column(10..11).width = 100
        row(0..row_length).align = :left
        row(0..row_length).columns(6..8).align = :center
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..10).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(11).borders = [:right]
        style(row(0..row_length).columns(0), padding: 0)
        style(row(0..row_length).columns(1..11), padding: 0, padding_left: 1)
      end
      table itens_linha_16_4 do
        self.width = 750
        column(0).width = 107
        column(1).width = 56
        column(2).width = 53
        column(3).width = 27
        column(4).width = 119
        column(5).width = 83
        column(6).width = 30
        column(7).width = 16
        column(8).width = 17
        column(9).width = 42
        column(10..11).width = 100
        row(0..row_length).align = :left
        row(0..row_length).columns(6..8).align = :center
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..10).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(11).borders = [:right]
        style(row(0..row_length).columns(0), padding: 0)
        style(row(0..row_length).columns(1..11), padding: 0, padding_left: 1)
      end
      table itens_linha_16_5 do
        self.width = 750
        column(0).width = 107
        column(1).width = 56
        column(2).width = 53
        column(3).width = 27
        column(4).width = 119
        column(5).width = 83
        column(6).width = 30
        column(7).width = 16
        column(8).width = 17
        column(9).width = 42
        column(10..11).width = 100
        row(0..row_length).align = :left
        row(0..row_length).columns(6..8).align = :center
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..10).borders = [:bottom]
        row(0).columns(0).borders = [:left,:bottom]
        row(0).columns(11).borders = [:right,:bottom]
        # style(row(0..row_length), padding: 0, padding_left: 2, padding_bottom: 2)
        style(row(0..row_length).columns(0), padding: 0, padding_bottom: 2)
        style(row(0..row_length).columns(1..11), padding: 0, padding_left: 1, padding_bottom: 2)
      end
    end
  end

  def itens_linha_16_0
    [["36 - Data", "37 - Hora Inicial", "38 - Hora Final", "39 - Tabela","40 - Código do Procedimento", "41 - Descrição", "42 - Qtde.", "43-Via", "44-Tec.", "45-Fator Red./Acresc.", "46 - Valor Unitário - R$", "47 - Valor Total - R$"]]
  end

  def itens_linha_16_1
    [["1-|___|___|/|___|___|/|___|___|___|___|", "|___|___|:|___|___|a","|___|___|:|___|___|","|___|___|","|___|___|___|___|___|___|___|___|___|___|","________________________","|__|__|__|","|__|","|__|","|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|"]]
  end

  def itens_linha_16_2
    [["2-|___|___|/|___|___|/|___|___|___|___|", "|___|___|:|___|___|a","|___|___|:|___|___|","|___|___|","|___|___|___|___|___|___|___|___|___|___|","________________________","|__|__|__|","|__|","|__|","|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|"]]
  end

  def itens_linha_16_3
    [["3-|___|___|/|___|___|/|___|___|___|___|", "|___|___|:|___|___|a","|___|___|:|___|___|","|___|___|","|___|___|___|___|___|___|___|___|___|___|","________________________","|__|__|__|","|__|","|__|","|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|"]]
  end

  def itens_linha_16_4
    [["4-|___|___|/|___|___|/|___|___|___|___|", "|___|___|:|___|___|a","|___|___|:|___|___|","|___|___|","|___|___|___|___|___|___|___|___|___|___|","________________________","|__|__|__|","|__|","|__|","|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|"]]
  end

  def itens_linha_16_5
    [["5-|___|___|/|___|___|/|___|___|___|___|", "|___|___|:|___|___|a","|___|___|:|___|___|","|___|___|","|___|___|___|___|___|___|___|___|___|___|","________________________","|__|__|__|","|__|","|__|","|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|", "|___|___|___|___|___|___|,|___|___|"]]
  end

  def imprimir_linha_17
    bounding_box([28, 183], width: 75, height: 15) do
      table itens_linha_17 do
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

  def itens_linha_17
    [["Identificação do(s) Profissional(s) Executante(s)"]]
  end

  def imprimir_linha_18
    bounding_box([28, 175], width: 75) do
      table itens_linha_18_0 do
        self.width = 750
        column(0..1).width = 28
        column(2).width = 169
        column(3).width = 195
        column(4).width = 40
        column(5).width = 182
        column(6).width = 33
        column(7).width = 75
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        style(row(0).columns(0..1), size: 4)
        style(row(0).columns(4), size: 4)
        self.position = 0
        self.header = false
        row(0).columns(1..6).borders = [:top]
        row(0).columns(0).borders = [:left,:top]
        row(0).columns(7).borders = [:right,:top]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_18_1 do
        self.width = 750
        column(0..1).width = 28
        column(2).width = 169
        column(3).width = 195
        column(4).width = 40
        column(5).width = 182
        column(6).width = 33
        column(7).width = 75
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..6).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(7).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_18_2 do
        self.width = 750
        column(0..1).width = 28
        column(2).width = 169
        column(3).width = 195
        column(4).width = 40
        column(5).width = 182
        column(6).width = 33
        column(7).width = 75
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..6).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(7).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_18_3 do
        self.width = 750
        column(0..1).width = 28
        column(2).width = 169
        column(3).width = 195
        column(4).width = 40
        column(5).width = 182
        column(6).width = 33
        column(7).width = 75
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..6).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(7).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_18_4 do
        self.width = 750
        column(0..1).width = 28
        column(2).width = 169
        column(3).width = 195
        column(4).width = 40
        column(5).width = 182
        column(6).width = 33
        column(7).width = 75
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..6).borders = [:bottom]
        row(0).columns(0).borders = [:left,:bottom]
        row(0).columns(7).borders = [:right,:bottom]
        style(row(0..row_length), padding: 0, padding_left: 2, padding_bottom: 2)
      end
    end
  end

  def itens_linha_18_0
    [["48 - Seq. Ref", "49 - Grau Part", "50 - Código da Operadora / CPF", "51 - Nome do Profissional", "52 - Conselho Profissional", "53 - Número no Conselho", "54 - UF", "55 - Código CBO"]]
  end

  def itens_linha_18_1
    [["|___|___|", "|___|___|","|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________", "|___|___|", "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", "|___|___|", "|___|___|___|___|___|___|"]]
  end

  def itens_linha_18_2
    [["|___|___|", "|___|___|","|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________", "|___|___|", "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", "|___|___|", "|___|___|___|___|___|___|"]]
  end

  def itens_linha_18_3
    [["|___|___|", "|___|___|","|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________", "|___|___|", "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", "|___|___|", "|___|___|___|___|___|___|"]]
  end

  def itens_linha_18_4
    [["|___|___|", "|___|___|","|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", "_______________________________________________________", "|___|___|", "|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|", "|___|___|", "|___|___|___|___|___|___|"]]
  end

  def imprimir_linha_19
    bounding_box([28, 134], width: 75) do
      table itens_linha_19_0 do
        self.width = 750
        column(0).width = 750
        row(0..row_length).align = :left
        style(row(0), size: 6)
        self.position = 0
        self.header = false
        row(0).columns(0).borders = [:left,:right,:top]
        style(row(0..row_length), padding: 0)
      end
      table itens_linha_19_1 do
        self.width = 750
        column(0..4).width = 150
        row(0..row_length).align = :center
        style(row(0), size: 6)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(4).borders = [:right]
        row(1).columns(1..3).borders = [:bottom]
        row(1).columns(0).borders = [:left,:bottom]
        row(1).columns(4).borders = [:right,:bottom]
        style(row(0..row_length), padding: 0, padding_bottom: 2)
      end
    end
  end

  def itens_linha_19_0
    [["56 - Data de Realização de Procedimento em Série 57 - Assinatura do Beneficiário ou Responsável"]]
  end

  def itens_linha_19_1
    [["1- |___|___|/|___|___|/|___|___|___|___| ___________","3- |___|___|/|___|___|/|___|___|___|___| ___________","5- |___|___|/|___|___|/|___|___|___|___| ___________","7- |___|___|/|___|___|/|___|___|___|___| ___________","9- |___|___|/|___|___|/|___|___|___|___| ___________"],
      ["2- |___|___|/|___|___|/|___|___|___|___| ___________","4- |___|___|/|___|___|/|___|___|___|___| ___________","6- |___|___|/|___|___|/|___|___|___|___| ___________","8- |___|___|/|___|___|/|___|___|___|___| ___________","10-|___|___|/|___|___|/|___|___|___|___| ___________"]]
  end

  def imprimir_linha_20
    bounding_box([28, 107], width: 75, height: 60) do
      table itens_linha_20 do
        self.width = 750
        column(0).width = 750
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0..row_length), size: 6)
        self.position = 0
        self.header = true
        # row(0..row_length).columns(0).borders = []
        style(row(0), background_color: 'DEDEDE')
        style(row(0..row_length), padding: 0, padding_left: 2, padding_bottom: 50)
      end
    end
  end

  def itens_linha_20
    [["58 - Observação / Justificativa"]]
  end

  def imprime_item_59
    bounding_box([28, 48], width: 105, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "59 - Total Procedimentos (R$)"
      end
      text "|___|___|___|___|___|___|,|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_60
    bounding_box([135, 48], width: 105, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "60 - Total Taxas e Aluguéis (R$)"
      end
      text "|___|___|___|___|___|___|,|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_61
    bounding_box([242, 48], width: 105, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "61 - Total Materiais (R$)"
      end
      text "|___|___|___|___|___|___|,|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_62
    bounding_box([349, 48], width: 105, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "62 - Total OPME (R$)"
      end
      text "|___|___|___|___|___|___|,|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_63
    bounding_box([457, 48], width: 105, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "63 - Total de Medicamentos (R$)"
      end
      text "|___|___|___|___|___|___|,|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_64
    bounding_box([565, 48], width: 105, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "64 - Total Gases Medicinais (R$)"
      end
      text "|___|___|___|___|___|___|,|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_65
    bounding_box([673, 48], width: 105, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "65 - Total Geral (R$)"
      end
      text "|___|___|___|___|___|___|,|___|___|", align: :center, size: 5
    end
  end

  def imprime_item_66
    bounding_box([28, 31], width: 249, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "66 - Assinatura do Responsável pela Autorização"
      end
    end
  end

  def imprime_item_67
    bounding_box([278.5, 31], width: 249, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "67 - Assinatura do Beneficiário ou Responsável"
      end
    end
  end

  def imprime_item_68
    bounding_box([529, 31], width: 249, height: 15) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "68 - Assinatura do Contratado"
      end
    end
  end
end