# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{alastrina}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Medinets"]
  s.cert_chain = ["/home/medined/projects/alastrina/gem-public_cert.pem"]
  s.date = %q{2010-06-26}
  s.description = %q{Tracks changes to models}
  s.email = %q{david.medinets@gmail.com}
  s.extra_rdoc_files = ["lib/alastrina.rb"]
  s.files = ["Rakefile", "lib/alastrina.rb", "Manifest", "alastrina.gemspec"]
  s.homepage = %q{http://github.com/medined/alastrina}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Alastrina"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{alastrina}
  s.rubygems_version = %q{1.3.5}
  s.signing_key = %q{/home/medined/.ssh/gem-private_key.pem}
  s.summary = %q{Tracks changes to models}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
