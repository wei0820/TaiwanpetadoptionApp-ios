//
//  HpmeViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by JackPan on 2022/4/29.
//

import UIKit
import FirebaseAuth

class HpmeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func memberButton(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            print("\(user.uid) login")
            showAlert(title: "登入狀態", message: "你己經登入")

        } else {
            print("not login")
            setJump(type: "login")

            
        }
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
