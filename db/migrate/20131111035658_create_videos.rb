class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :slug
      t.string :cam_footage
      t.string :output_video
      t.string :gps_data

      t.string :state
      t.datetime :processing_began_at
      t.datetime :processing_finished_at

      t.timestamps
    end
  end
end
