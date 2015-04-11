class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    #byebug  
    p = upload_params
    @upload = Upload.new
    data = p[:datafile]
    @upload.name = data.original_filename
    @upload.content_type = data.content_type
    full_filename = Rails.root.join('public', 'uploads', data.original_filename)
    #save the file
    File.open(full_filename, 'wb') do |f|
      f.write(data.read)
    end
    #add size
    @upload.size = File.stat(full_filename).size
    
    respond_to do |format|
      if @upload.save
        format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        format.json { render :show, status: :created, location: @upload }
      else
        format.html { render :new }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    full_filename = Rails.root.join('public', 'uploads', @upload.name)
    if File.exist?(full_filename)
      File.delete(full_filename)
    end
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params.require(:upload).permit(:datafile)
    end
end
