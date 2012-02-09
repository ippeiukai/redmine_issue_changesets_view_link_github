require 'redmine'

require 'issue_changesets_listener'

Redmine::Plugin.register :redmine_issue_changesets_view_link_github do
  name 'Redmine Issue Changesets View Link Github plugin'
  author 'Ippei Ukai'
  description 'This plugin changes Changesets view (list of revisions) in the issue view to link to GitHub instead of repository browser.'
  settings({
    :default => {},
    :partial => 'settings/changesets_github_settings',
  })
end