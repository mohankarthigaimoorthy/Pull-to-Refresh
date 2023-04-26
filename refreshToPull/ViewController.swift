//
//  ViewController.swift
//  refreshToPull
//
//  Created by Mohan K on 21/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var refreshTableView: UITableView!
    
    var refControl = UIRefreshControl()
    
    var itemsArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(named: "primaryColor")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    
    refControl.tintColor = UIColor.white
    refControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
    
    refreshTableView.addSubview(refControl)
    loadData()

    }

func loadData() {
    for i in 0 ... 40 {
        itemsArray.append("Item \(40 - i)")
    }
    self.refreshTableView.reloadData()
}



@objc func handleRefresh(refreshControl: UIRefreshControl) {
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
        
        let start = self.itemsArray.count
        let end = self.itemsArray.count + 20
        for i in start ..< end {
            self.itemsArray.insert("Item \(i)", at: 0)
        }
        DispatchQueue.main.async {
            self.refreshTableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "refreshTableViewCell", for: indexPath) as! refreshTableViewCell
        cell.itemLabel.text = itemsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
