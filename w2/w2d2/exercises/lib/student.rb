class Student
  attr_accessor :courses
  attr_reader :first_name
  attr_reader :last_name
  
  def initialize(first, last, courses = [])
    @first_name = first
    @last_name = last
    @courses = courses
  end
  
  
  def name
    result = @first_name << " " << @last_name
  end
  
  def courses
    @courses
  end
  
  def enroll(course)
    if self.has_conflict?(course)
      raise "Course conflicts with a current course"
    end
    if not @courses.include? course
      @courses << course
      course.students << self
    end
  end
  
  def course_load
    result = Hash.new(0)
    @courses.each { |course| result[course.department] += course.credits }
    result
  end
  
  def has_conflict?(course)
    self.courses.each { |self_course| return true if self_course.conflicts_with?(course) }
    false
  end
  
end
