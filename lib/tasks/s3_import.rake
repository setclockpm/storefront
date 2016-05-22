namespace :s3 do
  require "aws-sdk"
  require 'fileutils'
  namespace :import do
    desc "Backup database to Amazon S3"
    
    task :images => :environment do
      s3          = AWS::S3.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: AWS_CONFIG['AWS_SECRET_ACCESS_KEY'])
      BUCKET      = s3.buckets["porthos"]
      
      @orig_dir    = ActiveRecord::Base.configurations[Rails.env]['database']
      @backup_path = AWS_CONFIG['backup']['backup_path']
      FileUtils.makedirs(@backup_path) #creates path specified just above in case it doesn't exist
    
      @datestamp    = Time.now.strftime("%Y%m%d%H%M%S") #for appending to the end of filename so not overwriten immediately
      @day_of_week  = Time.now.strftime("%a")
      @day_of_month = Time.now.strftime("%d") #IN ## format e.g. 05 for May
      @file_name    = file_name
      @bu_file_path = File.join(@backup_path, @file_name) #/backup/path/filename
      
       puts "\n\n\n================================== Beginning image upload task =================================="
       puts "In directory: #{@orig_dir}"
       puts "Backup path (taken from config): #{@backup_path}"
       puts "Day of the week: #{@day_of_week} | Day of the month: #{@day_of_month} | Datestamp #{@datestamp}"
       puts "Path db dump will be exported to including name: #{@bu_file_path}"
       puts "==================================_________________________________==================================\n\n\n"
       
      run_database_backup_tasks
    end
  end
  
  def upload_to_s3
    obj = BUCKET.objects[@file_name]
    
    # Upload of the database dump to Amazon S3 happens only for production unless the next line in commented out.
    return upload_occurs_only_for_production_environment unless Rails.env == 'production'
    puts "About to upload database dump to Amazon S3."
    obj.write(file: dump)
    puts "Uploaded #{@file_name} in bucket: #{BUCKET.name}."
  end
  
  
  private
    def dump
      case Rails.env
        when 'test'        ; `pg_dump -Fc #{@database} > #{@bu_file_path}`
        when 'development' ; `pg_dump -Fc #{@database} > #{@bu_file_path}`
        else
          `PATH=/usr/bin/pg_dump:$PATH sudo -u postgres pg_dump -Fc #{@database} > #{@bu_file_path}`
      end
      @bu_file_path
    end
    
    def failure_message
      puts "There was a problem seeding the staging database from #{@bu_file_path}."
    end
  
    def file_name
      return "#{@database}_#{@datestamp}.out" if (@day_of_month == '01' || @day_of_month == '15')
      "#{@database}_#{@day_of_week}.out"
    end

end
#rsync -a -e "ssh -p 40000" /var/www/cerp/production/shared/backups/*.bak deploy@50.116.5.75:/var/www/cerp/shared/backups
#PATH=/usr/bin/pg_dump:$PATH sudo -u postgres pg_dump -t accounts -Fc cerp_production > accounts.out
#PATH=/usr/bin/pg_dump:$PATH sudo -u postgres pg_dump -Fc cerp_production > backup.out