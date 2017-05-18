require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Jeff Kind', email: 'kindjeff.com@gmail.com',
                     password: 'jeff123', password_confirmation: 'jeff123')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = '    '
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = '    '
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@kindjeff.com"
    assert_not @user.valid?
  end

  test "wrong email should be invalid" do
    invalid_email = %w[user@ex,com hello_world.com foo@bar..com
                        hi.hello@hi. hi@a_b.com as@a+b.com]

    invalid_email.each do |em|
      @user.email = em
      assert_not @user.valid?, "#{em.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    dup_user = @user.dup
    dup_user.email.upcase!
    @user.save
    assert_not dup_user.valid?
  end

  test "email should be saved as lower case" do
    mix_email = "HelloWorld@Help.CoM"
    @user.email = mix_email
    @user.save
    assert_equal mix_email.downcase, @user.reload.email
  end

  test "password should be long enough" do
    @user.password = @user.password_confirmation = '12345'
    assert_not @user.valid?
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = "\t \t"
    assert_not @user.valid?
  end
end
