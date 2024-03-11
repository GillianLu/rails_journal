class ToDosController < ApplicationController
  before_action :set_category
  before_action :authenticate_user!
  before_action :set_to_do, only: [:show, :edit, :update, :destroy, :toggle_completion]


  def new
    @to_do = @category.to_dos.build
  end

  def show
    @tasks_for_today = @category.to_dos.where(deadline: Date.today.all_day)
    @tasks_for_tomorrow = @category.to_dos.where(deadline: Date.tomorrow.all_day)
    @tasks_for_this_week = @category.to_dos.where(deadline: Date.today.all_day..1.week.from_now.all_day)
  end

  def create
    @to_do = @category.to_dos.create(to_do_params)
    if @to_do.persisted?
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @to_do = @category.to_dos.find(params[:id])
  end

  def update
    @category = Category.find(params[:category_id])
    @to_do = @category.to_dos.find(params[:id])
    if @to_do.update(to_do_params)
      redirect_to category_path(@category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @to_do = @category.to_dos.find(params[:id])
    @to_do.destroy
    redirect_to category_path(@category), status: :see_other
  end

  def toggle_completion
    @to_do.completed = !@to_do.completed
    if @to_do.save
      respond_to do |format|
        format.json { render json: { status: 'success', completed: @to_do.completed }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: @to_do.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end




  private
  def set_category
    @category = Category.find(params[:category_id])
  end
  def to_do_params
    params.require(:to_do).permit(:title, :description, :start, :deadline, :completed)
  end

  def set_to_do
      @to_do = @category.to_dos.find(params[:id])
    end
end
