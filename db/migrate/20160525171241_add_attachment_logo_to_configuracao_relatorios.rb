class AddAttachmentLogoToConfiguracaoRelatorios < ActiveRecord::Migration
  def self.up
    change_table :configuracao_relatorios do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :configuracao_relatorios, :logo
  end
end
