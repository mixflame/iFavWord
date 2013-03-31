class WotdController < UIViewController
  extend IB
  include BubbleWrap

  outlet :wotd, UILabel

  def viewDidAppear(animated)
    wotd.text = $wotd['word']
    super(animated)
  end

  def goBack(sender)
    $app.switch_to_vc($app.load_vc("RandWord"))
  end


end