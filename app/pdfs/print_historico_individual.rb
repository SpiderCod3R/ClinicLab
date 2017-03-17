require "prawn"
class PrintHistoricoIndividual < TemplatePdf
  include ActionView::Helpers::SanitizeHelper
  attr_accessor :resource

  PDF_OPTIONS = {
    :page_size   => "A4",
    :page_layout => :portrait,
    :margin      => [40, 75]
  }

  def initialize(resource, relatorio, titulo)
    super(resource, relatorio, titulo)
    @resource = resource
    @relatorio = relatorio
    @titulo = titulo
    imprime_pdf
  end

  def formata_datas
    @data = Time.zone.now.strftime('%d/%m/%Y')
    @hora = Time.zone.now.strftime('%H:%M')
  end

  def remove_html(string)
    sanitize(string, :tags => {}) # empty tags hash tells it to allow no tags
  end

  def imprime_pdf
    bounding_box([0, 680], width: 522, height: 620) do
      exibe_itens
    end
    exibe_rodape
  end

  def exibe_itens
    text formatDateHour(resource.created_at.to_date, resource.created_at.to_time), style: :bold
    text "Elaborado por - #{resource.user.name}", style: :bold
    text "Cliente - #{resource.cliente.nome}", style: :bold
    text resource.idade, style: :bold
    move_down 10
    text remove_html(resource.indice)
  end

  def formatDateHour(date, hour)
    if date.present? && hour.present?
      date.strftime("%d/%m/%Y") + " - " + hour.strftime("%H:%M")
    end
  end

  def exibe_rodape
    repeat(:all) do
      bounding_box([0, 40], width: 520, height: 40) do
        text "CNPJ: #{@relatorio.cnpj} - Telefone: #{@relatorio.telefone}", valign: :top, align: :center
        text "#{@relatorio.endereco}, #{@relatorio.bairro}, #{@relatorio.cidade_estado}", align: :center
        text "E-mail:#{@relatorio.email}", align: :center
      end
    end
  end
end