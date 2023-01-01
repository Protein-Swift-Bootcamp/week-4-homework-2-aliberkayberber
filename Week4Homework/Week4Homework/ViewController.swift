//
//  ViewController.swift
//  Week4Homework
//
//  Created by Ali Berkay BERBER on 30.12.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    private var product: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ProductCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductCellTableViewCell")
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        if let url = URL(string: "http://localhost:3000/product") {
            var request: URLRequest = .init(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    return
                }
                if let data = data {
                    
                    do {
                       let product = try! JSONDecoder().decode([Product].self, from: data)
                        self.product = product
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch  {
                        print("error")
                    }
                        
                        
                    
                }
            }
            task.resume()
        }
        
        /*
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "EditVC") as? UIViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }
        */
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = product[indexPath.row]
        print("\(indexPath.row) - \(product.name ?? "")")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellTableViewCell", for: indexPath) as! ProductCellTableViewCell
        cell.itemNameLabel.text = product[indexPath.row].name
        cell.stockLabel.text = product[indexPath.row].stock
        return cell
    }
}
/*
enum jewelry {
case necklace
case earring
case bracelet
case ring
case clasp
}
*/

