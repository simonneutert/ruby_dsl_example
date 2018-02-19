require_relative "post_as_dsl"

# granular
post_as 'markz' do
  text """Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
  Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
  in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  """
  hashtag 'ruby'
  hashtag 'dsl'
  link 'http://www.simon-neutert.de'
  sexy 'objects'
end

# multiple hashtags
post_as 'markz' do
  text 'my dsl works'
  hashtag 'ruby', 'dsl'
  link 'http://www.simon-neutert.de'
  sexy 'classy'
end

# chaining
post_as 'markz' do
  text("Mic check...").hashtag("one", "two").link('http://www.simon-neutert.de')
  sexy 'bit'
end

# one liner
post_as 'markz', 'Hi, I am Mark_Z!'
