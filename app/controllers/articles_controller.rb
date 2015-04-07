class ArticlesController < ApplicationController
  respond_to :xlsx, :html
  def index
    @article = Article.page(params[:page]) .per(5)
   
  end

  def new
	@article = Article.new
  end

  def edit
    @article = Article.find_by_id(params[:id])
  end
  
  def update
    @article = Article.find_by_id(params[:id])
    if @article.update(params_article)
      flash[:notice] = "Success Update Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end
  
  def destroy
    @article = Article.find_by_id(params[:id])
    if @article.destroy
      flash[:notice] = "Success Delete a Records"
      redirect_to action: 'index'
    else
      flash[:error] = "fails delete a records"
      redirect_to action: 'index'    
  
    end
  end

  def show
    @article = Article.find_by_id(params[:id])
     respond_to do |format|
      format.html
      format.xlsx
    end
  end
  
  def create
     @article = Article.new(params_article)
     if @article.save
       flash[ :notice ] = "Sucess Add Record"
       redirect_to action: 'index'
    else
      flash[ :error ] = "Data not valid"
      render 'new'
   end
  end
  
  def import
    Article.import(params[:file])
    redirect_to root_url, notice: "Success"
  end
     
  private 
    def params_article
      params.require(:article).permit(:title, :content, :status)
 
  end
end

