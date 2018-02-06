class Template::GsiPetrobras < Prawn::Document
  include Guia::GuiaInternacaoPetrobrasFrente
  include Guia::GuiaInternacaoPetrobrasVerso

  def page_layout
    options = {
      page_size: 'A4',
      page_layout: :landscape,
      top_margin: 0
    }
  end

  def field_height
    return 19.5
  end

  def position_line_1
    return 511
  end

  def position_line_2
    return 483
  end

  def position_line_3
    return 461.2
  end

  def position_line_4
    return 433
  end

  def position_line_5
    return 411.5
  end

  def position_line_6
    return 383
  end

  def position_line_7
    return 361
  end

  def position_line_8
    return 339
  end

  def position_line_9
    return 268
  end

  def position_line_10
    return 246
  end

  def position_line_11
    return 112.8
  end

  def position_line_12
    return 91
  end

  def position_line_13
    return 69
  end

  def position_line_14
    return 26
  end

  def formata_data(data)
    if data.present?
      data.strftime("%d/%m/%Y")
    end
  end

  def imprime_item_2
    bounding_box([590, 535], width: 75, height: 15) do
      move_down 1
      text "2 - No. Guia no Prestador"
    end
  end

  def imprime_footer_name
    text_box "PETROBRAS", style: :bold, size: 5, at: [28, 4.8]
  end

  def imprime_verso_title_header
    text_box "VERSO", style: :bold, size: 10, at: [380, 520]
  end

  def imprimir_frente
    imprime_item_1
    imprime_item_2
    imprime_item_3
    imprime_item_4
    imprime_item_5
    imprime_item_6
    imprimir_linha_titulo_1
    imprime_item_7
    imprime_item_8
    imprime_item_9
    imprime_item_10
    imprime_item_11
    imprimir_linha_titulo_2
    imprime_item_12
    imprime_item_13
    imprime_item_14
    imprime_item_15
    imprime_item_16
    imprime_item_17
    imprime_item_18
    imprime_item_19
    imprimir_linha_titulo_3
    imprime_item_20
    imprime_item_21
    imprime_item_22
    imprime_item_23
    imprime_item_24
    imprime_item_25
    imprime_item_26
    imprimir_linha_titulo_4
    imprime_item_27
    imprime_item_28
    imprime_item_29
    imprime_item_30
    imprime_item_31
    imprime_item_32
    imprime_item_33
    imprimir_linha_titulo_5
    imprimir_itens_34_a_38
    imprimir_linha_titulo_6
    imprimir_itens_39_a_44
    imprimir_linha_titulo_7
    imprime_item_45
    imprime_item_46
    imprime_item_47
    imprime_item_48
    imprime_item_49
    imprime_item_50
    imprime_item_51
    imprime_item_52
    imprime_item_53
    imprime_item_54
    imprime_footer_name
  end
  
  def imprimir_verso
    imprime_verso_title_header
    imprime_item_2
    imprimir_linha_titulo_verso_1
    imprimir_itens_verso_55_a_71
    imprimir_itens_verso_55_a_71_pt2
    imprimir_itens_verso_55_a_71_pt3
    imprime_footer_name
  end
end