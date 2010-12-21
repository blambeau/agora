# -*- ruby -*-
$here = File.expand_path('..', __FILE__)

require 'rubygems'
require 'hoe'
require 'spec/rake/spectask'

desc "Build all examples at once"
task :"build-examples" do
  Dir[File.join($here, '**/*.ago')].each do |ado|
    gif_file = File.join(File.dirname(ado), File.basename(ado, ".ago") + ".gif")
    cmd = "./bin/agora #{ado} | dot -Tgif -o #{gif_file}"
    puts `#{cmd}`
  end
end

desc "Run all rspec test"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.ruby_opts = ['-I.', '-Ilib', '-Itest']
  t.spec_files = Dir["#{$here}/test/**/*_spec.rb"]
end

# Hoe specification
Hoe.spec 'agora' do |p| 
  p.developer('Bernard Lambeau', 'blambeau@gmail.com')

  self.readme_file      = 'README.md'
  self.extra_rdoc_files = FileList['README.md']
  self.extra_dev_deps << [ 'hoe', '>= 2.8.0' ]
  self.extra_dev_deps << [ 'minitest', '>= 1.6.0' ]
end

# vim: syntax=ruby
