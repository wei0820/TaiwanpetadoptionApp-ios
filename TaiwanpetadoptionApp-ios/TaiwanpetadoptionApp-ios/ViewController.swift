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

class ViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    var refreshControl:UIRefreshControl!
    
    var pathUrl = "https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL"
    @IBOutlet weak var bannerVIew: UIView!
    var myIndex : IndexPath = IndexPath()
    var arrayData :[PetData] = [PetData]()
    
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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()

        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "更新中...")
               
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)


        
    }
    
    @objc func loadData(){
        
         AF.request(pathUrl).responseDecodable(of: [PetData].self) { [self] (response) in
            
            if(response.value != nil && response.value!.count >= 0){
                arrayData.removeAll()
                response.value?.forEach({ Data in
                    if(Data != nil){
                        arrayData.append(Data)
                

                    }

                })
            }
  

        }.downloadProgress { progress in
            
            if(Float(progress.fractionCompleted) == 1.0){
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()

            }
            
        }


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


    
    func getData(){
        let hud = JGProgressHUD()

        AF.request(pathUrl).responseDecodable(of: [PetData].self) { [self] (response) in
            response.value?.forEach({ Data in
                arrayData.append(Data)
                tableView.reloadData()

            })

        }.downloadProgress { progress in
            hud.setProgress(Float(progress.fractionCompleted), animated: true)
            hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
            hud.textLabel.text = "讀取中"
            hud.detailTextLabel.text = String(format: "%.0f",(progress.fractionCompleted * 100)) + "%"
            hud.show(in: self.view)
            if(Float(progress.fractionCompleted) == 1.0){
                hud.dismiss()

            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = IndexPath(row: indexPath.section, section: indexPath.row)
        performSegue(withIdentifier: "detailcv", sender: nil)


      }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let controller = segue.destination as? DetailViewController
        let indexPath = tableView.indexPathForSelectedRow
    controller?.animalkind = arrayData[indexPath!.row].animal_kind
    controller?.album_file = arrayData[indexPath!.row].album_file
    controller?.animal_sex = arrayData[indexPath!.row].animal_sex
    controller?.animal_bodytype = arrayData[indexPath!.row].animal_bodytype
    controller?.animal_colour = arrayData[indexPath!.row].animal_colour
    controller?.animal_age = arrayData[indexPath!.row].animal_age
    controller?.animal_sterilization = arrayData[indexPath!.row].animal_sterilization
    controller?.animal_bacterin = arrayData[indexPath!.row].animal_bacterin
    controller?.animal_foundplace = arrayData[indexPath!.row].animal_foundplace
    controller?.shelter_name = arrayData[indexPath!.row].shelter_name
    controller?.shelter_address = arrayData[indexPath!.row].shelter_address
    controller?.shelter_tel = arrayData[indexPath!.row].shelter_tel
    

   }

}


