class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy refresh]

  def index
    @lists = current_user.lists.where(active: true)
  end

  def show
    @posts = @list.posts
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user

    if @list.save
      redirect_to list_new_select_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  def destroy
    @list.active = false
    @list.save
    redirect_to lists_path, status: :see_other
  end

  def refresh
    RefreshListJob.perform_later(params[:id])  # <- The job is queued
    flash[:notice] = "Refreshing may take a few moments..."
    redirect_to root_path
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
