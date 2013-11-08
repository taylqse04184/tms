class User < ActiveRecord::Base
  has_secure_password
  has_many :enrollment_subjects, through: :enrollments
	has_many :enrollments, dependent: :destroy
  has_many :activities
  has_many :courses, through: :enrollments
  has_many :have_subjects, through: :enrollments, source: :enrollment_subjects

	before_save {self.email = email.downcase}
  before_create :create_remember_token
  
  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, 
             uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  validates :current_course_id, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end