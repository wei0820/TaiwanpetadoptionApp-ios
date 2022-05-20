//
//  BaseViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by mac on 2021/11/22.
//
import Network
import UIKit
import GoogleMobileAds
import RxSwift
import UserNotifications
import AppTrackingTransparency
class BaseViewController: UIViewController , GADBannerViewDelegate{

    var bannerView: GADBannerView!

    let monitor = NWPathMonitor()

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            
        overrideUserInterfaceStyle = .light
        } else {
            
             }
        ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .notDetermined:
                        self.setAD()

                        break
                    case .restricted:
                        break
                    case .denied:
                        break
                    case .authorized:
                        self.setAD()
                        break
                    @unknown default:
                        self.setAD()

                        break
                    }
        }


    }
    func setAD(){
        
            bannerView = GADBannerView(adSize: GADAdSizeBanner)

            addBannerViewToView(bannerView)
            
            bannerView.adUnitID = "ca-app-pub-7019441527375550/3052866419"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
    }
    func setJump(type:String){
          
          if let controller = storyboard?.instantiateViewController(withIdentifier: type) {
              present(controller, animated: true, completion: nil)
          }
          
      }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("jack","bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("jack","bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("jack","bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("jack","bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("jack","bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("jack","bannerViewDidDismissScreen")
    }
    
    func checkNet(){
        monitor.pathUpdateHandler = { [self] path in
           if path.status == .satisfied {
              print("connected")
           } else {
              print("no connection")
               self.showAlert(title: "無網路狀態", message: "請開啟網路才能使用喔")


           }
        }
        monitor.start(queue: DispatchQueue.global())
    }
    func showAlert(title:String,message:String){
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}
