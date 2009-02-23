# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gitscribe}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dima Berastau"]
  s.date = %q{2009-02-22}
  s.default_executable = %q{gitscribe}
  s.email = %q{dima@ruboss.com}
  s.executables = ["gitscribe"]
  s.files = ["README.markdown", "VERSION.yml", "bin/gitscribe", "lib/gitscribe", "lib/gitscribe/models.rb", "lib/gitscribe/options.rb", "lib/gitscribe/template.erb", "lib/gitscribe.rb", "test/gitscribe_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/dima/gitscribe}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Create code-intensive tutorials and articles with Git}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<schacon-git>, [">= 0"])
    else
      s.add_dependency(%q<schacon-git>, [">= 0"])
    end
  else
    s.add_dependency(%q<schacon-git>, [">= 0"])
  end
end
