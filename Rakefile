# -*- ruby -*-
require 'rubygems'
require 'hoe'

$here = File.expand_path('..', __FILE__)

task :"build-examples" do
  Dir[File.join($here, '**/*.ago')].each do |ado|
    gif_file = File.join(File.dirname(ado), File.basename(ado, ".ago") + ".gif")
    cmd = "./bin/agora #{ado} | dot -Tgif -o #{gif_file}"
    puts `#{cmd}`
  end
end

Hoe.spec 'agora' do |p| 
  p.developer('Bernard Lambeau', 'blambeau@gmail.com')

  self.readme_file      = 'README.md'
  self.extra_rdoc_files = FileList['README.md']
  self.extra_dev_deps << [ 'hoe', '>= 2.8.0' ]
end

# vim: syntax=ruby
