class RemoveNumdiasvalsenhaFromConvenios < ActiveRecord::Migration[5.0]
  def change
    remove_column :convenios, :numdiasvalsenha, :string
  end
end
