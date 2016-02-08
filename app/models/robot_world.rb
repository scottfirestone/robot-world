class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    dataset.insert(robot)
  end

  def all
    dataset.to_a.map { |data| Robot.new(data) }
  end

  def dataset
    database.from(:robots)
  end

  def find(id)
    Robot.new(dataset.where(:id=>id).to_a.first)
  end

  def update(id, params)
    dataset.where(:id=>id).update(
      :name       => params[:name],
      :city       => params[:city],
      :avatar     => params[:avatar],
      :birthdate  => params[:birthdate],
      :date_hired => params[:date_hired],
      :department => params[:department]
    )
  end

  def delete(id)
    dataset.where(:id => id).delete
  end

  def delete_all
    dataset.map { |robot| delete(robot.id) }
  end
end
