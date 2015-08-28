class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.xml {render :xml => @kittens.to_xml}
      format.json {render :json => @kittens.to_json}
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      redirect_to @kitten
      flash[:success] = "Successfully added kitten!"
    else
      render :new
      flash.now[:danger] = "Failed to add kitten"
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(kitten_params)
      redirect_to @kitten
      flash[:success] = "Successfully updated kitten"
    else
      render :edit
      flash.now[:danger] = "Failed to update kitten"
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.xml {render :xml => @kitten.to_xml}
      format.json {render :json => @kitten.to_json}
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    redirect_to root_url
  end

  private
    def kitten_params
      params.require(:kitten).permit(:name, :cuteness, :softness, :age)
    end

end
