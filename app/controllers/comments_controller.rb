class CommentsController < ApplicationController
  before_action :authenticate_company!

  # POST /admin/comments
  # POST /admin/comments.json
  def create
    @tour = Tour.find(params[:tour_id])
    @comment = Comment.new(comment_params)
    @comment.author_name = current_company.name
    @comment.tour = @tour

    respond_to do |format|
      if @comment.save
        format.js   { render inline: "location.reload();" }
        format.html { redirect_to request.referrer,
                      notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created,
                      location: tour_path(@tour) }
      else
        format.html { redirect_to request.referrer }
        format.json { render json: @comment.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.fetch(:comment, {}).permit(:comment_body, :tour_id)
  end
end
