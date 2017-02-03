class RemoveNundiasvalsenhaFromConvenios < ActiveRecord::Migration[5.0]
  def change
    remove_column :convenios, :nundiasvalsenha, :string
  end
end
