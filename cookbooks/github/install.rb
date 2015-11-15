if yes?("Create a GitHub repository? (y/n)")
    run "hub create #{app_path.basename.to_s}"
    result = `hub remote -v | awk '{ print $2}' | head -n1`
    repository = result.strip
    gsub_file "config/deploy.rb", /git.*git/, repository
    git add: '.'
    git commit: %q{ -m 'oh-my-rails: add repo'}
    run "hub push -u origin master"
else
    #if github repo didn't create, then choose your own
    repository = ask("input your project's repo")
    gsub_file "config/deploy.rb", /git.*git/, repository
end