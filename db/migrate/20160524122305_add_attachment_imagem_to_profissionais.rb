class AddAttachmentImagemToProfissionais < ActiveRecord::Migration
  def self.up
    change_table :profissionais do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :profissionais, :imagem
  end
end
