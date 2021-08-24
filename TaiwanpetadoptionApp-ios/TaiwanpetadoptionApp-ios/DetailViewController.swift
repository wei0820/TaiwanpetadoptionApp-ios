//
//  DetailViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by mac on 2021/8/20.
//

import UIKit

class DetailViewController: UIViewController {
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
    @IBOutlet weak var imageView: UIImageView!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrl(url: album_file!, imageView: imageView)
        animal_kind.text = "種類:" + animalkind!
        sexLabel.text = "性別:"  + animal_sex!
        bodyTypeLabel.text = "體型:" + animal_bodytype!
        colourLabel.text = "毛色:" + animal_colour!
        ageLabel.text = "年紀:" + animal_age!
        sterilizationLabel.text = "是否絕育:" + animal_sterilization!
        bacterinLabel.text = "是否施打狂犬病疫苗:" + animal_bacterin!
        nameLabel.text = "收容所名稱:" + shelter_name! 
        foundplaceLabel.text = "尋獲地:" + animal_foundplace!
        addressLabel.text =  "地址:" + shelter_address!
        telLabel.text = "聯絡電話:" + shelter_tel!
        
        

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
}
