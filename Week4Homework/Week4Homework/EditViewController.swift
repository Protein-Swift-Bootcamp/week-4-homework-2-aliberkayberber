//
//  EditViewController.swift
//  Week4Homework
//
//  Created by Ali Berkay BERBER on 30.12.2022.
//

import UIKit

class EditViewController: UIViewController {

    private var product: [Product] = []
    var name = "" , stock = "" , category = ""
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var stockTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }


    @IBAction func saveClicked(_ sender: Any) {
        
        
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? UIViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
            name = nameTextField.text ?? ""
            print(name)
            stock = stockTextField.text ?? ""
            print(stock)
            category = categoryTextField.text ?? ""
            print(category)
            DispatchQueue.main.async {
                self.postData()
            }
            
        }
    }
    
    func postData() {
        if let url = URL(string: "http://localhost:3000/product") {
            var request: URLRequest = .init(url: url)
            request.httpMethod = "post"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Codable] = [
                "id": Int.random(in: 1..<10000),
                "category": self.categoryTextField.text ?? "",
                "stock": self.stockTextField.text ?? "" ,
                "name": self.nameTextField.text ?? ""
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    
                    self.name = self.nameTextField.text ?? ""
                    self.stock = self.stockTextField.text ?? ""
                    self.category = self.categoryTextField.text ?? ""
                    let response = try JSONDecoder().decode(Product.self, from: data)
                    print("succes\(response)")
                }
                catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}




