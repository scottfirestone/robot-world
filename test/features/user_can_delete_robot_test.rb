require_relative '../test_helper'

class UserCanCreateRobot < FeatureTest

  def test_robot_deletion
    robot_world.create({
      name: 'Bender',
      city: 'Futuramatown',
      avatar: '11998',
      birthdate: '2015-09-30',
      date_hired: '2016-09-30',
      department: 'human resources'
      })

    visit '/robots'

    assert page.has_content? 'Bender'
    assert page.has_content? 'Futuramatown'
    assert_equal "https://robohash.org/11998", page.find('.avatar')['src']
    assert page.has_content? '2015-09-30'
    assert page.has_content? '2016-09-30'
    assert page.has_content? 'human resources'
  end
end
