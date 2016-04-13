require 'sass_paths'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

data.projects.each do |key, project|
  proxy "/projects/#{key}.html", "/project.html", :locals => { :project => project }, :ignore => true
end

# Create an example page for visualising where data is used
data.examples.each do |key, project|
  proxy "/example-project.html", "/project.html", :locals => { :project => project, :regions => true }, :ignore => true
end

# ignore proxy templates
ignore "/project.html"

# General configuration

Slim::Engine.disable_option_validator!
Slim::Engine.set_options pretty: true
Slim::Engine.set_options attr_list_delims: { '(' => ')', '[' => ']' }

set :layout, 'ukti'

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def get_projects_by_phase(phase)
    data.projects.select { |k,p| p.phase == phase }
  end

  def get_project_count_by_phase(phase)
    get_projects_by_phase(phase).count
  end
end

# Load Sass paths and copy images & layouts
require 'find'
`mkdir -p "#{config.source}/#{config.images_dir}" "#{config.source}/#{config.layouts_dir}"`
Find.find('node_modules').grep(/mojular[a-z-]+\/package\.json/).map do |package|
  sassPaths = JSON.parse(IO.read(package))['sassPaths']
  dirname = File.dirname(package)
  sassPaths.map { |path| SassPaths.append(File.expand_path(path, File.directory?(path) ? '' : dirname)) } if sassPaths
  FileUtils.cp_r Find.find(dirname).grep(/images\//), "#{config.source}/#{config.images_dir}"
  FileUtils.cp_r Find.find(dirname).grep(/layouts\/erb\//), "#{config.source}/#{config.layouts_dir}"
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
