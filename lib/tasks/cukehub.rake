namespace :cuke do
  desc "cucunber -t <@tags>"
  task :hub, [:tag] do |t, args|
    file = "#{args[:tag]}".gsub(/@/, '')
    Bundler.with_clean_env do
    console_output = ""
      IO.popen("cucumber -t #{args[:tag]} -f rerun --out #{file}.txt", 'r+') do |pipe|
        puts console_output = pipe.read
        pipe.close_write
      end
      IO.popen("cucumber #{args[:tag]}.txt --format html --out=#{file}.html --format pretty", 'r+') do |pipe|
        puts "** RE-RUNNING FAILED #{args[:tags]}.txt SCENARIOS **"
        puts console_output = pipe.read
        pipe.close_write
      end
    end
  end
end