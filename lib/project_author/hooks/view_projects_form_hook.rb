module RedmineProjectAuthor
  module Hooks
    class ViewProjectsFormHook < Redmine::Hook::ViewListener
      render_on :view_projects_form, :partial => 'hooks/project_form'
    end
  end
end