class CommentsController < ApplicationController
  def index
  end

  def new
  @comment = Comment.new(:article_id => params[:article_id])
  end

  def edit
  end
  
 def create
     @comment = Comment.new(params_comment)
     if @comment.save
       flash[ :notice ] = "Sucess Add Record"
       redirect_to @comment.article
    else
      flash[ :error ] = "Data not valid"
      render 'new'
   end
  end
    
  private 
    def params_comment
      params.require(:comment).permit(:article_id,:user_id,:content, :status)
 
  end
  
end
