class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.find(params[:review_id])
    @comment = Comment.new
  end

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      ReviewComment.comment(@comment).deliver
      redirect_to site_path(@review.site), notice: "Comment created!"
    else
      render "comments/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @review = Review.find(params[:review_id])
    @site = @review.site
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @site, notice: "Comment updated successfully!"
    else
      render "comments/edit"
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @site = @review.site
    @comment = current_user.comments.find(params[:id])

    @comment.destroy

    redirect_to site_path(@site), notice: "Comment destroyed successfully!"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
