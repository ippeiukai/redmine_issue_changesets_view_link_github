class IssueChangesetListener < Redmine::Hook::ViewListener

  def view_issue_show_changeset(context)
    changeset = context[:changeset]
  
    projects_github = Setting.plugin_redmine_issue_changesets_view_link_github
    github_repo = nil
    github_repo = projects_github[changeset.project.identifier] unless projects_github.blank?
    
    unless github_repo.blank?
      url = "https://github.com/%s/commit/%s" % [github_repo, changeset.identifier]
    else
      rev = changeset.respond_to?(:identifier) ? revision.identifier : revision
      url = url_for({:controller => 'repositories', :action => 'revision', :id => project.identifier, :rev => rev})
    end
    context[:controller].send(:render_to_string, {
                                :partial => "changeset_github",
                                :locals  => context.merge({:url_for_revision=>url})
                              })
  end
  
end