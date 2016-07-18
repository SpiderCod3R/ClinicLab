class AddAttachmentImagemToImagemCabecs < ActiveRecord::Migration
  def self.up
    change_table :imagem_cabecs do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :imagem_cabecs, :imagem
  end
end
