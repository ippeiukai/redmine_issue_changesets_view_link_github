class IssueChangesetsListener < Redmine::Hook::ViewListener

  def view_issue_show_changesets(context)
    projects_github = Setting.plugin_redmine_issue_changesets_view_link_github
    
    github_repo = nil
    github_repo = projects_github[context[:changesets].first.project.identifier] unless projects_github.blank? || context[:changesets].blank?

puts Setting.plugin_redmine_issue_changesets_view_link_github
puts github_repo

    unless github_repo.blank?
      url_for_github_commit = lambda do |revision|
        "https://github.com/%s/commit/%s" % [github_repo, revision]
      end
      context[:controller].send(:render_to_string, {
                                  :partial => "changesets_github",
                                :locals => context.merge({:url_for_revision=>url_for_github_commit})
                                })
    else      
      context[:controller].send(:render_to_string, {
                                  :partial => "changesets_original",
                                  :locals => context  
                                })
    end
    
    
  end
  
end