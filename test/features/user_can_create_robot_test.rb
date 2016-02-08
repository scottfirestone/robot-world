require_relative '../test_helper'

class UserCanCreateRobot < FeatureTest
  def test_robot_creation_with_valid_attributes
    visit '/robots/new'

    fill_in 'robot[name]', with: 'scottest'
    fill_in 'robot[city]', with: 'denver'
    fill_in 'robot[avatar]', with: '13456'
    fill_in 'robot[birthdate]', with: '2015-09-30'
    fill_in 'robot[date_hired]', with: '2016-09-30'
    fill_in 'robot[department]', with: 'department'

    click_button 'Submit'

    assert_equal '/robots', current_path

    assert page.has_content? 'scottest'
    assert page.has_content? 'denver'
    assert_equal "https://robohash.org/13456", page.find('.avatar')['src']
    assert page.has_content? '2015-09-30'
    assert page.has_content? '2016-09-30'
    assert page.has_content? 'department'
  end
end
