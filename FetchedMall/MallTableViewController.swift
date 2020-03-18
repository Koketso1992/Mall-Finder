//
//  MallTableViewController.swift
//  FetchedMall
//
//  Created by Koketso Motsikwe (ZA) on 2020/03/12.
//  Copyright © 2020 Koketso Motsikwe (ZA). All rights reserved.
//

import UIKit

class MallTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,MallDelegate  {

    var fetchedMall = [mall]()
    @IBOutlet var mallTableView: UITableView!
    var viewModel = MallViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    func dataFetched() {
        DispatchQueue.main.async {
             self.mallTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mallsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mallTableView.dequeueReusableCell(withIdentifier: "MallCell", for: indexPath) as? TableViewCell
        let mall = viewModel.mallsList[indexPath.row]
        cell?.populate(city:mall)
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
