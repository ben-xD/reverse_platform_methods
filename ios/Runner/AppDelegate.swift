import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var service: ApplicationService? = nil;
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let methodChannel = FlutterMethodChannel(name: "com.example.app_name.method_channel.strings", binaryMessenger: controller.binaryMessenger)

      methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if (call.method == "isReady") {
              // Instantiate the service running on Platform side.
              self.service = ApplicationService(methodChannel: methodChannel)
          }
      })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class ApplicationService {
    let methodChannel: FlutterMethodChannel;
    
    init(methodChannel: FlutterMethodChannel) {
        self.methodChannel = methodChannel
        // This method channel doesn't have to be called in the initializer, you can call it whenever you like.
        methodChannel.invokeMethod("new_string", arguments: "LOVELY STRING FROM IOS SIDE", result: nil)
    }
}
