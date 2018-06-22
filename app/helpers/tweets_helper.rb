module TweetsHelper
  def get_tagged(tweet)
    # to get tagged, you have to feed it a tweet
    message_arr = tweet.message.split
    # this splits each word of the tweet into an array that you can loop through

    message_arr.each_with_index do |word, index|
      # when using each_with_index, you have to pass it 2 block arguments/parameters, the second of which always refers to the index, no matter what you call it inside the pipes.
      if word[0] == "#"
        tag = Tag.find_or_create_by(phrase: word.downcase)
        # goes across the Tag table to find if the tag already exists and if it doesn't, it creates it.  The find_or_create_by is an ActiveRecord Class method.
        TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        message_arr[index] = "<a href= '/tag_tweets?id=#{tag.id}'>#{word}</a>"
      end

    end

    tweet.update(message: message_arr.join(" "))
    # since we took the tweet and turned it into an array to locate the #tags, we have to rejoin the words in the array back into a single string


  end
end
