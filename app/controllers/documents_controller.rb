class DocumentsController < ApplicationController
  def index
    @document = Current.user.documents.build
    @documents = Current.user.documents.with_attached_file.order(created_at: :desc)
  end

  def create
    @document = Current.user.documents.build(document_params)

    if @document.save
      redirect_to documents_url
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    Current.user.documents.find(params[:id]).destroy!
    redirect_to documents_url
  end

  private

  def document_params
    params.require(:document).permit(:file)
  end
end
