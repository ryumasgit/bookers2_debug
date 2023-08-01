class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update]

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.group_users
    user_ids = @group_users.pluck(:user_id)
    @users = User.where(id: user_ids)
    @book = Book.new
  end

  def index
    @book = Book.new
    @groups = Group.all
    @group_users = GroupUser.all
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      @group_user = GroupUser.new(user_id: current_user.id, group_id: @group.id)
      @group_user.save
      redirect_to groups_path, notice: "You have created group successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "You have updated group successfully."
    else
      render "edit"
    end
  end

  def join
    @group_user = GroupUser.new(user_id: params[:user_id], group_id: params[:group_id])
    if @group_user.save
      redirect_to groups_path, notice: "You have joined group successfully."
    end
  end

  def leave
    @group_user = GroupUser.find_by(user_id: params[:user_id], group_id: params[:group_id])
    if @group_user.destroy
      redirect_to groups_path, notice: "You have leaved group successfully."
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to group_path
    end
  end
end
