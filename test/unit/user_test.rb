require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:jason).profile_name

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile_name without spaces" do
    user = User.new(first_name: 'Jason', last_name: 'Neel', email: 'jasonneel2@yahoo.com')
    user.password = user.password_confirmation = "Password"

  	user.profile_name = "My Profile With Spaces"

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("must be formatted correctly.")
  end

  test "a user can have a correctlly formatted profile_name" do
    user = User.new(first_name: 'Jason', last_name: 'Neel', email: 'jasonneel2@yahoo.com')
    user.password = user.password_confirmation = "Password"
    user.profile_name = 'jasonneel2'

    assert user.valid?
  end

  test "no error is raised when trying to access a friends list" do
    assert_nothing_raised do
      users(:jason).friends
    end
  end

  test "creating friendships on a user works" do
    users(:jason).friends << users(:mike)
    users(:jason).friends.reload
    assert users(:jason).friends.include?(users(:mike))
  end
end
