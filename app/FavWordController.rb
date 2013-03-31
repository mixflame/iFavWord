class FavWordController < UIViewController
  extend IB
  include BubbleWrap

  outlet :word, UITextField

  def submitWord(sender)
    HTTP.get("http://globalchat2.net:9295/favorite_word?word=#{word.text}") do |resp|
      break if resp.body.nil?
      $random_word = JSON.parse(resp.body.to_str)
      $app.switch_to_vc($app.load_vc("RandWord"))
    end
  end

  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
  end

  def bannerViewDidLoadAd(banner)
    NSLog("DidLoadAd")
    banner.setHidden false
  end

  def bannerView(banner, didFailToReceiveAdWithError:error)
    NSLog("DidFailToReceiveAdWithError")
    banner.setHidden true
  end


end