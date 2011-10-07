class RemoveLinksOnImages < ActiveRecord::Migration
  def up
    Content.find_each do |content|
      content.update_attributes :text => content.text.sub(/\<a [^\>]+\>(\<img [^\>]+\>)\<\/a\>/, '\1')
    end
  end

  def down
  end
end
