//
//  UserPhoneLoginViewController.swift
//  ZEGOLiveDemo
//
//  Created by JackPan on 2022/5/17.
//

import UIKit
import Firebase

class UserPhoneLoginViewController: UIViewController {
    @IBOutlet weak var verificationCodeText: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var getVerificationCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userPhoneNumber.keyboardType = .phonePad
        setupGradientBackground(button: getVerificationCode,title: "驗證")
        setupGradientBackground(button: sendButton,title: "送出")
        sendButton.isEnabled = false
        sendButton.alpha = 0.5

        

        // Do any additional setup after loading the view.
    }
    @IBAction func sendAction(_ sender: Any) {
    }
    @IBAction func getVerificationCodeAction(_ sender: Any) {
        
        if(userPhoneNumber.text != nil && !userPhoneNumber.text!.isEmpty){
                 if(userPhoneNumber.text!.count >= 11){
                     return
                 }
                 
        var phonenumber : String = String(userPhoneNumber.text!.suffix(9))
            print("Jack",phonenumber)

        
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phonenumber, uiDelegate: nil) { (verificationID, error) in
                    if let error = error {

                        print("Jack",error.localizedDescription)

                        return
                    }
            print("Jack",verificationID)

            self.sendButton.isEnabled = true
            self.sendButton.alpha = 1

                    // ...
                }
                Auth.auth().languageCode = "tw";

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
    func setupGradientBackground(button : UIButton,title :String) {


        let gradientLayer = CAGradientLayer()
       gradientLayer.frame.size = button.frame.size
        gradientLayer.colors = [
           UIColor(red: 0.56, green: 0, blue: 1, alpha: 1).cgColor,

             UIColor(red: 0.296, green: 0.505, blue: 0.912, alpha: 1).cgColor,

             UIColor(red: 0.038, green: 1, blue: 0.827, alpha: 1).cgColor
           
        ]
       

       gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)

       gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
       
        button.layer.addSublayer(gradientLayer)
        button.setTitle(title, for: .normal)

        

    }
        
}
