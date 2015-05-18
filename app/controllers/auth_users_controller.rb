class AuthUsersController < ApplicationController
  def new
    @authuser = Authuser.new
  end
end
