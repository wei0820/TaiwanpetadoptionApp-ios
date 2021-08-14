//
//  ViewController.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by  JackPan on 2021/8/7.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }


    func getData(){
        AF.request("https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL").responseDecodable(of: [Data].self) { (response) in
            guard let Data = response.value else { return }
            Data.forEach { Data in
            }
          }
    }
}

