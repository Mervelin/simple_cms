class SubjectsController < ApplicationController
  layout 'admin'

  before_action :set_subject_count, only: %i[new create edit update]

  def index
    logger.debug('************* Testing the logger ************8')
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new(name: 'Default')
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      flash[:notice] = 'Subject created succefulyy.'
      redirect_to(subjects_path)
    else
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])

    if @subject.update_attributes(subject_params)
      flash[:notice] = 'Subject updated successfully.'
      redirect_to(subject_path(@subject))
    else
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed successfully."
    redirect_to(subjects_path)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def set_subject_count
    @subject_count = Subject.count
    @subject_count += 1 if params[:action] == ('new' || 'create')
  end
end