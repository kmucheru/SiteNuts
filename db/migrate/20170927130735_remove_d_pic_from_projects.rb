class RemoveDPicFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :d_pic, :binary
    add_column :projects, :pic1_uid, :string
  end
end
