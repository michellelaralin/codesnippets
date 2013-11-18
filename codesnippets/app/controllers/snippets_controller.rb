class SnippetsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    @snippets = Snippet.all
  end

  def new
    @user = current_user
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    @snippet.set_user(current_user)
    if @snippet.save
      redirect_to @snippet, notice: "Added your snippet"
    else
      render 'new'
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])
  end

  def update
    @snippet = Snippet.find(params[:id])
    if @snippet.update(snippet_params)
      redirect_to @snippet
    else
      render 'edit'
    end
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def destroy
    @snippet = Snippet.find(params[:id])
    @snippet.destroy
    redirect_to snippets_path
  end

  private
    def snippet_params
      params.require(:snippet).permit(:code, :description)
    end
    def correct_user
      @snippet = Snippet.find(params[:id])
      redirect_to root_url unless @snippet && @snippet.can_be_edited_by(current_user)
    end
end
