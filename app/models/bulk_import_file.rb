
class BulkImportFile
  extend ActiveModel::Callbacks
  include ActiveModel::Model
  include Paperclip::Glue

  # Paperclip required callbacks
  define_model_callbacks :save, only: [:after]
  define_model_callbacks :commit, only: [:after]
  define_model_callbacks :destroy, only: [:before, :after]

  attr_accessor :data_file_name, :data_content_type, :data_file_size, :data_updated_at, :id

  has_attached_file :data, url:  ":rails_root/public/assets/imports/:basename.:extension", 
                           path: ":rails_root/public/assets/imports/:basename.:extension"
                           
  do_not_validate_attachment_file_type :data
  #validates_attachment :data, presence: true, content_type: { content_type: %w(application/vnd.ms-excel application/vnd.openxmlformats-officedocument.dataml.sheet text/csv ) }
  

  def save
    run_callbacks :save do 
      self.id = 1000 + Random.rand(9000)
    end
    return true
  end
  
  def process
    system "bundle exec thor datashift_spree:load:products -i #{data.url(:default, timestamp: false)} -v" #2>&1
    #syscall('bundle exec thor datashift_spree:load:products -v -i', data.url)
  end

  def destroy
    run_callbacks :destroy
  end

  def updated_at_short
    return Time.now.to_s(:autosave_time) 
  end

  def errors
    obj = Object.new
    def obj.[](key)         [] end
    def obj.full_messages() [] end
    def obj.any?()       false end
    obj
  end
  
  
  private
  
    def syscall(*cmd)
      begin
        stdout, stderr, status = Open3.capture3(*cmd)
        status.success? && stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
      rescue
      end
    end
  
end

  
