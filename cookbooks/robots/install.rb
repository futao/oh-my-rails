if yes?("是否创建--robots.txt文件？--")
  create_file 'robots.txt' do
    <<-EOS.strip_heredoc
  	  User-agent: *
  	  Disallow: /
    EOS
  end
end
