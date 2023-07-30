import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
   if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
       let nsDictionary = NSDictionary(contentsOfFile: path)

       if let apiKey = nsDictionary?["API_KEY"] as? String {
           print("AppDelegate: API_KEY found")
           GMSServices.provideAPIKey(apiKey)
       }
       }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
