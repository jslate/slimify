class Slimify

  def self.slimify(files)
    files.each do |file|
      self.pre_clean(file)
      haml_file = self.generate_haml(file)
      self.generate_slim(haml_file)
      `rm #{haml_file}`
      `mv #{file} #{file}.old`
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
    `html2haml -e #{file} #{haml_file_name}`
    haml_file_name
  end

  def self.generate_slim(haml_file)
    slim_file_name = haml_file.sub(/\.haml$/, '.slim')
    `haml2slim #{haml_file} #{slim_file_name}`
    slim_file_name
  end

end
