class AddBgcolorToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :bgcolor, :string
  end
end
