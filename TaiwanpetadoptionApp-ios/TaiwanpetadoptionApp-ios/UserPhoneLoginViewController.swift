//
//  UserPhoneLoginViewController.swift
//  ZEGOLiveDemo
//
//  Created by JackPan on 2022/5/17.
//

import UIKit
import Firebase

class UserPhoneLoginViewController: UIViewController {

    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var getVerificationCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userPhoneNumber.keyboardType = .phonePad
        setupGradientBackground()
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func getVerificationCodeAction(_ sender: Any) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber( userPhoneNumber.text!, uiDelegate: nil) { (verificationID, error) in
                    if let error = error {
                        print("error")

                        print("Jack",error.localizedDescription)

                        return
                    }
                    // Sign in using the verificationID and the code sent to the user
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
      

                    // ...
                }
                Auth.auth().languageCode = "tw";

        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setupGradientBackground() {
//        getVerificationCode.isEnabled = false
//        getVerificationCode.alpha = 0.5

        let gradientLayer = CAGradientLayer()
       gradientLayer.frame.size = getVerificationCode.frame.size
        gradientLayer.colors = [
           UIColor(red: 0.56, green: 0, blue: 1, alpha: 1).cgColor,

             UIColor(red: 0.296, green: 0.505, blue: 0.912, alpha: 1).cgColor,

             UIColor(red: 0.038, green: 1, blue: 0.827, alpha: 1).cgColor
           
        ]
       

       gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)

       gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
       
        getVerificationCode.layer.addSublayer(gradientLayer)
        getVerificationCode.setTitle("取得驗證碼", for: .normal)

        

    }
        
}
