class PagesController < Support::InsideController

  def index
    @feriado_e_data_comemorativas = FeriadoEDataComemorativa.all
    # respond_to &:jbuilder
  end

  def help
    #TODO
  end

  def contact_us
    #TODO
  end
end