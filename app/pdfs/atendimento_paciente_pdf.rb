class AtendimentoPacientePdf < TemplatePdf
  def initialize(paciente, relatorio, titulo)
    super(paciente, relatorio, titulo)
  end

   def exibir_itens
    exibir_dados_atendimento
  end

  def formulario_atendimento_dados_recebidos
    @tamanho_resource_endreco = 40
    @tamanho_resource_cidade_estado = 15
    @resource_endereco = @resource.endereco
    @resource_endereco = @resource_endereco.truncate(@tamanho_resource_endreco, separator: /[\/?\.\,!\ ]/, omission: '').delete("/?.,!")

    @resource_cidade = @resource.cidade.nome.upcase
    @resource_estado = @resource.estado.nome.upcase
    @resource_cidade = @resource_cidade.truncate(@tamanho_resource_cidade_estado, separator: /[\/?\.\,!\ ]/, omission: '').delete("/?.,!")
    @resource_estado = @resource_estado.truncate(@tamanho_resource_cidade_estado, separator: /[\/?\.\,!\ ]/, omission: '').delete("/?.,!")

     move_down 40
     text 'N° BAM: ' + "#{@resource.id}"
     move_down 3
     text 'Nome: ' + "#{@resource.nome}" + ' '*61 + 'Telefone: ' + "#{@resource.telefone}"
     move_down 4
     text 'Data de Nascimento: ' + "#{@resource.data_nascimento.strftime('%d/%m/%Y')}"
     move_down 4
     text 'Nome da mãe: ' + "#{@resource.nome_da_mae}"
     move_down 4
     text 'Estado: ' + "#{@resource_estado}" + ' '*20 +  'Cidade: ' + "#{@resource_cidade}" + ' '*20 +  'Bairro: ' + "#{@resource.bairro}"
     move_down 4
     text 'Endereço: ' + "#{@resource_endereco}"
     move_down 4
     text 'CEP: ' + ""
     move_down 5
     text 'RG: ' + "  #{@resource.rg}" + ' '*42 + 'CPF: ' + "#{@resource.cpf}"
  end

  def formulario_atendimento_dados_a_preencher
    move_down 8
    text 'Convênio: (  ) Sim   (  ) Não   Qual:' + '_' * 66
    move_down 100
    bounding_box([0, 560], :width => 530, :height => 120) do
      stroke_bounds
      move_down 8
      draw_text "Triagem", :at =>  [10,100]
      move_down 3
      draw_text 'Queixa principal: ' + '_' * 78, :at =>  [10,80]
      move_down 3
      draw_text 'F.C: ' + '_' * 20 + ' Sat: ' + '_' * 20 + ' Temp: ' + '_' * 18 + ' P.A: ' + '_' * 17, :at =>  [10,50]
      move_down 4
      draw_text ""*80 + "_"*20, :at =>  [395,22]
      draw_text "Carimbo e assinatura", :at =>  [400,10]
    end

    move_down 8
    bounding_box([0, 430], :width => 530, :height => 120) do
      stroke_bounds
      move_down 8
      draw_text "Anamnese: ", :at =>  [10,100]
      draw_text "_"*92, :at =>  [10,90]
      draw_text "_"*92, :at =>  [10,70]
      draw_text "_"*92, :at =>  [10,50]
      draw_text "_"*92, :at =>  [10,30]
      move_down 5
    end

    move_down 8
    bounding_box([0, 290], :width => 530, :height => 120) do
      stroke_bounds
      move_down 8
      draw_text 'Conduta: ', :at =>  [10,100]
      draw_text "_"*92, :at =>  [10,90]
      draw_text "_"*92, :at =>  [10,70]
      draw_text "_"*92, :at =>  [10,50]
      draw_text "_"*92, :at =>  [10,30]
      move_down 5
    end
    move_down 50
    text 'Destino: Alta médica: (  )  ' + ' '*10 + ' Alta recebida: (  )  ' + ' '*10 + 'Óbito: (  ) ' + ' Transferido para:' + '_' * 26
    move_down 3
    draw_text " "*106 + '_'*40, :at =>  [10,50]
    draw_text " "*128 + 'Carimbo e assinatura', :at =>  [10,30]
  end

  def exibir_dados_atendimento
    formulario_atendimento_dados_recebidos
    formulario_atendimento_dados_a_preencher
  end

  def exibir_rodape
    repeat(:all) do
      bounding_box([0, 40], width: 520, height: 40) do
        text "CNPJ: #{@relatorio.cnpj} - Telefone: #{@relatorio.telefone}", valign: :top, align: :center
        text "#{@relatorio.endereco}, #{@relatorio.bairro}, #{@relatorio.cidade_estado}", align: :center
        text "E-mail:#{@relatorio.email}", valign: :bottom, align: :center
        transparent(0) { stroke_bounds }
      end
    end
  end
end
