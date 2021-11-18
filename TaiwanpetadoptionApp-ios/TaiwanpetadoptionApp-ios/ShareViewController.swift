//
//  ShareViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by mac on 2021/11/16.
//

import UIKit
import Alamofire
import AppTrackingTransparency
import AdSupport
import GoogleMobileAds
import JGProgressHUD
import JJFloatingActionButton
import Firebase

class ShareViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    var dateItem: [DateItem] = [DateItem]()

    var myIndex : IndexPath = IndexPath()
    @IBOutlet weak var tableView: UITableView!
    struct CellIdentifier {
        static let identifier = "dataCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateItem.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.identifier, for: indexPath) as? DataTableViewCell else {
              
              
              return UITableViewCell()
          }
        
        cell.createTimeLabel.text = "發布時間:" + dateItem[indexPath.row].date
        cell.kindUILabel.text = "品種:" + dateItem[indexPath.row].kind
        cell.typeLabel.text = "特徵:" + dateItem[indexPath.row].name
        loadUrl(url: dateItem[indexPath.row].url_1, imageView: cell.dataImage)


      
             return cell
         }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            
                       // Fallback on earlier versions
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        
        setActionButton()
        getData()
        
    
    }
    
    
    func  getData(){

        let reference: DatabaseReference! = Database.database().reference().child("SharePet").child("SharePet")

            reference.queryOrderedByKey().observe(.value, with: { snapshot in
                         if snapshot.childrenCount > 0 {
                            self.dateItem.removeAll()

                             for item in snapshot.children {
            
                                 let data = DateItem(snapshot: item as! DataSnapshot)
                                print("jack",data.name)
                                
                                self.dateItem.append(data)
                                 
                             }
                            self.dateItem.reverse()
                            self.tableView.reloadData()

                         }
                         
                     })
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
    func  setActionButton() -> Void{
         
         let actionButton = JJFloatingActionButton()
         
         actionButton.addItem(title: "新增", image: UIImage(named: "create")?.withRenderingMode(.alwaysTemplate)) { item in
            
            self.setJump(type: "adddate")
         }
         
         
         actionButton.addItem(title: "會員資訊", image: UIImage(named: "money_black")?.withRenderingMode(.alwaysTemplate)) { item in
     
             
        }
         
         actionButton.addItem(title: "發文規範", image: UIImage(named: "report_black")?.withRenderingMode(.alwaysTemplate)) { item in
         let controller = UIAlertController(title: "發文規範", message:"本討論區只提供分享,請勿發表帶風向,人身攻擊,招收會員,招收群組等 違規的文章 如發現違規文章 將刪除該文章", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "好的", style: .default,handler: nil)
                     controller.addAction(okAction)
           self.present(controller, animated: true, completion: nil)
             // do something
         }
         
         view.addSubview(actionButton)
         actionButton.itemAnimationConfiguration = .circularSlideIn(withRadius: 125)
         actionButton.buttonAnimationConfiguration = .rotation(toAngle: .pi * 3 / 3)
         actionButton.buttonAnimationConfiguration.opening.duration = 0.8
         actionButton.buttonAnimationConfiguration.closing.duration = 0.6
         
         actionButton.translatesAutoresizingMaskIntoConstraints = false
         actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26).isActive = true
         actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56).isActive = true
     }
     
    
    func setJump(type:String){
         
         if let controller = storyboard?.instantiateViewController(withIdentifier: type) {
                    present(controller, animated: true, completion: nil)
                }
         
     }
        
}
