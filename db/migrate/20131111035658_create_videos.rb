class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :slug
      t.string :cam_footage
      t.string :gps_data
      t.timestamps
    end
  end
end
