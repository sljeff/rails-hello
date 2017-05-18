require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "signup failure will not create new user" do
    get signup_path
    assert_select "form[action='/signup']"
    assert_no_difference 'User.count' do
      post signup_path, params: {
        user: {
            name: "",
            email: "hello@world",
            password: "12345",
            password_confirmation: "12345"
        }
      }
    end

    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "signup success will create new user" do
    assert_difference 'User.count', 1 do
      post signup_path, params: {
        user: {
            name: 'jeff lee',
            email: 'rightemail@hi.com.cn',
            password: '1234567',
            password_confirmation: '1234567'
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.include?(:success) and not flash[:success].blank?
    assert_select 'div.msg-success'
  end
end
