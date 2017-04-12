
# to not pollute the global namespace, wrap your DSL in a class
module DslWrapper
    class Post
        def initialize(user)
            @user = user
            @post = []
            @extras = {}
        end

        def text(str)
            @post << str
            self
        end

        def hashtag(*strs)
            strs.each do |str|
                @post << '#' + str
            end
            self
        end

        def link(str)
            @post << str
            self
        end

        def post_on_facebook
            fb_text = @post.join(' ')
            begin
                if fb_text.length <= 440
                    puts "#{@user}: #{fb_text}"
                    puts @extras.inspect unless @extras.empty?
                else
                    raise 'Your post is too long.'
                end
            rescue
                puts "I can't tweet this, your tweet is too long, sorry."
            end
        end

        def method_missing(method, *args)
            @extras[method] = args.join(', ')
        end
    end
end
# your exposed DSL method
def post_as(user, text = nil, &block)
    post = DslWrapper::Post.new(user)
    post.text(text) if text
    post.instance_eval(&block) if block_given?
    post.post_on_facebook
end

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

