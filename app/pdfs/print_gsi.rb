class PrintGsi < TemplateGSI
  def page_layout
    options = {
      page_size: 'A4',
      page_layout: :landscape,
      top_margin: 30
    }
  end

  def initialize(cliente, sadt, sadt_grupos)
    super(page_layout)
    self.font_size = 6
    @cliente = cliente
    @sadt = sadt
    @sadt_grupos = sadt_grupos
    @grupos = []
    @url_logo = "public/assets/images/logos/petrobras_logo.jpg"
    @sadt_grupos.each do |sadt_grupo|
      @grupos << sadt_grupo.grupo
    end
    @cont = 0
    @grupos.each do |grupo|
      @exame_procedimentos = []
      grupo.grupo_exame_procedimentos.each do |grupo_exame_procedimento|
        @exame_procedimentos << grupo_exame_procedimento.exame_procedimento
      end
      @exame_procedimentos.each_slice(5) do |array|
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
        start_pagina_1
        start_new_page
        start_pagina_2
        @cont +=  1
      end
    end
  end

  def start_pagina_1
    exibe_cabecalho 
    imprimir_frente
  end

  def start_pagina_2
    exibe_cabecalho 
    imprimir_verso
  end

  def exibe_cabecalho
    bounding_box([6, bounds.top], width: 750) do
      move_down 25
      image (@url_logo), height: 40, at: [19, 45]
      text_box "GUIA DE SOLICITAÇÃO DE INTERNAÇÃO", style: :bold, align: :center, size: 15, at: [22, 35]
    end
  end
end