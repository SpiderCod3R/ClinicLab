class AddAttachmentFotoToClientes < ActiveRecord::Migration
  def self.up
    change_table :clientes do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :clientes, :foto
  end
end
