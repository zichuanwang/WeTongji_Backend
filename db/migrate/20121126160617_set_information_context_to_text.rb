class SetInformationContextToText < ActiveRecord::Migration
  def up
  	change_column :school_news, :context, :text
  	change_column :club_news, :context, :text
  	change_column :arounds, :context, :text
  	change_column :for_staffs, :context, :text
  end

  def down
  	change_column :school_news, :context, :string
  	change_column :club_news, :context, :string
  	change_column :arounds, :context, :string
  	change_column :for_staffs, :context, :string
  end
end
