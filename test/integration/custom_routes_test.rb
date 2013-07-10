require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
	test "that /login opens the log in page" do
		get '/login'
		assert_response :success
	end

	test "that /logout logs the user out" do
		get '/logout'
		assert_response :redirect
		assert_redirected_to '/'
	end

	test "that /register opens the registration page" do
		get '/register'
		assert_response :success
	end

	test "that /username opens the user profile page" do
		get '/jasonneel'
		assert_response :success
	end
end
