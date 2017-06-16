class SectionsController < ApplicationController
  layout 'admin'

  before_action :find_pages, only: %i[new create edit update]
  before_action :set_section_count, only: %i[new create edit update]

  def index
    @sections = Section.all.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = 'Page created succesfully'
      redirect_to(sections_path)
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = 'Section updated succesfully.'
      redirect_to(sections_path)
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to(sections_path)
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

  def find_pages
    @pages = Page.sorted
  end

  def set_section_count
    @section_count = Section.count
    @section_count += 1 if params[:action] == ('new' || 'create')
  end
end
