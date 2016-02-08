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
    skip
    robot_world.create(
      id:          "2",
      name:       "name",
      city: "city"
    )

    new_data = {
      :name => "NEW name",
      :city => "NEW city"
    }

    robot_world.update(new_data, 2)

    updated_robot = robot_world.find(2)

    assert_equal new_data[:name], updated_robot.name
    assert_equal new_data[:city], updated_robot.city
  end

  def test_it_deletes_a_robot_record
    skip
    create_robots(3)

    initial_count = robot_world.all.count

    robot_world.delete(robot_world.all.last.id)

    final_count = robot_world.all.count

    assert_equal 1, (initial_count - final_count)
  end
end
