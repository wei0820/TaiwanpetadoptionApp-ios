//
//  ShareDetailViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by mac on 2021/11/18.
//

import UIKit
import JXBanner

class ShareDetailViewController: BaseViewController {

    var pageCount = 5
    var array = [String]()
    var id : String?
    var name : String?
    var address : String?
    var lat : Double?
    var lon : Double?
    var uuid : String?
    var date : String?
    var like : Int?
    var unlike : Int?
    var usermessage : String?
    var key : String?
    var url_1 :String?
    var url_2 :String?
    var url_3 :String?
    var type : Int?
    var phone : String?
    
    @IBOutlet weak var banner: JXBanner!

    @IBOutlet var shareView: UIView!
    
    @IBOutlet weak var kindLabel: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        array.append(url_1!)
        array.append(url_2!)
        array.append(url_3!)
        banner.resumeAutoScrolling()
        banner.delegate = self
        banner.dataSource = self
        
        
        kindLabel.text = name
        sexLabel.text = ""
        addressLabel.text = address
        phoneLabel.text = phone
        dateLabel.text = date
        messageLabel.text = usermessage

        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    @IBOutlet weak var animal_kind: UILabel!
    
    func loadUrl(url :String,imageView : UIImageView){
        if(url.isEmpty){
            imageView.image = UIImage(named: "iconerror")
            return
        }
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
    
    func share(){
           let renderer = UIGraphicsImageRenderer(size: shareView.bounds.size)
           let image = renderer.image(actions: { (context) in
              shareView.drawHierarchy(in: shareView.bounds, afterScreenUpdates: true)
        })
           let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
           present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        share()
    }
}

//MARK:- JXBannerDataSource
extension ShareDetailViewController: JXBannerDataSource {

    // 注册重用Cell标识
    func jxBanner(_ banner: JXBannerType)
        -> (JXBannerCellRegister) {
            return JXBannerCellRegister(type: JXBannerCell.self,
            reuseIdentifier: "JXDefaultVCCell")
        }

    // 轮播总数
    func jxBanner(numberOfItems banner: JXBannerType)
        -> Int { return 3}

    // 轮播cell内容设置
    func jxBanner(_ banner: JXBannerType,
        cellForItemAt index: Int,
        cell: UICollectionViewCell)
        -> UICollectionViewCell {
            let tempCell: JXBannerCell = cell as! JXBannerCell
            tempCell.layer.cornerRadius = 8
            tempCell.layer.masksToBounds = true
            loadUrl(url: array[index], imageView: tempCell.imageView)
            return tempCell
        }

    // banner基本设置（可选）
    func jxBanner(_ banner: JXBannerType,
        layoutParams: JXBannerLayoutParams)
        -> JXBannerLayoutParams {
            return layoutParams
            .itemSize(CGSize(width: UIScreen.main.bounds.width - 40, height: 200))
                .itemSpacing(0)
        }
}

//MARK:- JXBannerDelegate
extension ShareDetailViewController: JXBannerDelegate {

    // 点击cell回调
    public func jxBanner(_ banner: JXBannerType,
    didSelectItemAt index: Int) {
    print(index)
    }

}
