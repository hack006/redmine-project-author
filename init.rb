require 'redmine'
require 'project_author/hooks/view_projects_form_hook'
require 'project_author/patches/project_patch'

Redmine::Plugin.register :project_author do
  name 'Project Author plugin'
  author 'Ondrej Janata <o.janata@gmail.com>'
  description 'Project author plugin enables to add author of the project.'
  version '0.0.1'
end

# Patch project - add new behavior to save project user
#
# Called every time project file is changed.
Rails.application.config.to_prepare do
  Project.send(:include, RedmineProjectAuthor::Patches::ProjectPatch)
end
