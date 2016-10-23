def create_discussions_json(json, root_discussion, parent)
  json.children root_discussion.children do |child|
    json.merge! child.attributes
    create_discussions_json(json, child, root_discussion)
  end
end

json.merge! @root_discussion.attributes
create_discussions_json(json, @root_discussion, nil)
