require 'git'
require 'erb'
require 'gitscribe/options'
require 'gitscribe/models'

class GitScribe
  class << self
    def run!(*arguments)
      options = GitScribe::Options.new(arguments)

      if options[:show_help]
        $stderr.puts options.opts
        return 1
      end

      unless arguments.size == 1
        $stderr.puts options.opts
        return 1
      end
      
      g = Git.open(arguments.first)

      tags = Array.new
      g.tags.each { |t| tags << t.name }

      chapters = Array.new
      if tags.empty?
        chapter = Chapter.new
        g.log.each { |c| add_section(chapter.sections, c) }
        chapters << chapter
      else
        tags.each_index do |i|
          chapter = Chapter.new(tags[i])
          g.log.between(tags[i], tags[i + 1]).each { |c| add_section(chapter.sections, c) } if i + 1 < tags.size
          chapters << chapter if !chapter.sections.empty?
        end
      end

      template = File.read(File.dirname(__FILE__) + "/gitscribe/template.erb")

      f = File.new(options[:output], "w+")
      f.puts(ERB.new(template).result(binding))
    end
    
    def add_section(target, c)
      target << GitScribe::Section.new(c.message(), c.parent().diff(c)) if c.parent()
    end    
  end
end


