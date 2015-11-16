application "config.time_zone = 'Beijing'"

insert_into_file 'app/helpers/application_helper.rb' do
  <<-EOS.strip_heredoc
    def render_normal_time(from_time)
      if from_time < 7.days.ago
        I18n.l from_time, format: :long
      else
        time_ago_in_words(from_time)
      end
    end
  EOS
end