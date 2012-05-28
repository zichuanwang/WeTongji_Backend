
require 'csv'
class Exam < ActiveRecord::Base
  validates_presence_of :course_no, :student_no, :location, :begin, :end
  paginates_per 10
  
  def self.import(file_path)
    exams = []

    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      s = Exam.new
      s.student_no = row[0]
      s.course_no = row[1]
      s.begin = row[2]
      s.end = row[3]
      s.location = row[4]
      exams << s
    end

    exams
  end
end
