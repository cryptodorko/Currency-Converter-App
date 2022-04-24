//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by Dorukhan Demir on 24.04.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        // When clicked the botton;
        // 1 ) Request & Session
        // 2 ) Response & Data
        // 3 ) Parsing & JSON Serialization
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=7be3f5c4e981ee1a92c9c2e9c083395c&format=1")
        let session = URLSession.shared
        //Closure -
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if data != nil {
                    
                    do{
                   let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> // Because different types of data
                        
                        //ASYNC
                        
                        DispatchQueue.main.async {
                            //print(jsonResponse)
                            //rates is a dictionary we want to reach that
                            //print(jsonResponse["rates"])
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                //print([rates])
                                
                                if let cad = rates["CAD"] as? Double{
                                    //print(cad)
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                
                                if let turkish = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY : \(turkish)"
                                }
                            }
                        }
                    
                    }catch{
                        print("error")
                    }
                }
            }
        }
        
        task.resume()
    }
}

