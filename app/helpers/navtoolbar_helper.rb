module NavtoolbarHelper
  def request_url_login_screen(uri)
    if request.original_url.include?(uri)
      true
    else
      false
    end
  end

  def build_chromeframe
    render 'application/chromeframe'
  end

  def build_form_toolbar(new_path=nil, form_id, object ,back_path, report)
    content_for :header do
      render "application/form_toolbar", {
                                          new_path: new_path,
                                          form: form_id,
                                          object: object,
                                          back_path: back_path,
                                          report_path: report
                                        }
    end
  end

  def build_object_viewer_toolbar(edit_path, object ,back_path, report)
    content_for :header do
      render "application/toolbar_viewer", {
                                          edit_path: edit_path,
                                          object: object,
                                          back_path: back_path,
                                          report_path: report
                                        }
    end
  end

  def build_toolbar
    render "application/header"
  end
end