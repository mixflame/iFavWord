class AppDelegate
  attr_accessor :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    #application.setStatusBarStyle(UIStatusBarStyleBlackTranslucent)
    $app = self
    $prefs = NSUserDefaults.standardUserDefaults

    UIApplication.sharedApplication.setStatusBarHidden(true, animated:false)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    switch_to_vc(load_vc("FavWord"))

    true
  end

  def load_vc(identifier)
    if Device.iphone?
      storyboard = UIStoryboard.storyboardWithName("iFavWord-ios", bundle: NSBundle.mainBundle)
    else
      storyboard = UIStoryboard.storyboardWithName("iFavWord-ios-ipad", bundle: NSBundle.mainBundle)
    end
    vc = storyboard.instantiateViewControllerWithIdentifier(identifier)
  end

  def switch_to_vc(vc)
    unless @window.rootViewController == vc
      @window.rootViewController = vc
      @window.rootViewController.wantsFullScreenLayout = true
      @window.makeKeyAndVisible
    end
  end

end
