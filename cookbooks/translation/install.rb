gsub_file 'config/application.rb', /# config.i18n.default_locale.*$/, "config.i18n.default_locale = 'zh-CN'"
create_file "config/locales/active_record.yml" do
  <<-EOS.strip_heredoc
    zh-CN:
      activerecord:
        models:

        attributes:
  EOS
end

# common translation
create_file 'config/locales/view.yml' do
  <<-EOS.strip_heredoc
    zh-CN:
      common: &common
        actions: 操作
        show: 详情
        edit: 编辑
        destroy: 删除
        back: 返回
        submit: 提交
  EOS
end

# kaminari
create_file 'config/locales/kaminari.yml' do
  <<-EOS.strip_heredoc
  zh-CN:
    views:
      pagination:
        first: "&laquo; 第一页"
        last: "最后一页 &raquo;"
        previous: "&lsaquo; 前一页"
        next: "下一页 &rsaquo;"
        truncate: "&hellip;"
    helpers:
      page_entries_info:
        one_page:
          display_entries:
            zero: "No %{entry_name} found"
            one: "Displaying <b>1</b> %{entry_name}"
            other: "Displaying <b>all %{count}</b> %{entry_name}"
        more_pages:
          display_entries: "Displaying %{entry_name} <b>%{first}&nbsp;-&nbsp;%{last}</b> of <b>%{total}</b> in total"

  EOS
end
