namespace :s3 do
  require "aws-sdk"
  require 'fileutils'
  namespace :import do
    desc "Backup database to Amazon S3"
    
    task :images => :environment do
      credentials = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
      s3          = Aws::S3::Resource.new(credentials: credentials, region: 'ap-southeast-1')
      assets_path = '/Users/pmedrano/Dropbox/ARSI Images Backup/ARSI Images' #directory of pics on Dropbox
      
      bucket      = s3.bucket('porthos')
      # enumerate every object in a bucket
      bucket.objects.each do |obj|
        puts "#{obj.key} => #{obj.etag}"
      end
      raise bucket.inspect
      
      
      all_object_keys = objects.map(&:key)
      
      raise all_object_keys.inspect
      
      puts "List of all buckets (project ids): #{BUCKET.objects.map(&:key).inspect}\n\n"
      puts "Today's date: #{Date.today} \n Preparing to update / backup #{updated_files.size} files"

      updated_files.each do |asset|
        if asset.data_file_name
          file_name  = asset.data_file_name
          asset_path = "#{assets_path}projects/#{asset.project_id}/"
          key_prefix = "#{asset.project_id}/"
          
          puts "Project ID dir: #{key_prefix} :: asset ID: #{asset.id}"
          backup_file = File.join(asset_path, file_name) #/assets/path/filename
          puts "File to be written: #{file_name}"
          
          if all_object_keys.include?(key_prefix)
            obj = BUCKET.objects["#{key_prefix}#{file_name}"]
          else
            begin
              obj = BUCKET.objects["#{key_prefix}#{file_name}"]
              if File.exists?(asset_path)
                puts "Preparing to write file located at: #{asset_path} to S3 "
                obj.write(file: backup_file)
                puts "Wrote file to #{file_name} on s3."
              else
                puts "WARNING. File not found at location: #{asset_path}"
              end
            rescue Exception => e
              puts "There was a problem writing file to S3\n: #{e.message}\n"
              exit
            end
          end
        end
      end
      puts "Backup Complete"
      
      @backup_path = AWS_CONFIG['backup']['backup_path']
      FileUtils.makedirs(@backup_path) #creates path specified just above in case it doesn't exist
    
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
