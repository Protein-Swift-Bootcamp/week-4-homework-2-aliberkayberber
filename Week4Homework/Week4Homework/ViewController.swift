//
//  ViewController.swift
//  Week4Homework
//
//  Created by Ali Berkay BERBER on 30.12.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    private var product: [Product] = [
        .init(name: "Ring", stock: 50),
        .init(name: "bracelet", stock: 25),
        .init(name: "clasp", stock: 30),
        .init(name: "earring", stock: 15),
        .init(name: "necklace", stock: 26)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ProductCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductCellTableViewCell")
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "EditVC") as? UIViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
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
        cell.stockLabel.text = String(product[indexPath.row].stock)
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
struct Product {
    
    let name: String
    let stock: Int
    
}
