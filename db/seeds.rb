# encoding: utf-8
[News, Member, Activity, Video, GeneralContent, Sidebar, Audio].each { |model| model.delete_all }

def yaml(filename)
  YAML.load(File.open("db/seed/#{filename}")).symbolize_keys
end

News.create yaml("vijest.yml")

%w[intro povijest_zbora biografija_dirigenta].each do |filename|
  GeneralContent.create yaml("#{filename}.yml")
end

sidebar = Sidebar.create(yaml("sidebar.yml"))
sidebar.build_audio(yaml("audio.yml")).save(:validate => false)
sidebar.save

%w[soprani alti tenori basi].each do |filename|
  names = File.read("db/seed/#{filename}.txt").each_line.collect { |singer| singer.chomp.split(" ") }
  singers = names.collect { |name| {:first_name => name[0..-2].join(" "), :last_name => name.last, :voice => filename[0].capitalize} }
  singers.each { |singer_hash| Member.create(singer_hash) }
end

yaml('activities.yml').each { |year, bullets| Activity.create :year => year, :bullets => bullets }

yaml('videos.yml').each { |key, video_hash| Video.create(video_hash) }

undef yaml
