class Slimify

  def self.slimify(files)
    files.each do |file|
      self.pre_clean(file)
      haml_file = self.generate_haml(file)
      self.generate_slim(haml_file)
      run_command "rm #{haml_file}"
      run_command "mv #{file} #{file}.old"
    end
  end
  
  def self.pre_clean(file)
    contents = File.read(file)

    # get rid of dashes in start of erb tags
    contents.gsub!(/<%-/, '<%')

    # get rid of newlines in erb output tags that mess up erb2haml
    contents.gsub!(/<%=.*?%>/m) do |match|
      match.gsub!(/\s+/, ' ')
    end

    File.open(file, 'w') do |f|
      f.write contents
    end

  end

  def self.generate_haml(file)
    haml_file_name = file.sub(/\.erb$/, '.haml')
    run_command "html2haml -e #{file} #{haml_file_name}"
    haml_file_name
  end

  def self.generate_slim(haml_file)
    slim_file_name = haml_file.sub(/\.haml$/, '.slim')
    run_command "haml2slim #{haml_file} #{slim_file_name}"
    slim_file_name
  end

  private

  def self.run_command(cmd)
    puts "cmd: #{cmd}"
    puts "Command #{cmd} failed: #{$!}" unless system(cmd) == 0
  end

end
