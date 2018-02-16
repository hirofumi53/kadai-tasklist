class TasklistsController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
    @tasklists = Tasklist.all
  end
  
  def show
    correct_user
    
  end
  
  def new
    @tasklist = Tasklist.new
  end
  
  def create
    @tasklist = current_user.tasklists.build(tasklist_params)
    
    if @tasklist.save
      flash[:success] = 'Tasklist が正常に追加されました'
      redirect_to root_url
    else
      @tasklist = current_user.tasklists.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'Tasklist が追加されませんでした'
      render 'toppages/index'
    end
  end
  
  def edit
    correct_user
    
  end
  
  def update
    correct_user
    
    
    
    if @tasklist.update(tasklist_params)
      flash[:success] = 'Tasklist は正常に更新されました'
      redirect_to @tasklist
    else
      flash.now[:danger] = 'Tasklist は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    correct_user
    
    
    @tasklist.destroy
    
    flash[:success] = 'Tasklistは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end

private


  
  #Strong Paramater
  def tasklist_params
    params.require(:tasklist).permit(:content, :status)
  end
  
  def correct_user
    @tasklist = current_user.tasklists.find_by(id: params[:id])
    unless @tasklist
      redirect_to root_url
    end
  end
  

end
