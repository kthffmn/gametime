module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "white-font add_fields btn btn-primary", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def rm_tags_and_relations(params)
    no_tagz = params.reject{|k,v| k == "tagizations_attributes"}
    no_tagz.reject{|k,v| k == "relationships_attributes"}
  end

  def get_tag_ids(params)
    params["tagizations_attributes"]["0"]["tag_id"][1..-1]
  end

  def get_relation_ids(params)
    ids = params["relationships_attributes"]["0"]["relation_id"]
    ids ?  return ids : false
  end
end