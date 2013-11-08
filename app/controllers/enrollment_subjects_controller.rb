class EnrollmentSubjectsController < ApplicationController
	before_action :signed_in_user
	before_action :create_objects, only: [:show, :update]

  def index
    @user = User.find params[:user_id]
    @enrollment = Enrollment.find params[:enrollment_id]
  end

  def show
    @subject = Subject.where(name: @enrollment_subject.name).take!
  end

  def update
  	complete_all_tasks = true

  	@enrollment_subject.enrollment_tasks.all.each do |task|
  		if task.status != "done"
  			complete_all_tasks = false
  		end
  	end

  	if complete_all_tasks
  		EnrollmentSubject.finish_subject @enrollment_subject
  		flash[:success] = "Congratulation! You have completed the " + @enrollment_subject.name + " subject"
  	else
  		flash[:error] = "You need to complete all tasks before finish subject"
  	end

  	redirect_to user_enrollment_enrollment_subject_path
  end

  private
  def create_objects
  	@user = User.find params[:user_id]
  	@enrollment = Enrollment.find params[:enrollment_id]
  	@enrollment_subject = EnrollmentSubject.find params[:id]
  	unless (current_user?(@user) && current_enrollment?(@enrollment) && 
  		current_subject?(@enrollment_subject) && enrollment_activation?(@enrollment))
  		redirect_to @user
  	end
  end

  def current_enrollment? enrollment
  	current_enrollment = @user.enrollments.choose_current_course(@user.current_course_id).take!
  	enrollment.id == current_enrollment.id
  end

  def current_subject? enrollment_subject
  	enrollment_subject.enrollment_id == @enrollment.id
  end

  def enrollment_activation? enrollment
  	enrollment.activation
  end
end