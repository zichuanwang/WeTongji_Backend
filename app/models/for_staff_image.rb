class ForStaffImage < ActiveRecord::Base
	belongs_to :for_staff
	validates_attachment :file, :presence => true, :content_type => { :content_type => ["image/jpeg", "image/jpg"] }, :size => { :in => 0..300.kilobytes }
	has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end