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
# User.create(:email => "test@test.com", :password => "123456", :password_confirmation => "123456")

c1 = Channel.create(:title => '学术讲座', :description => '学术讲座最有营养了。', :follow => 100)
c2 = Channel.create(:title => '校园赛事', :description => '燃烧吧骚年！', :follow => 100)
c3 = Channel.create(:title => '文娱活动', :description => '才不是不务正业呐魂淡～～', :follow => 100)
Channel.create(:title => '企业招聘', :description => '挣大票的机会啊亲。', :follow => 100)

org1 = Organizer.create(:name => '学生会', :description => '')
sorg1 = SubOrganizer.create(:name => '文艺部', :organizer => org1, :description => '')
SubOrganizer.create(:name => '体育部', :organizer => org1, :description => '')
sorg3 = SubOrganizer.create(:name => '学术部', :organizer => org1, :description => '')
SubOrganizer.create(:name => '权益部', :organizer => org1, :description => '')

Organizer.create(:name => '学生处', :description => '')

org2 = Organizer.create(:name => '校友会', :description => '')
sorg2 = SubOrganizer.create(:name => '同济大学校友摄影协会', :organizer => org2, :description => '')

org3 = Organizer.create(:name => '校团委', :description => '')
SubOrganizer.create(:name => '组织部', :organizer => org3, :description => '')
SubOrganizer.create(:name => '文化素质教育基地', :organizer => org3, :description => '')
SubOrganizer.create(:name => '职协', :organizer => org3, :description => '')

Organizer.create(:name => '社团联', :description => '')

a1 = Activity.create(:title => '校园十大歌手', :channel => c2, :organizer => org1, :sub_organizer => sorg1, :description => '校园十大歌手决赛', :begin => '2012.04.30 18:30', :end => '2012.04.30 20:30', :location => '大礼堂', :favorite => 1000, :like => 400, :schedule => 4000)
a1.favorite = 1000
a1.like = 400
a1.schedule = 4000
a1.save

a2 = Activity.create(:title => '爱拍同济摄影大赛', :channel => c1, :organizer => org2, :sub_organizer => sorg2, :description => '校友摄影协会成立仪式暨第一次活动爱拍同济摄影大赛', :begin => '2012.05.19 8:30', :end => '2012.05.20 20:30', :location => '综合楼', :favorite => 357, :like => 789, :schedule => 1040)
a2.favorite = 357
a2.like = 789
a2.schedule = 1040
a2.save

a3 = Activity.create(:title => '同舟讲坛《走进你的心里》主讲人:裴刚', :channel => c3, :organizer => org1, :sub_organizer => sorg3, :description => '裴钢校长给我们做题为《走近你的心里》的学术讲座，相约星期四！', :begin => '2012.04.26 19:00', :end => '2012.04.26 21:00', :location => '逸夫楼2楼报告厅', :favorite => 788, :like => 289, :schedule => 3002)
a3.favorite = 788
a3.like = 289
a3.schedule = 3002
a3.save