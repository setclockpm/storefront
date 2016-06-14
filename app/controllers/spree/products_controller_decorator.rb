Spree::Admin::ProductsController.class_eval do
  
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
    
  end
end