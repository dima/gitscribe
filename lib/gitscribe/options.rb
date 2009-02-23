class GitScribe
  class Options < Hash
    attr_reader :opts

    def initialize(args)
      super()

      self[:title] = "Cool Tutorial"
      self[:location] = "Vancouver, BC"
      
      @opts = OptionParser.new do |o|
        o.banner = "Usage: #{File.basename($0)} [options] reponame\ne.g. #{File.basename($0)} cool-tutorial"

        o.on('--output [FILE]', 'Output file to generate blog post to') do |output|
          self[:output] = output
        end

        o.on('--title [TITLE]', 'Blog post title to use', "Default: #{self[:title]}") do |title|
          self[:title] = title
          self[:output] = default_output unless self[:output]
        end

        o.on('--location [LOCATION]', 'Add geo location to the blog post', "Default: #{self[:location]}") do |location|
          self[:location] = location
        end

        o.on_tail('-h', '--help', 'display this help and exit') do
          self[:show_help] = true
        end
      end
      
      @opts.parse!(args)
    end
    
    def default_output
      "#{Date.today.strftime("%Y-%m-%d")}-#{self[:title].gsub(/\s/, '-').downcase}.textile"
    end
  end
end