class Robot
  attr_reader :id
  attr_reader :name
  attr_reader :city
  attr_reader :avatar
  attr_reader :birthdate
  attr_reader :date_hired
  attr_reader :department

  def initialize(data)
    @id         = data[:id]
    @name       = data[:name]
    @city       = data[:city]
    @avatar     = data[:avatar]
    @birthdate  = data[:birthdate]
    @date_hired = data[:date_hired]
    @department = data[:department]
  end
end
