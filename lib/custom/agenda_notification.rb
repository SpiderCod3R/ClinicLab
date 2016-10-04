class AgendaNotification < RuntimeError
  attr_reader :error_messages, :resource, :error
  attr_writer :error_messages

  def initialize(resource, error_message="No value detected")
    @resource = resource
    @error_messages = Array.new
    super(error_message)
  end

  def validate_shift_a!
    begin
      if resource[:horarios][:turno_a][:atendimentos].nil? && resource[:horarios][:turno_a][:atendimento_duracao].nil?
        error_messages.push(I18n.t('agendas.messages.no_value_detected'))
        raise
      end
    rescue => e
      return error_messages
    end
  end

  def validate_shift_b!
    begin
      if resource[:horarios][:turno_b][:atendimentos].nil? && resource[:horarios][:turno_b][:atendimento_duracao].nil?
        error_messages.push(I18n.t('agendas.messages.no_value_detected'))
        raise
      end
    rescue => e
      return error_messages
    end
  end
end