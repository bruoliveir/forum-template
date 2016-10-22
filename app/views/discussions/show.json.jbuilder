def create_discussions_json(json, root_discussion, parent)
  json.children root_discussion.children do |child|
    json.(child, :title, :body)
    create_discussions_json(json, child, root_discussion)
  end
end

json.(@root_discussion, :title, :body)
create_discussions_json(json, @root_discussion, nil)
