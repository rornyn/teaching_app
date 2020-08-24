class CommentsController < ApplicationController
  before_action :set_course
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = @course.comments.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @course.comments.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @course.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to course_comments_path(@course, @comment), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      strong_params = params.require(:comment).permit(:message)
      strong_params.merge(user_id: current_user.id)
    end

    def set_course
      @course  = Course.find params[:course_id]
    end
end
