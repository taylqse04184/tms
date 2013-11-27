class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :conclusions
  has_many :enrollment_subjects
  accepts_nested_attributes_for :enrollment_subjects

  scope :user_enrollment_course, ->course_id, user_id do
    where course_id: course_id, user_id: user_id
  end
  scope :find_enrollments, -> course_id{where course_id: course_id, active_flag: 1}
  scope :joins_and_find_erollments_subject, -> subject_id do
    joins(:enrollment_subjects).where("enrollment_subjects.subject_id = ? AND enrollment_subjects.active_flag = 1", subject_id)
  end

  def activated?
    self.status == Settings.status.started
  end

  class << self
    def enroll_course! user, course
      enrolls = user_enrollment_course  course.id, user.id
      if enrolls.empty?
        Enrollment.create! user_id: user.id, course_id: course.id, 
          status: Settings.status.new, active_flag: Settings.flag.active
      else
        enrolls.map do |enroll|
          enroll.update_attributes! status: Settings.status.new,
            active_flag: Settings.flag.active
        end
      end
    end

    def enroll_update_active_flag! user, course
      enrolls_update = user_enrollment_course course.id, user.id
      if enrolls_update.present?
        enrolls_update.map do |enroll_update|
          enroll_update.update_attributes! active_flag: Settings.flag.inactive
        end         
      end
    end

    def enrollment_subject_not_finish(course_id, subject_id)
      relations = find_enrollments(course_id).joins_and_find_erollments_subject(subject_id)
      relations.map{|relation| relation.user}
    end
  end
end