module MovimentoServicosHelper
  def build_movimento_servico_form_toolbar(new_path=nil, form_id, object, back_path, report)
    content_for :header do
      render "movimento_servicos/toolbar/form_toolbar", {
                                          new_path: new_path,
                                          form: form_id,
                                          object: object,
                                          back_path: back_path,
                                          report_path: report
                                        }
    end
  end

  def build_movimento_servico_object_viewer_toolbar(edit_path, object ,back_path, report)
    content_for :header do
      render "movimento_servicos/toolbar/toolbar_viewer", {
                                          edit_path: edit_path,
                                          object: object,
                                          back_path: back_path,
                                          report_path: report
                                        }
    end
  end
end