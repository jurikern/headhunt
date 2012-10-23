developers_group = []

developers_group << User.new({
    username: "grigori",
    email:    "grigori@headhunt.ee",
    password:  "qwerty"
})

developers_group << User.new({
    username: "juri",
    email:    "juri@headhunt.ee",
    password: "qwerty"
})

User.transaction do
  developers_group.each do |developer|
    developer.save! validate: false
    developer.confirm!
  end
end
