import UIKit
import Flutter
import CoreLocation // CLLocationManager를 사용하기 위해 CoreLocation을 import

@main
@objc class AppDelegate: FlutterAppDelegate {
  let manager = CLLocationManager() // CLLocationManager 인스턴스 생성

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // CLLocationManager 사용 권한 요청을 메소드 내부로 이동
    if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .denied, .notDetermined, .restricted:
            self.manager.requestAlwaysAuthorization()
        default:
            break
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
