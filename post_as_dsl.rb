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
