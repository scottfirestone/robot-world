require_relative "../test_helper"

class RobotWorldTest < Minitest::Test
  include TestHelpers

  def create_robots(num)
    num.times do |i|
      robot_world.create(
        name: "name#{i+1}",
        city: "city#{i+1}",
        avatar: "avatar#{i+1}",
        birthdate: "2015-09-0#{i+1}",
        date_hired: "2016-09-0#{i+1}",
        department: "department#{i+1}"
      )
    end
  end

  def test_can_create_a_robot
    robot_world.create(
        name: "name1",
        city: "city1",
        avatar: "avatar1",
        birthdate: "2015-09-01",
        date_hired: "2016-09-01",
        department: "department1"
      )
    robot = robot_world.all.last
    assert robot.name
    assert_equal "name1", robot.name
    assert_equal "city1", robot.city
    assert_equal "avatar1", robot.avatar
    assert_equal Date.parse("2015-09-01"), robot.birthdate
    assert_equal Date.parse("2016-09-01"), robot.date_hired
    assert_equal "department1", robot.department
  end

  def test_it_finds_all_robots
    create_robots(3)

    assert_equal 3, robot_world.all.count

    robot_world.all.each_with_index do |robot, index|
      assert_equal Robot, robot.class
      assert_equal "name#{index+1}", robot.name
      assert_equal "city#{index+1}", robot.city
      assert_equal "avatar#{index+1}", robot.avatar
      assert_equal Date.parse("2015-09-0#{index+1}"), robot.birthdate
      assert_equal Date.parse("2016-09-0#{index+1}"), robot.date_hired
      assert_equal "department#{index+1}", robot.department
    end
  end

  def test_it_finds_a_specific_robot
    create_robots(3)
    ids = robot_world.all.map { |robot| robot.id }

    ids.each_with_index do |id, index|
      robot = robot_world.find(id)
      assert_equal id, robot.id

      assert_equal "name#{index+1}", robot.name
      assert_equal "city#{index+1}", robot.city
      assert_equal "avatar#{index+1}", robot.avatar
      assert_equal Date.parse("2015-09-0#{index+1}"), robot.birthdate
      assert_equal Date.parse("2016-09-0#{index+1}"), robot.date_hired
      assert_equal "department#{index+1}", robot.department
    end
  end

  def test_it_updates_a_robot_record
    create_robots(2)

    new_data = {:name => "updated_name",
                :city => "updated_city",
                :avatar => "updated_avatar",
                :birthdate => Date.parse("2000-01-01"),
                :date_hired => Date.parse("2000-01-01"),
                :department => "updated_department"}

    robot_world.update(robot_world.all.last.id, new_data)

    updated_robot = robot_world.find(robot_world.all.last.id)

    assert_equal "updated_name", updated_robot.name
    assert_equal "updated_city", updated_robot.city
    assert_equal "updated_avatar", updated_robot.avatar
    assert_equal Date.parse("2000-01-01"), updated_robot.birthdate
    assert_equal Date.parse("2000-01-01"), updated_robot.date_hired
    assert_equal "updated_department", updated_robot.department
  end

  def test_it_deletes_a_robot_record
    create_robots(3)

    initial_count = robot_world.all.count

    robot_world.delete(robot_world.all.last.id)

    final_count = robot_world.all.count

    assert_equal 1, (initial_count - final_count)
  end

  def test_it_has_average_robot_age
    robot_world.create(
        name: "name1",
        city: "city1",
        avatar: "avatar1",
        birthdate: "2005-09-01",
        date_hired: "2016-09-01",
        department: "department1"
    )
    robot_world.create(
        name: "name1",
        city: "city1",
        avatar: "avatar1",
        birthdate: "2015-09-01",
        date_hired: "2016-09-01",
        department: "department1"
    )

    assert_equal 6, robot_world.average_age
  end
end
