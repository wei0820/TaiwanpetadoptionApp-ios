//
//  ViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by  JackPan on 2021/8/7.
//

import UIKit
import Alamofire
import AppTrackingTransparency
import AdSupport
import GoogleMobileAds
import JGProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GADBannerViewDelegate{
//    func onVpadnAdLoaded(_ banner: VpadnBanner) {
//
//        self.bannerVIew.addSubview(banner.getVpadnAdView())
//    }
    
    @IBOutlet weak var bannerVIew: UIView!
//    var vpadnBanner: VpadnBanner!
    var myIndex : IndexPath = IndexPath()
    var arrayData :[Data] = [Data]()
    
    struct CellIdentifier {
        static let identifier = "dataCell"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.identifier, for: indexPath) as? DataTableViewCell else {
            
            
            return UITableViewCell()
        }
        
        var sex = ""
        if(arrayData[indexPath.row].animal_sex == "F"){
            sex = "女孩"
        }else{
            
            sex = "男孩"

            
            }
        if(!arrayData[indexPath.row].album_file.isEmpty){
            
            loadUrl(url: arrayData[indexPath.row].album_file, imageView: cell.dataImage)
            
        }else{
            cell.dataImage.image = UIImage(named: "iconerror")
        }
        cell.createTimeLabel.text = "更新時間:" + arrayData[indexPath.row].animal_update
        cell.kindUILabel.text = "品種:" + arrayData[indexPath.row].animal_kind

        cell.typeLabel.text = "特徵:" + arrayData[indexPath.row].animal_colour + "的" + sex


    
           return cell
       }
    
    var adBannerView: GADBannerView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                 overrideUserInterfaceStyle = .light
             } else {
                 // Fallback on earlier versions
             }
        tableView.dataSource = self
        tableView.delegate = self
//        ATTrackingManager.requestTrackingAuthorization(completionHandler: { [self] status in
//          // Tracking authorization completed. Start loading ads here.
//            setAdBanner()
//        })
        setAdBanner()
            
        getData()
        
    }
    func loadUrl(url :String,imageView : UIImageView){
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
           if let data = data, let image = UIImage(data: data) {
              DispatchQueue.main.async {
                imageView.image  = image
              }
           }
        }
        task.resume()
    }

    func setAdBanner(){
            let id = "ca-app-pub-3940256099942544/2934735716"
            adBannerView = GADBannerView(adSize: kGADAdSizeBanner)
            adBannerView!.adUnitID = id
            adBannerView!.delegate = self
            adBannerView!.rootViewController = self
            adBannerView!.load(GADRequest())
    }
//
    
    func getData(){
        let hud = JGProgressHUD()

        AF.request("https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL").responseDecodable(of: [Data].self) { [self] (response) in
            response.value?.forEach({ Data in
//                print("test",Data)
//                print("test",Data.animal_age)
                arrayData.append(Data)
                tableView.reloadData()

            })

        }.downloadProgress { progress in
            hud.setProgress(Float(progress.fractionCompleted), animated: true)
            hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
            hud.textLabel.text = "下載中"
            hud.detailTextLabel.text = String(format: "%.0f",(progress.fractionCompleted * 100)) + "%"
            hud.show(in: self.view)
            if(Float(progress.fractionCompleted) == 1.0){
                hud.dismiss()

            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(
              at: indexPath, animated: true)
        myIndex = IndexPath(row: indexPath.section, section: indexPath.row)
        self.performSegue(withIdentifier: "detail", sender: nil)


      }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "detail"{
           if let index = tableView.indexPathForSelectedRow{
               let secondCV = segue.destination as! DetailViewController
            secondCV.kind = arrayData[index.row].animal_kind
               
           }
           
           
       }
       
   }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
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
}


