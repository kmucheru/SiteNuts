class RemoveDPicFromDemos < ActiveRecord::Migration[5.1]
  def change
    remove_column :demos, :d_pic, :binary
    remove_column :demos, :m_pic, :binary
    remove_column :demos, :t_pic, :binary
    remove_column :demos, :r1_pic, :binary
    remove_column :demos, :r2_pic, :binary

    add_column :demos, :dpic_uid, :string
    add_column :demos, :mpic_uid, :string
    add_column :demos, :tpic_uid, :string
    add_column :demos, :r1pic_uid, :string
    add_column :demos, :r2pic_uid, :string
  end
end
