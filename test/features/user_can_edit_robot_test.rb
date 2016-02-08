require_relative '../test_helper'

class UserCanCreateRobot < FeatureTest

  def test_robot_edit
    robot_world.create({
      name: 'Bender',
      city: 'Futuramatown',
      avatar: '11998',
      birthdate: '2015-09-30',
      date_hired: '2016-09-30',
      department: 'human resources'
      })

    visit '/robots/Bender/edit'

    assert_equal 'Bender', page.find('#name')['value']
    assert_equal 'Futuramatown', page.find('#city')['value']
    assert_equal '11998', page.find('#avatar')['value']
    assert_equal '2015-09-30', page.find('#birthdate')['value']
    assert_equal '2016-09-30', page.find('#date_hired')['value']
    assert_equal 'human resources', page.find('#department')['value']
    assert_equal "https://robohash.org/11998", page.find('#randorobo')['src']


    fill_in 'robot[name]', with: 'newname'
    fill_in 'robot[city]', with: 'newcity'
    fill_in 'robot[avatar]', with: 'newavatar'
    fill_in 'robot[birthdate]', with: '2015-10-10'
    fill_in 'robot[date_hired]', with: '2016-10-10'
    fill_in 'robot[department]', with: 'newdept'

    click_button 'Submit'

    assert_equal '/robots', current_path

    assert page.has_content? 'newname'
    assert page.has_content? 'newcity'
    assert_equal "https://robohash.org/newavatar", page.find('.avatar')['src']
    assert page.has_content? '2015-10-10'
    assert page.has_content? '2016-10-10'
    assert page.has_content? 'newdept'
  end
end
