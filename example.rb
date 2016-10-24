paths = [{"n"=>"home", "p"=>"1."}, {"n"=>"about", "p"=>"2."}, {"n"=>"history", "p"=>"1.3."}, {"n"=>"company", "p"=>"2.4."}, {"n"=>"history/part1", "p"=>"1.5."}]

auto_hash = Hash.new{ |h,k| h[k] = Hash.new &h.default_proc }

paths.each do |path|
  sub = auto_hash
  path["p"].split(".").each{ |dir| sub[dir]; sub = sub[dir]; sub["n"] = path["n"]}
end

p auto_hash

json = {}
paths.each do |p|
  sub = {}
  p["p"].split(".").each do |e|
    if sub[e]
      sub = sub[e]
    else
      json[e] = p
    end
  end
end

#p json
