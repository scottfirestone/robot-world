require 'yaml/store'
require_relative 'robot'

class RobotWorld
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.transaction do
      database['robots']  ||= []
      database['total']   ||= 0
      database['total']   += 1
      database['robots']  << {"name"       => robot[:name],
                              'city'       => robot[:city],
                              'avatar'     => robot[:avatar],
                              'birthdate'  => robot[:birthdate],
                              'date_hired' => robot[:date_hired],
                              'department' => robot[:department]}
    end
  end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data)}
  end

  def raw_robot(name)
    raw_robots.find { |robot| robot["name"] == name}
  end

  def find(name)
    Robot.new(raw_robot(name))
  end

  def update(name, robot)
    database.transaction do
      target = database['robots'].find { |data| data["name"] == name }
      target["city"] = robot[:city]
      target["avatar"] = robot[:avatar]
      target["birthdate"] = robot[:birthdate]
      target["date_hired"] = robot[:date_hired]
      target["department"] = robot[:department]
    end
  end

  def delete(name)
    database.transaction do
      database["robots"].delete_if { |robot| robot["name"] == name }
    end
  end
end
