# encoding: utf-8
[News, Member, Activity, Video, GeneralContent].each { |model| model.delete_all }

# News
News.create :title => "Božićni koncert",
            :text => File.read("db/seed/news.md"),
            :photo => '<a href="http://www.flickr.com/photos/67131352@N04/6771643695/" title="Magnificat by Janko Marohnić, on Flickr"><img src="http://farm8.staticflickr.com/7001/6771643695_b861bddd73_b.jpg" width="456" height="650" alt="Magnificat"></a>'

# GeneralContent
GeneralContent.create :title => "Capella Juris",
                      :photo => '<a href="http://www.flickr.com/photos/67131352@N04/6109212127/"><img src="http://farm7.staticflickr.com/6077/6109212127_ebdf4f9f49_m.jpg" width="240" height="161" alt="Capella juris"></a>',
                      :text => File.read("db/seed/intro.md")
GeneralContent.create :title => "Povijest zbora",
                      :photo => '<a href="http://www.flickr.com/photos/67131352@N04/6109212283/"><img src="http://farm7.staticflickr.com/6076/6109212283_41d11b788a_m.jpg" width="240" height="162" alt="povijest_zbora"></a>',
                      :text => File.read("db/seed/povijest_zbora.md")
GeneralContent.create :title => "Biografija dirigenta",
                      :photo => '<a href="http://www.flickr.com/photos/67131352@N04/6109212199/"><img src="http://farm7.staticflickr.com/6090/6109212199_3a843ae74c_m.jpg" width="158" height="108" alt="biografija_dirigenta"></a>',
                      :text => File.read("db/seed/biografija_dirigenta.md")

# Members
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

# Activities
Dir["db/seed/activities/*.md"].each do |path|
  year = File.basename(path).chomp(".md").to_i
  activities = File.read(path)
  Activity.create :year => year,
                  :bullets => activities
end

# Videos
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
