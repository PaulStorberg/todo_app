class UsersController < ApplicationController

  def self.sign_up
    UsersView.sign_up
  end

  def self.create(username, password)
    User.create(username: username, password: password)
    if true
      UsersController.create_session(username, password)
    else
      return
    end
  end

  def self.new_session
    UsersView.sign_in
  end

  def self.create_session(username, password)
    return self.new_session if username.nil? || password.nil?
    @user = User.find_and_verify(username, password)
    @user.nil? ? UsersController.new_session : UsersView.show(@user)
  end
end
