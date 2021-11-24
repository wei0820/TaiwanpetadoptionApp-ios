//
//  BaseViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by mac on 2021/11/22.
//

import UIKit
import GoogleMobileAds



class BaseViewController: UIViewController , GADBannerViewDelegate{

    var bannerView: GADBannerView!


    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            
        overrideUserInterfaceStyle = .light
        } else {
            
             }
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)

        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-7019441527375550/3052866419"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        
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
}
