class ChangeProfissionais < ActiveRecord::Migration
  def change
    
    add_reference :profissionais, :cargo, index: true, foreign_key: true   
    add_reference :profissionais, :conselho_regional, index: true, foreign_key: true   
    add_reference :profissionais, :cidade, index: true, foreign_key: true   
    add_reference :profissionais, :empresa, index: true, foreign_key: true   
    add_reference :profissionais, :estado, index: true, foreign_key: true   
    add_reference :profissionais, :operadora, index: true, foreign_key: true   
  end
end
