module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for user, options = {css_class: ""}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    css_class = options[:css_class]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_url, alt: user.name, class: "user-avatar #{css_class}"
  end

  def current_course
  	Course.find(current_trainee.current_course_id)
  end
end