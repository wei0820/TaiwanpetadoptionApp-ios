//
//  ShareDetailViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by mac on 2021/11/18.
//

import UIKit
import JXBanner

class ShareDetailViewController: UIViewController {

    var animalkind  : String?
    var animal_sex  : String?
    var animal_bodytype  : String?
    var animal_colour  : String?
    var animal_age  : String?
    var animal_sterilization  : String?
    var animal_bacterin  : String?
    var animal_foundplace  : String?
    var shelter_name  : String?
    var album_file  : String?
    var shelter_address  : String?
    var shelter_tel  : String?
    var pageCount = 5
    var array = [String]()

    @IBOutlet weak var banner: JXBanner!
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var bodyTypeLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sterilizationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var foundplaceLabel: UILabel!
    @IBOutlet weak var bacterinLabel: UILabel!
    
    @IBOutlet var shareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.0, *) {
                 overrideUserInterfaceStyle = .light
             } else {
                 // Fallback on earlier versions
             }
        
        array.append("https://firebasestorage.googleapis.com:443/v0/b/taiwanpetadoptionappios.appspot.com/o/VuivmZ4lBYct9rchw2w800UqBIQ2%2FBE9D2521-0950-4100-BAA5-E428D7577C91.png?alt=media&token=dedb0536-c3f6-404c-9ba2-044c49a1e58c")
        array.append("data:image/jpeg;base64,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")
        array.append("data:image/jpeg;base64,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")
//        animal_kind.text = "種類:" + animalkind!
//        sexLabel.text = "性別:"  + animal_sex!
//        bodyTypeLabel.text = "體型:" + animal_bodytype!
//        colourLabel.text = "毛色:" + animal_colour!
//        ageLabel.text = "年紀:" + animal_age!
//        sterilizationLabel.text = "是否絕育:" + animal_sterilization!
//        bacterinLabel.text = "是否施打狂犬病疫苗:" + animal_bacterin!
//        nameLabel.text = "收容所名稱:" + shelter_name!
//        foundplaceLabel.text = "尋獲地:" + animal_foundplace!
        addressLabel.text =  "地址:" + shelter_address!
        telLabel.text = "聯絡電話:" + shelter_tel!
        
    
        
        
        banner.resumeAutoScrolling()
        banner.delegate = self
        banner.dataSource = self

        self.automaticallyAdjustsScrollViewInsets = false



        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var animal_kind: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
            .itemSpacing(20)
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
