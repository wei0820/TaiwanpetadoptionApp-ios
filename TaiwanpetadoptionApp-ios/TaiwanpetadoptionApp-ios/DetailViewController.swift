//
//  DetailViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by mac on 2021/8/20.
//

import UIKit

class DetailViewController: UIViewController {
    var kind  : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animal_kind.text = kind
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

}
