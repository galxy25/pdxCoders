# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )


#Comment this out if you want to only serve the controller specific .js and .css files for each view
# %w( users sessions homepage ).each do |controller|
#   Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
# end
#And add these lines to your layouts/application.html.erb
# <%= stylesheet_link_tag "application", params[:controller], :media => "all" %>
# <%= javascript_include_tag "application", params[:controller] %>
#As well as removing the require_tree . from application{.css, .jss}
