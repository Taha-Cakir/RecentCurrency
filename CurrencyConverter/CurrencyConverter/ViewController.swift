//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Taha Cakir on 16.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var TryLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var ChfLabel: UILabel!
    @IBOutlet weak var CadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func convertButton(_ sender: Any) {
//        request,response,parsing or json serialization 3 adımda.
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=e57c6c4c4ff9ee6f07bfef46436664dc&format=1")
//        session oluşturucan ve shared ile bu fonkdan yardım alıcaz gibi diyorsun..
        let session = URLSession.shared
//        completionHandler a bir input veriyosun url gibi o da sana bir output veriyor,response data ve error olanagı var.Kontrol saglıyor.Callback func gibi.Closure içinde verecek yani data tanımla response tanımla error tanımla istersen de code un içinde kullan olanagı veriyor.
//        Closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
//                message ta localized olan kullanıcıya anlayacagı dilden mesaj vermektir.
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
//                2nd step,response
                if data != nil {
                    do {
//                        DICTIONARY CONVERTER****
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
//                        Async senkronize olmayan bir şekilde yapmalısın kitlenmesin app diye.dispatchqueue
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
//                                print(rates)
                                if let cad =  rates["CAD"] as? Double {
                                    self.CadLabel.text = "CAD :  \(cad)"
                                    
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                    
                                }
                                if let chf = rates["JPY"] as? Double {
                                    self.ChfLabel.text = "CHF : \(chf)"
                                }
                                if let tr = rates["TRY"] as? Double {
                                    self.TryLabel.text = "TRY : \(tr)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                            }
                        }
                    }catch{
                        print("Error")
                    }
                    
                    
                    
                }
            }
        }
//        task i başlatmak zorundasın baslamaz yoksa.INFO plistten access ver app transport security diye.
        task.resume()
    }
    
}

