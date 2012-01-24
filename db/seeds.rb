# encoding: utf-8

[Intro, News, GeneralContent, Member, Activity, AboutUsContent, Video].each { |model| model.delete_all }

Intro.create :title => "Capella Juris",
             :text => File.read("db/seed/intro.md"),
             :photo_link => '<img src="/images/capella_juris.jpg" alt="Capella juris" />',
             :video_title => "Makedonska Humoreska",
             :video => '<iframe width="306" height="180" src="http://www.youtube.com/embed/FAi48kKVTS4?rel=0" frameborder="0" allowfullscreen></iframe>'

News.create :title => "Božićni koncert",
            :text => File.read("db/seed/news.md"),
            :photo_link => '<img src="/images/plakat.jpg" alt="Plakat" />'

general_content1 = GeneralContent.create :title => "Povijest zbora",
                                         :photo_link => '<img src="/images/povijest_zbora.jpg" alt="Povijest zbora" />',
                                         :text => File.read("db/seed/povijest_zbora.md")
general_content2 = GeneralContent.create :title => "Biografija dirigenta",
                                         :photo_link => '<img src="/images/biografija_dirigenta.jpg" alt="Jurica Petar Petrač" />',
                                         :text => File.read("db/seed/biografija_dirigenta.md")

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

AboutUsContent.create :content_id => general_content1.id,
                      :content_type => "general_content",
                      :content_order => 1
AboutUsContent.create :content_id => general_content2.id,
                      :content_type => "general_content",
                      :content_order => 2
AboutUsContent.create :content_type => "members",
                      :content_order => 3
AboutUsContent.create :content_type => "activities",
                      :content_order => 4

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
