module Guia::GuiaInternacaoPetrobrasFrente
  def imprime_item_1
    bounding_box([28, position_line_1], width: 120, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "1 - Registro ANS"
      end
      text "", style: :bold, align: :center, size: 7
    end
  end

  def imprime_item_3
    bounding_box([150.5, position_line_1], width: 110, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "3 - Data da Autorização"
        move_down 5
        indent 2 do
          text "|_____|_____| / |_____|_____| / |_____|_____|", align: :left, size: 5
        end
      end
    end
  end

  def imprime_item_4
    bounding_box([263, position_line_1], width: 120, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "4 - Senha"
      end
    end
  end

  def imprime_item_5
    bounding_box([385.8, position_line_1], width: 120, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "5 - Data de Validade da Senha"
        move_down 5
        indent 2 do
          text "|_____|_____| / |_____|_____| / |_____|_____|", align: :center, size: 5
        end
      end
    end
  end

  def imprime_item_6
    bounding_box([509, position_line_1], width: 120, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "6 - Data de Emissão da Guia"
      end
      move_down 5
      text "|_____|_____| / |_____|_____| / |_____|_____|", align: :center, size: 5
    end
  end

  def imprimir_linha_titulo_1
    bounding_box([28, 491], width: 75, height: 22) do
      table [["Dados do Beneficiário"]] do
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

  def imprime_item_7
    bounding_box([28, position_line_2], width: 310, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "7 - Número da Carteira"
      end
      move_down 5
      indent 2 do
        text "|_____"*20 + "|", align: :left, size: 5
      end
    end
  end

  def imprime_item_8
    bounding_box([341.5, position_line_2], width: 106, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "8 - Plano"
      end
    end
  end

  def imprime_item_9
    bounding_box([450.3, position_line_2], width: 120, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "9 - Validade da Carteira"
      end
      move_down 5
      text "|_____|_____| / |_____|_____| / |_____|_____|", align: :center, size: 5
    end
  end

  def imprime_item_10
    bounding_box([28, position_line_3], width: 429, height: field_height) do
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
    bounding_box([459.8, position_line_3], width: 234.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "11 - Cartão Nacional de Saúde"
      end
      move_down 5
      indent 2 do
        text "|_____"*15 + "|", align: :left, size: 5
      end
    end
  end

  def imprimir_linha_titulo_2
    bounding_box([28, 441], width: 75, height: 15) do
      table [["Dados do Contratado Solicitante"]] do
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

  def imprime_item_12
    bounding_box([28, position_line_4], width: 218.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "12 - Código na Operadora / CNPJ / CPF"
      end
      move_down 5
      indent 2 do
        text "|_____"*14 + "|", size: 5
      end
    end
  end

  def imprime_item_13
    bounding_box([249.4, position_line_4], width: 339.2, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "13 - Nome do Contratado"
      end
    end
  end

  def imprime_item_14
    bounding_box([591.4, position_line_4], width: 102, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "14 - Código CNES"
      end
    end
  end

  def imprime_item_15
    bounding_box([28, position_line_5], width: 320, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "15 - Nome do Profissional Solicitante"
      end
    end
  end

  def imprime_item_16
    bounding_box([351.2, position_line_5], width: 108, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "16 - Conselho Profissional"
      end
    end
  end

  def imprime_item_17
    bounding_box([462.2, position_line_5], width: 80, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "17 - Número no Conselho"
      end
    end
  end

  def imprime_item_18
    bounding_box([544.8, position_line_5], width: 44, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "18 - UF"
      end
    end
  end

  def imprime_item_19
    bounding_box([591.5, position_line_5], width: 102, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "19 - Código CBO S"
      end
    end
  end

  def imprimir_linha_titulo_3
    bounding_box([28, 391], width: 75, height: 15) do
      table [["Dados do Contratado Solicitado / Dados da Internação"]] do
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

  def imprime_item_20
    bounding_box([28, position_line_6], width: 218.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "20 - Código na Operadora / CNPJ / CPF"
      end
      move_down 4
      indent 2 do
        text "|_____"*14 + "|", size: 5
      end
    end
  end

  def imprime_item_21
    bounding_box([248.8, position_line_6], width: 349, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "21 - Nome do Prestador", size: 5
      end
    end
  end

  def imprime_item_22
    bounding_box([28, position_line_7], width: 158.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "22 - Caráter de Internação"
      end
      move_down 4
      indent 2 do
        text "|_____|  <b>E</b> - Eletiva  <b>U</b> - Urgência / Emergência", align: :left, :inline_format => true
      end
    end
  end

  def imprime_item_23
    bounding_box([189, position_line_7], width: 409, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "23 - Tipo de Internação"
      end
      move_down 4
      indent 2 do
        text "|_____|  <b>1</b> - Clínica  <b>2</b> - Cirurgíca <b>3</b> - Obstérica <b>4</b> - Pediátrica <b>5</b> - Psiquiátra", align: :left, :inline_format => true
      end
    end
  end

  def imprime_item_24
    bounding_box([28, position_line_8], width: 230, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "24 - Regime de Internação"
      end
      move_down 4
      indent 2 do
        text "|_____|  <b>1</b> - Hospitalar  <b>2</b> - Hospital-dia <b>3</b> - Domiciliar", align: :left, :inline_format => true
      end
    end
  end

  def imprime_item_25
    bounding_box([261, position_line_8], width: 140, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "25 - Qtde. Diárias Solicitadas"
      end
      move_down 4
      indent 2 do
        text "|_____"*3 + "|", align: :left
      end
    end
  end

  def imprime_item_26
    bounding_box([28, 317], width: 751, height: 40) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "26 - Indicação Clínica"
      end
      indent 2 do
        text "_"*221, align: :left
        move_down 2
        text "_"*221, align: :left
        move_down 2
        text "_"*221, align: :left
      end
    end
  end

  def imprimir_linha_titulo_4
    bounding_box([28, 275.8], width: 75, height: 15) do
      table [["Hipóteses Diagnósticas"]] do
        self.width = 750
        column(0).width = 750
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0..row_length), size: 6)
        self.position = 0
        self.header   = true
        row(0..row_length).columns(0).borders = []
        style(row(0), background_color: 'DEDEDE')
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
    end
  end

  def imprime_item_27
    bounding_box([28, position_line_9], width: 125.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "27 - Tipo Doença"
      end
      move_down 4
      indent 2 do
        text "|_____|  <b>A</b> - Aguda  <b>C</b> - Crônica", align: :left, :inline_format => true
      end
    end
  end
  
  def imprime_item_28
    bounding_box([156.5, position_line_9], width: 170.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "28 - Tempo de Doença Referida pelo Paciente"
      end
      move_down 4
      indent 2 do
        text "|_____|_____| - |_____|  <b>A</b> - Anos  <b>M</b> - Meses  <b>D</b> - Dias", align: :left, :inline_format => true
      end
    end
  end
  
  def imprime_item_29
    bounding_box([330, position_line_9], width: 240, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "29 - Indicação de Acidente"
      end
      move_down 4
      indent 2 do
        text "|_____|  <b>0</b> - Acidente ou Doença Relacionada ao Trabalho <b>1</b> - Trânsito  <b>2</b> - Outros", align: :left, :inline_format => true
      end
    end
  end

  def imprime_item_30
    bounding_box([28, position_line_10], width: 98.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "30 - CID 10 Principal"
      end
      move_down 3
      indent 2 do
        text "|_____"*5 + "|", align: :center
      end
    end
  end

  def imprime_item_31
    bounding_box([129.5, position_line_10], width: 98.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "31 - CID 10 (2)"
      end
      move_down 3
      indent 2 do
        text "|_____"*5 + "|", align: :center
      end
    end
  end

  def imprime_item_32
    bounding_box([230.8, position_line_10], width: 97.8, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "32 - CID 10 (3)"
      end
      move_down 3
      indent 2 do
        text "|_____"*5 + "|", align: :center
      end
    end
  end

  def imprime_item_33
    bounding_box([331.5, position_line_10], width: 98.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "33 - CID 10 (4)"
      end
      move_down 3
      indent 2 do
        text "|_____"*5 + "|", align: :center
      end
    end
  end

  def imprimir_linha_titulo_5
    bounding_box([28, 225.8], width: 75, height: 15) do
      table [["Procedimentos Solicitados"]] do
        self.width = 750
        column(0).width = 750
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0..row_length), size: 6)
        self.position = 0
        self.header   = true
        row(0..row_length).columns(0).borders = []
        style(row(0), background_color: 'DEDEDE')
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
    end
  end

  def imprimir_itens_34_a_38
    bounding_box([28, 218], width: 750) do
      table itens_linha_11_0 do
        self.width = 750
        column(0).width = 48
        column(1).width = 159
        column(2).width = 453
        column(3).width = 48
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 8)
        self.position = 0
        self.header = false
        row(0).columns(1..3).borders = [:top]
        row(0).columns(0).borders = [:left,:top]
        row(0).columns(4).borders = [:right,:top]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_11_1 do
        self.width = 750
        column(0).width = 48
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
        # text_box "#{@item_26_1.tabela}", at: [15,5.5], character_spacing: 6
        # text_box "#{@item_26_1.codigo_procedimento}", at: [41.4,5.5], character_spacing: 8
        @item_26_1_tabela = @item_26_1.tabela.split(//)
        text_box "#{@item_26_1_tabela[0]}", at: [14,5.5]
        text_box "#{@item_26_1_tabela[1]}", at: [25.5,5.5]
        @item_26_1_codigo_procedimento = @item_26_1.codigo_procedimento.split(//)
        text_box "#{@item_26_1_codigo_procedimento[0]}", at: [42,5.5]
        text_box "#{@item_26_1_codigo_procedimento[1]}", at: [53,5.5]
        text_box "#{@item_26_1_codigo_procedimento[2]}", at: [65,5.5]
        text_box "#{@item_26_1_codigo_procedimento[3]}", at: [76,5.5]
        text_box "#{@item_26_1_codigo_procedimento[4]}", at: [88,5.5]
        text_box "#{@item_26_1_codigo_procedimento[5]}", at: [100,5.5]
        text_box "#{@item_26_1_codigo_procedimento[6]}", at: [111,5.5]
        text_box "#{@item_26_1_codigo_procedimento[7]}", at: [122,5.5]
        text_box "#{@item_26_1_codigo_procedimento[8]}", at: [134,5.5]
        text_box "#{@item_26_1_codigo_procedimento[9]}", at: [146,5.5]
        text_box "#{@item_26_1.descricao}", at: [210,5.5]
      end
      table itens_linha_11_2 do
        self.width = 750
        column(0).width = 48
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
        # text_box "#{@item_26_2.tabela}", at: [15,5.5], character_spacing: 6
        # text_box "#{@item_26_2.codigo_procedimento}", at: [41.4,5.5], character_spacing: 8
        @item_26_2_tabela = @item_26_2.tabela.split(//)
        text_box "#{@item_26_2_tabela[0]}", at: [14,5.5]
        text_box "#{@item_26_2_tabela[1]}", at: [25.5,5.5]
        @item_26_2_codigo_procedimento = @item_26_2.codigo_procedimento.split(//)
        text_box "#{@item_26_2_codigo_procedimento[0]}", at: [42,5.5]
        text_box "#{@item_26_2_codigo_procedimento[1]}", at: [53,5.5]
        text_box "#{@item_26_2_codigo_procedimento[2]}", at: [65,5.5]
        text_box "#{@item_26_2_codigo_procedimento[3]}", at: [76,5.5]
        text_box "#{@item_26_2_codigo_procedimento[4]}", at: [88,5.5]
        text_box "#{@item_26_2_codigo_procedimento[5]}", at: [100,5.5]
        text_box "#{@item_26_2_codigo_procedimento[6]}", at: [111,5.5]
        text_box "#{@item_26_2_codigo_procedimento[7]}", at: [122,5.5]
        text_box "#{@item_26_2_codigo_procedimento[8]}", at: [134,5.5]
        text_box "#{@item_26_2_codigo_procedimento[9]}", at: [146,5.5]
        text_box "#{@item_26_2.descricao}", at: [162,5.5]
      end
      table itens_linha_11_3 do
        self.width = 750
        column(0).width = 48
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
        # text_box "#{@item_26_3.tabela}", at: [15,5.5], character_spacing: 6
        # text_box "#{@item_26_3.codigo_procedimento}", at: [41.4,5.5], character_spacing: 8
        @item_26_3_tabela = @item_26_3.tabela.split(//)
        text_box "#{@item_26_3_tabela[0]}", at: [14,5.5]
        text_box "#{@item_26_3_tabela[1]}", at: [25.5,5.5]
        @item_26_3_codigo_procedimento = @item_26_3.codigo_procedimento.split(//)
        text_box "#{@item_26_3_codigo_procedimento[0]}", at: [42,5.5]
        text_box "#{@item_26_3_codigo_procedimento[1]}", at: [53,5.5]
        text_box "#{@item_26_3_codigo_procedimento[2]}", at: [65,5.5]
        text_box "#{@item_26_3_codigo_procedimento[3]}", at: [76,5.5]
        text_box "#{@item_26_3_codigo_procedimento[4]}", at: [88,5.5]
        text_box "#{@item_26_3_codigo_procedimento[5]}", at: [100,5.5]
        text_box "#{@item_26_3_codigo_procedimento[6]}", at: [111,5.5]
        text_box "#{@item_26_3_codigo_procedimento[7]}", at: [122,5.5]
        text_box "#{@item_26_3_codigo_procedimento[8]}", at: [134,5.5]
        text_box "#{@item_26_3_codigo_procedimento[9]}", at: [146,5.5]
        text_box "#{@item_26_3.descricao}", at: [162,5.5]
      end
      table itens_linha_11_4 do
        self.width = 750
        column(0).width = 48
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
        # text_box "#{@item_26_4.tabela}", at: [15,5.5], character_spacing: 6
        # text_box "#{@item_26_4.codigo_procedimento}", at: [41.4,5.5], character_spacing: 8
        @item_26_4_tabela = @item_26_4.tabela.split(//)
        text_box "#{@item_26_4_tabela[0]}", at: [14,5.5]
        text_box "#{@item_26_4_tabela[1]}", at: [25.5,5.5]
        @item_26_4_codigo_procedimento = @item_26_4.codigo_procedimento.split(//)
        text_box "#{@item_26_4_codigo_procedimento[0]}", at: [42,5.5]
        text_box "#{@item_26_4_codigo_procedimento[1]}", at: [53,5.5]
        text_box "#{@item_26_4_codigo_procedimento[2]}", at: [65,5.5]
        text_box "#{@item_26_4_codigo_procedimento[3]}", at: [76,5.5]
        text_box "#{@item_26_4_codigo_procedimento[4]}", at: [88,5.5]
        text_box "#{@item_26_4_codigo_procedimento[5]}", at: [100,5.5]
        text_box "#{@item_26_4_codigo_procedimento[6]}", at: [111,5.5]
        text_box "#{@item_26_4_codigo_procedimento[7]}", at: [122,5.5]
        text_box "#{@item_26_4_codigo_procedimento[8]}", at: [134,5.5]
        text_box "#{@item_26_4_codigo_procedimento[9]}", at: [146,5.5]
        text_box "#{@item_26_4.descricao}", at: [162,5.5]
      end
      table itens_linha_11_5 do
        self.width = 750
        column(0).width = 48
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
        # text_box "#{@item_26_5.tabela}", at: [15,7.5], character_spacing: 6
        # text_box "#{@item_26_5.codigo_procedimento}", at: [41.4,7.5], character_spacing: 8
        @item_26_5_tabela = @item_26_5.tabela.split(//)
        text_box "#{@item_26_5_tabela[0]}", at: [14,7.5]
        text_box "#{@item_26_5_tabela[1]}", at: [25.5,7.5]
        @item_26_5_codigo_procedimento = @item_26_5.codigo_procedimento.split(//)
        text_box "#{@item_26_5_codigo_procedimento[0]}", at: [42,7.5]
        text_box "#{@item_26_5_codigo_procedimento[1]}", at: [53,7.5]
        text_box "#{@item_26_5_codigo_procedimento[2]}", at: [65,7.5]
        text_box "#{@item_26_5_codigo_procedimento[3]}", at: [76,7.5]
        text_box "#{@item_26_5_codigo_procedimento[4]}", at: [88,7.5]
        text_box "#{@item_26_5_codigo_procedimento[5]}", at: [100,7.5]
        text_box "#{@item_26_5_codigo_procedimento[6]}", at: [111,7.5]
        text_box "#{@item_26_5_codigo_procedimento[7]}", at: [122,7.5]
        text_box "#{@item_26_5_codigo_procedimento[8]}", at: [134,7.5]
        text_box "#{@item_26_5_codigo_procedimento[9]}", at: [146,7.5]
        text_box "#{@item_26_5.descricao}", at: [162,7.5]
      end
    end
  end

  def itens_linha_11_0
    [["34 - Tabela","35 - Código do Procedimento", "36 - Descrição", "37 - Qt. Solic.", "38 - Qt. Aut."]]
  end

  def itens_linha_11_1
    [["1- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "_____________________________________________________________________________________________________________________________________","|____|____|","|____|____|"]]
  end

  def itens_linha_11_2
    [["2- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "_____________________________________________________________________________________________________________________________________","|____|____|","|____|____|"]]
  end

  def itens_linha_11_3
    [["3- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "_____________________________________________________________________________________________________________________________________","|____|____|","|____|____|"]]
  end

  def itens_linha_11_4
    [["4- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "_____________________________________________________________________________________________________________________________________","|____|____|","|____|____|"]]
  end

  def itens_linha_11_5
    [["5- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "_____________________________________________________________________________________________________________________________________","|____|____|","|____|____|"]]
  end

  def imprimir_linha_titulo_6
    bounding_box([28, 173.8], width: 75, height: 15) do
      table [["OPM Solicitados"]] do
        self.width = 750
        column(0).width = 750
        row(0..row_length).align = :left
        row(0).font_style = :bold
        style(row(0..row_length), size: 6)
        self.position = 0
        self.header   = true
        row(0..row_length).columns(0).borders = []
        style(row(0), background_color: 'DEDEDE')
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
    end
  end

  def imprimir_itens_39_a_44
    bounding_box([28, 165.5], width: 750) do
      table itens_linha_12_0 do
        self.width = 750
        column(0).width = 48
        column(1).width = 155
        column(2).width = 202
        column(3).width = 48
        # column(4).width = 150
        # column(5).width = 190
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 8)
        self.position = 0
        self.header = false
        row(0).columns(1..4).borders = [:top]
        row(0).columns(0).borders = [:left,:top]
        row(0).columns(5).borders = [:right,:top]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_12_1 do
        self.width = 750
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..4).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(5).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_12_2 do
        self.width = 750
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..4).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(5).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_12_3 do
        self.width = 750
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..4).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(5).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_12_4 do
        self.width = 750
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..4).borders = []
        row(0).columns(0).borders = [:left]
        row(0).columns(5).borders = [:right]
        style(row(0..row_length), padding: 0, padding_left: 2)
      end
      table itens_linha_12_5 do
        self.width = 750
        row(0..row_length).align = :left
        style(row(0), size: 6)
        style(row(1..row_length), size: 5)
        self.position = 0
        self.header = false
        row(0).columns(1..4).borders = [:bottom]
        row(0).columns(0).borders = [:left,:bottom]
        row(0).columns(5).borders = [:right,:bottom]
        style(row(0..row_length), padding: 0, padding_left: 2, padding_bottom: 2)
      end
    end
  end

  def itens_linha_12_0
    [["39 - Tabela","40 - Código da OPM", "41 - Descrição OPM", "42 - Qtde.", "43 - Fabricante", "44 - Valor Unitário R$"]]
  end

  def itens_linha_12_1
    [["1- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "__________________________________________________________","|_____|_____|","________________________________________", "|_____|_____|_____|_____|_____|_____|,|_____|_____|"]]
  end

  def itens_linha_12_2
    [["2- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "__________________________________________________________","|_____|_____|","________________________________________", "|_____|_____|_____|_____|_____|_____|,|_____|_____|"]]
  end

  def itens_linha_12_3
    [["3- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "__________________________________________________________","|_____|_____|","________________________________________", "|_____|_____|_____|_____|_____|_____|,|_____|_____|"]]
  end

  def itens_linha_12_4
    [["4- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "__________________________________________________________","|_____|_____|","________________________________________", "|_____|_____|_____|_____|_____|_____|,|_____|_____|"]]
  end

  def itens_linha_12_5
    [["5- |____|____|","|____|____|____|____|____|____|____|____|____|____|", "__________________________________________________________","|_____|_____|","________________________________________", "|_____|_____|_____|_____|_____|_____|,|_____|_____|"]]
  end

  def imprimir_linha_titulo_7
    bounding_box([28, 121], width: 75, height: 15) do
      table [["Dados da Autorização"]] do
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

  def imprime_item_45
    bounding_box([28, position_line_11], width: 169, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "45 - Data Provavél da Admissão Hospitalar"
      end
      move_down 5
      indent 3 do
        text "|_____|_____| / |_____|_____| / |_____|_____|", size: 5
      end
    end
  end

  def imprime_item_46
    bounding_box([199.8, position_line_11], width: 129, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "46 - Qtde. Dias Autorizadas"
      end
      move_down 5
      indent 3 do
        text "|_____"*3 + "|", size: 5
      end
    end
  end

  def imprime_item_47
    bounding_box([331.5, position_line_11], width: 129, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "47 - Tipo Acomodação Autorizada"
      end
      move_down 5
      indent 3 do
        text "|_____"*2 + "|", size: 5
      end
    end
  end

  def imprime_item_48
    bounding_box([28, position_line_12], width: 218.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "48 - Código na Operadora / CNPJ"
      end
      move_down 5
      indent 2 do
        text "|_____"*14 + "|", size: 5
      end
    end
  end

  def imprime_item_49
    bounding_box([248.5, position_line_12], width: 430.5, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "49 - Nome do Prestador Autorizado"
      end
    end
  end

  def imprime_item_50
    bounding_box([681.8, position_line_12], width: 98, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "50 - Código CNES"
      end
      move_down 5
      text "|____"*7 +"|", align: :center, size: 5
    end
  end

  def imprime_item_51
    bounding_box([28, position_line_13], width: 751, height: 40) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "51 - Observação"
      end
      indent 2 do
        text "_"*221, align: :left
        move_down 2
        text "_"*221, align: :left
        move_down 2
        text "_"*221, align: :left
      end
    end
  end

  def imprime_item_52
    bounding_box([28, position_line_14], width: 218.8, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "52 - Data e Assinatura do Médico Solicitante"
      end
      move_down 4
      indent 2 do
        text "|_____|_____| / |_____|_____| / |_____|_____|", size: 5
      end
    end
  end

  def imprime_item_53
    bounding_box([249.8, position_line_14], width: 218.8, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "53 - Data e Assinatura do Beneficiário ou Responsável"
      end
      move_down 4
      indent 2 do
        text "|_____|_____| / |_____|_____| / |_____|_____|", size: 5
      end
    end
  end

  def imprime_item_54
    bounding_box([471.5, position_line_14], width: 218.8, height: field_height) do
      stroke_bounds
      move_down 1
      indent 2 do
        text "54 - Data e Assinatura do Responsável pela Autorização"
      end
      move_down 4
      indent 2 do
        text "|_____|_____| / |_____|_____| / |_____|_____|", size: 5
      end
    end
  end
end