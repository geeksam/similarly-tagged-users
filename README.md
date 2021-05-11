This is just a quick demo in response to a question on the pdxruby.org Slack list.

The question was, basically, how to retrieve a list of users sorted by the number of tags they had in common with a specific user.

The only interesting bits here are in the following files:
- `db/schema.rb`
- `spec/models/user_spec.rb`
- `app/models/user.rb`
