class CreateOAuths < ActiveRecord::Migration[5.0]
  def change
    create_table :o_auths do |t|
      t.string :remote_id, index: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
