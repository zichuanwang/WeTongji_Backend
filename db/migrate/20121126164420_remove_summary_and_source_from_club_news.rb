class RemoveSummaryAndSourceFromClubNews < ActiveRecord::Migration
  def up
  	remove_column :club_news, :summary
  	remove_column :club_news, :source
  end

  def down
  	add_column :club_news, :summary, :string
  	add_column :club_news, :source, :string
  end
end
