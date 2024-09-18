class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = ""
  end

  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses

  def guess(letter)

    if letter == nil
        raise ArgumentError, "Invalid"
    end
    letter = letter.downcase
    
    if letter !~ /^[a-zA-z]$/ 
        raise ArgumentError, "Invalid"
        return false
    else
        if @guesses.include?(letter) || @wrong_guesses.include?(letter)
            return false
        else
            if @word.include?(letter)
                @guesses += letter
            else
                @wrong_guesses += letter
            end
        end
    end
    word_with_guesses()
    return true
  end

  def check_win_or_lose
    if @wrong_guesses.length == 7
        return :lose
    elsif @word_with_guesses == @word
        return :win
    else
        return :play
    end
  end


  def word_with_guesses
    @word_with_guesses = @word.chars.map {|char| @guesses.include?(char)? char : "-"}.join
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end


