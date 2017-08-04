class UsersController < ApplicationController
  def tasks
    @user = User.find(params[:id])
    @tasks = User.tasks
  end
end
