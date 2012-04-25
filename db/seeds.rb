# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 
# Activity.create(:title => 'activity 1', :begin => '2012/05/01', :end => '2012/05/15', :description => 'test activity description', :location => 'anywhere', :follow => 100, :organizer => 'i dont know.', :status => 'in process')
Admin.create(:email => "admin@test.com", :password => "123456", :password_confirmation => "123456")
User.create(:email => "test@test.com", :password => "123456", :password_confirmation => "123456")

Channel.create(:title => '学术讲座', :description => '学术讲座最有营养了。', :follow => 100)
Channel.create(:title => '校园赛事', :description => '燃烧吧骚年！', :follow => 100)
Channel.create(:title => '文娱活动', :description => '才不是不务正业呐魂淡～～', :follow => 100)
Channel.create(:title => '企业招聘', :description => '挣大票的机会啊亲。', :follow => 100)

Organizer.create(:name => '学生会', :description => '')
Organizer.create(:name => '校友会', :description => '')
Organizer.create(:name => '社团联', :description => '')