class Tweet < ApplicationRecord

  # associations
  belongs_to :user
  has_many :tweet_tags
  has_many :tags, through: :tweet_tags

  # validations
  validates :message, presence: true
  validates :message, length: {maximum: 140,
  too_long: "too long. Max tweet 140 characters!"}, on: :create
  # see form partial to customize further
  # hooks
  after_validation :apply_link, on: :create
  before_validation :link_check, on: :create
  # link_checks first, then does the other validations above. The before_validation is also called a "hook"

private
# makes it so that you can't call link_check outside the method - prevents other developers from using your code incorrectly



  def link_check
    check = false
    if self.message.include? "http://"
      check = true
    elsif self.message.include? "https://"
      check = true
    else
      check = false
    end

    if check == true
      arr = self.message.split

      index = arr.map{ |x| x.include? "http"}.index(true)
      # map is a function that takes a block and returns an array with the result of each element mapped to the return value of that block - this line is breaking the message into an array of words and checking to see if any item/word in the array starts with http
      self.link = arr[index]
      # saving that http to the variable self
      if arr[index].length > 23
        arr[index] = "#{arr[index][0..20]}..."
      end
      # if longer than 23 characters, it gets shortened to the first 21 characters with ...

      self.message = arr.join(" ")
    end

    def apply_link
      arr = self.message.split
      index = arr.map { |x| x.include? "http://" }.index(true)
      if index
        url = arr[index]
        # finds the index of the http link and saves it as url
        arr[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
        # target='_blank' opens a new tab for the link
	    end
      self.message = arr.join(" ")
    end

   end

end
