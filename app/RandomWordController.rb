class RandomWordController < UIViewController
  extend IB
  include BubbleWrap

  outlet :random_word, UILabel
  outlet :rating, UILabel


  def voteUp(sender)
    HTTP.get("http://globalchat2.net:9295/vote_up?word=#{random_word.text}") do |resp|
      break if resp.body.nil?
      $random_word = JSON.parse(resp.body.to_str)
      random_word.text = $random_word['word']
      $random_word['up_votes'] ||= 0
      rating.text = $random_word['up_votes'].to_s
    end
  end

  def voteDown(sender)
    HTTP.get("http://globalchat2.net:9295/vote_down?word=#{random_word.text}") do |resp|
      break if resp.body.nil?
      $random_word = JSON.parse(resp.body.to_str)
      random_word.text = $random_word['word']
      $random_word['up_votes'] ||= 0
      rating.text = $random_word['up_votes'].to_s
    end
  end

  def wordOfTheDay(sender)
    HTTP.get("http://globalchat2.net:9295/word_of_the_day") do |resp|
      break if resp.body.nil?
      $wotd = JSON.parse(resp.body.to_str)
      $app.switch_to_vc($app.load_vc("WordOfTheDay"))
    end
  end

  def viewDidAppear(animated)
    random_word.text = $random_word['word']
    $random_word['up_votes'] ||= 0
    rating.text = $random_word['up_votes'].to_s
    super(animated)
  end


  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
  end


end