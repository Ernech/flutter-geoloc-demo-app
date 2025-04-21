import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyC6xfT2f6Ko8wWyCKkmT6usMUsCqVe_uIs")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
