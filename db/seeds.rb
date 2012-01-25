# encoding: utf-8

[News, Member, Activity, Video].each { |model| model.delete_all }

News.create :title => "Božićni koncert",
            :text => File.read("db/seed/news.md"),
            :photo => '<img src="/images/plakat.jpg" alt="Plakat" />'

%w[sopranos altos tenors bassos].each do |voice_range|
  file_with_singers = File.read("db/seed/#{voice_range}.txt")
  singers = file_with_singers.each_line.collect(&:strip).collect { |singer| singer.split(" ") }
  singers.each do |name|
    if name.size == 2
      Member.create(:first_name => name.first, :last_name => name.last, :vocal_range => voice_range[0].capitalize)
    else
      Member.create(:first_name => "#{name.first} #{name.second}", :last_name => name.last, :vocal_range => voice_range[0].capitalize)
    end
  end
end

Dir["db/seed/activities/*.md"].each do |path|
  year = File.basename(path).chomp(".md").to_i
  activities = File.read(path)
  Activity.create :year => year,
                  :bullets => activities
end

File.read("db/seed/videos.txt").each_line.collect(&:strip).each_with_object({}) do |line, video|
  if line.present?
    if line !~ /iframe/
      video[:title] = line
    else
      video[:link] = line
      Video.create(:title => video[:title], :link => video[:link])
    end
  else
    video.clear
  end
end
