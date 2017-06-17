class PublicController < ApplicationController

  layout 'public'

  before_action :setup_navigation

  def index
    # intro text
  end

  def show
    @page = Page.visible.where(permalink: params[:permalink]).first
    return if @page
    redirect_to(root_path)
  end

  private

  def setup_navigation
    @subjects = Subject.visible.sorted
  end
end
