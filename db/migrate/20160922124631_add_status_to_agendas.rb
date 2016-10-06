class AddStatusToAgendas < ActiveRecord::Migration[5.0]
  def change
    add_column :agendas, :status, :string
  end
end
