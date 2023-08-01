class EventNoticesController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
  end

  def create
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @title = params[:title]
    @body = params[:body]
    EventMailer.send_mail(@title, @body,group_users).deliver
  end
end