class CourseSubjectTask < ActiveRecord::Base
  include Active

	belongs_to :course_subject
	belongs_to :task
end