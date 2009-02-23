class GitScribe
  class Chapter
    attr_accessor :title, :sections
  
    def initialize(title = 'Chapter X', sections = [])
      @title, @sections = title, sections
    end
  end

  class Section
    attr_reader :message
  
    def initialize(message, diff)
      @message, @diff = message, diff
    end
  
    def diff
      @diff.select { |f| valid_file(f.path) }.map do |f|
        type = f.type == "new" ? file_type(f.path) : "diff"
        code, target_file = parse_diff(f.patch, f.type)
        "File: #{target_file}\n\n{% highlight #{type} %}\n#{code}\n{% endhighlight %}\n\n" 
      end.join
    end
  
    private
    def parse_diff(patch, type)
      offset = patch.index(/@@ -\d+,\d+ \+\d+,\d+ @@/) - 1
      header = patch.slice!(0 .. offset)
      target_file = /diff --git a\/(.*?) b\/(.*?)/.match(header)[1]
      patch = patch.split("\n").select do |l| 
        !l.include?("No newline at end of file") 
      end.map { |l| l[1..-1] unless l.match(/@@ -\d+,\d+ \+\d+,\d+ @@/) }.join("\n") if type == "new"
      patch = patch.gsub(/\t/m, "  ")
      [patch, target_file]
    end
  
    # needs to be configurable
    def valid_file(f)
      f =~ /\.rb$|\.mxml$|\.as$/
    end
  
    def file_type(f)
      result = case f
      when /.rb$/ : "ruby"
      when /.mxml$/ : "xml"
      when /.as$/ : "as3"
      else
        "unknown"
      end
    end
  end
end