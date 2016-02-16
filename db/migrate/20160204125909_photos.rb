class Photos < ActiveRecord::Migration
  def change
    create_table :photos do |p|
      p.integer :user_id
      #DEFINIR TIPO CORRECTO
      p.string :photo
      p.string :title
      p.integer :photo_index
      p.timestamps
    end
  end
end
