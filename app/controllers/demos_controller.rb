class DemosController < ApplicationController
  before_action :verify_is_admin, :only => [:new, :edit, :create, :destroy]
  def new
    @demo = Demo.new
  end

  def create
    @demo = Demo.new(demo_params)
    if @demo.save
      redirect_to @demo
    else
      render 'new'
    end
  end

  def index
    @demos = Demo.all.order('created_at DESC')
  end

  def show
    @demo = Demo.find(params[:id])
  end

  def edit
    @demo = Demo.find(params[:id])
  end

  def update
    @demo = Demo.find(params[:id])
    if @demo.update(params[:demo].permit(:d_pic, :m_pic, :t_pic, :r1_pic, :r2_pic, :name, :b_amount, :description))
      redirect_to demo_path
    else
      render 'edit'
    end
  end

  def destroy
    @demo = Demo.find(params[:id])
    @demo.destroy
    redirect_to demos_path
  end

  private

  def demo_params
    params.require(:demo).permit(:d_pic, :m_pic, :t_pic, :r1_pic, :r2_pic, :name, :b_amount, :description)
  end

  def verify_is_admin
  (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end

end
