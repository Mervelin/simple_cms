class PagesController < ApplicationController
  layout 'admin'

  before_action :find_subjects, only: %i[new create edit update]
  before_action :set_page_count, only: %i[new create edit update]

  def index
    @pages = Page.all.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(name: 'Default Page')
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      flash[:notice] = 'Page created succefully.'
      redirect_to(pages_path)
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])

    if @page.update_attributes(page_params)
      flash[:notice] = 'Page updated succefully.'
      redirect_to(page_path(@page))
    else

      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    if @page.destroy
      flash[:notice] = 'Page destroyed succefully.'
      redirect_to(pages_path)
    else
      render('delete')
    end
  end

  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end

  def find_subjects
    @subjects = Subject.sorted
  end

  def set_page_count
    @page_count = Page.count
    @page_count += 1 if params[:action] == 'new' || params[:action] == 'create'
  end
end
