# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Channel.create(:title => 'test channel', :description => 'hiahiahiahia', :follow => 100)
Activity.create(:title => 'activity 1', :begin => '2012/05/01', :end => '2012/05/15', :description => 'test activity description', :location => 'anywhere', :follow => 100, :organizer => 'i dont know.', :status => 'in process')
Admin.create(:email => "admin@test.com", :password => "123456", :password_confirmation => "123456")
User.create(:email => "user@test.com", :password => "123456", :password_confirmation => "123456")