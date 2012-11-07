class CreateInformationImages < ActiveRecord::Migration
  def change
    create_table :information_images do |t|
    	t.integer :information_id
    	t.attachment :file
      	t.timestamps
    end
  end
end
