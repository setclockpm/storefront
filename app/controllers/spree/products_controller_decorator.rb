Spree::Admin::ProductsController.class_eval do
  require 'rake'
  
  
  def count_on_hand
     @variant = Spree::Variant.find(params[:id])
  end
  
  def data
    @spreadsheet = BulkImportFile.new
  end
  
  def bulk_import
    @spreadsheet = BulkImportFile.new(params[:bulk_import_file])
    if @spreadsheet.save
      @output = @spreadsheet.process
      flash[:success] = "Import process complete!"
      redirect_to admin_data_import_path
    else
      flash[:error] = @object.errors.full_messages.join(', ')
    end
  end
  
  def import_images
    generator = ImageGenerator.new
    if generator.process
      flash[:success] = "Image generation process complete!"
      redirect_to admin_data_import_path
    else
      render 'products/data'
      flash[:error] = "There was a problem importing your images."
    end
  end
  
  def index
    @custom_qs_placeholder = "Quick search (by SKU) .."
    session[:return_to] = request.url
    respond_with(@collection)
  end
  
end