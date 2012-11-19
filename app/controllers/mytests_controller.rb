class MytestsController < ApplicationController
  # GET /mytests
  # GET /mytests.xml
  def index
    @mytests = Mytest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mytests }
    end
  end

  # GET /mytests/1
  # GET /mytests/1.xml
  def show
    @mytest = Mytest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mytest }
    end
  end

  # GET /mytests/new
  # GET /mytests/new.xml
  def new
    @mytest = Mytest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mytest }
    end
  end

  # GET /mytests/1/edit
  def edit
    @mytest = Mytest.find(params[:id])
  end

  # POST /mytests
  # POST /mytests.xml
  def create
    @mytest = Mytest.new(params[:mytest])

    respond_to do |format|
      if @mytest.save
        flash[:notice] = 'Mytest was successfully created.'
        format.html { redirect_to(@mytest) }
        format.xml  { render :xml => @mytest, :status => :created, :location => @mytest }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mytest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mytests/1
  # PUT /mytests/1.xml
  def update
    @mytest = Mytest.find(params[:id])

    respond_to do |format|
      if @mytest.update_attributes(params[:mytest])
        flash[:notice] = 'Mytest was successfully updated.'
        format.html { redirect_to(@mytest) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mytest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mytests/1
  # DELETE /mytests/1.xml
  def destroy
    @mytest = Mytest.find(params[:id])
    @mytest.destroy

    respond_to do |format|
      format.html { redirect_to(mytests_url) }
      format.xml  { head :ok }
    end
  end
end
