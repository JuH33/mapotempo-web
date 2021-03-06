require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  set_fixture_class delayed_jobs: Delayed::Backend::ActiveRecord::Job

  setup do
    @request.env['reseller'] = resellers(:reseller_one)
    @user = users(:user_one)
    sign_in users(:user_one)
  end

  test 'user can only manage itself' do
    ability = Ability.new(users(:user_one))
    assert ability.can? :edit, users(:user_one)
    assert ability.can? :update, users(:user_one)
    ability = Ability.new(users(:user_three))
    assert ability.cannot? :manage, users(:user_one)
    sign_in users(:user_three)
    get :edit, customer_id: @user.customer_id, id: @user
    assert_response :redirect
  end

  test 'admin user can only manage users from its customer' do
    ability = Ability.new(users(:user_admin))
    assert ability.can? :manage, users(:user_one)
    assert ability.cannot? :manage, users(:user_three)
  end

  test 'should get edit' do
    get :edit, customer_id: @user.customer_id, id: @user
    assert_response :success
    assert_valid response
  end

  test 'should update user' do
    patch :update, customer_id: @user.customer_id, id: @user, user: { layer_id: @user.layer.id }
    assert_redirected_to [:edit, @user.customer]
  end

  test 'should get edit password' do
    sign_out :user
    user = users(:unconfirmed_user)
    get :password, customer_id: user.customer_id, id: user.id, token: user.confirmation_token
    assert_response :success
    assert_valid response
  end

  test 'should update user password' do
    sign_out :user
    user = users(:unconfirmed_user)
    assert !user.confirmed?
    patch :set_password, customer_id: user.customer_id, id: user.id, token: user.confirmation_token, user: { password: "abcd1212", password_confirmation: "abcd1212" }
    assert assigns(:user).confirmed?
    assert_redirected_to [:edit, @user.customer]
  end
end
