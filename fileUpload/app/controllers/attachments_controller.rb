class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  # GET /attachments.json
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  # POST /attachments.json
  def create
    debugger
    @attachment = Attachment.new(attachment_params)
    forum_id = attachment_params[:forum_id]
    if attachment_params[:file_name].present?
      @attachment.file_name = attachment_params[:file_name].original_filename
      file_contents = attachment_params[:file_name].read
      @attachment.file_contents = file_contents
      @attachment.file_size = attachment_params[:file_name].size
      @attachment.content_type = attachment_params[:file_name].content_type
      @attachment.file_summary = attachment_params[:file_summary]
      @attachment.forum_id = forum_id
    end

    respond_to do |format|
      if @attachment.save

        format.html { redirect_to forum_path(forum_id), notice: 'Attachment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @attachment }
      else
        format.html { render action: 'new' }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1
  # PATCH/PUT /attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to @attachment, notice: 'Attachment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url }
      format.json { head :no_content }
    end
  end
  def download_attachment
   attachment = Attachment.where(id:params[:id]).first
       debugger
    send_data attachment.file_contents, filename: attachment.file_name, type: attachment.content_type, disposition: :attachment
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:file_contents, :file_name, :file_summary, :content_type, :file_size, :forum_id)
    end
end
