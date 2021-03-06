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

class ShareViewController: BaseViewController , UITableViewDataSource, UITableViewDelegate{
    
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
        
        cell.createTimeLabel.text = "時間:" + dateItem[indexPath.row].date
        cell.kindUILabel.text = "名稱:" + dateItem[indexPath.row].name
        
        switch dateItem[indexPath.row].type {
        case 0:
            cell.typeLabel.text = "性別:男孩"

            break
        case 1:
            cell.typeLabel.text = "性別:女孩"

            break
        case 3:
            cell.typeLabel.text = "性別:不確定"

            break
        default:
            cell.typeLabel.text = "性別:不確定"

            break
            
        }
        if(!dateItem[indexPath.row].url_1.isEmpty){
            
            print("jack",dateItem[indexPath.row].url_1)
            loadUrl(url: dateItem[indexPath.row].url_1, imageView: cell.dataImage)

        }else{
            cell.dataImage.image = UIImage(named: "iconerror")
        }

      
             return cell
         }
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
            if(!self.checkLogin()){
                self.setLoginAlert()
                
            }else{
                self.setJump(type: "adddate")

            }

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
     
    
    override func setJump(type:String){
         
         if let controller = storyboard?.instantiateViewController(withIdentifier: type) {
                    present(controller, animated: true, completion: nil)
                }
         
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          tableView.deselectRow(
//              at: indexPath, animated: true)
        myIndex = IndexPath(row: indexPath.section, section: indexPath.row)
        performSegue(withIdentifier: "sharedetailcv", sender: nil)


      }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let controller = segue.destination as? ShareDetailViewController
        let indexPath = tableView.indexPathForSelectedRow
       controller?.id = dateItem[indexPath!.row].id
       controller?.name = dateItem[indexPath!.row].name
       controller?.address = dateItem[indexPath!.row].address
       controller?.lat = dateItem[indexPath!.row].lat
       controller?.lon = dateItem[indexPath!.row].lat
       controller?.uuid = dateItem[indexPath!.row].uuid
       controller?.date = dateItem[indexPath!.row].date
       controller?.like = dateItem[indexPath!.row].like
       controller?.unlike = dateItem[indexPath!.row].unlike
       controller?.usermessage = dateItem[indexPath!.row].usermessage
       controller?.key  = dateItem[indexPath!.row].key
       controller?.url_1 = dateItem[indexPath!.row].url_1
       controller?.url_2 = dateItem[indexPath!.row].url_2
       controller?.url_3 = dateItem[indexPath!.row].url_3
       controller?.type = dateItem[indexPath!.row].type
       controller?.phone = dateItem[indexPath!.row].phone

   }
    
    func checkLogin() -> Bool{
        var isLogin = false
        if Auth.auth().currentUser != nil {
            
            isLogin = true
       
        } else {
            isLogin = false

        }
        return isLogin
    }
    
    
    func setLoginAlert(){
        
        let controller = UIAlertController(title: "提醒", message:"您尚未登入,請先登入後再發文", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        controller.addAction(okAction)
                
        present(controller, animated: true, completion: nil)
    }
}
