//
//  ViewController.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 14.03.2023.
//

import UIKit

struct Question {
    
    var foodName: [String]?
    var selectedAnswerIndex: Int?
    var ratin: [String]?
    var ingred: [String]?
}


class MainViewRecipte: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    var filteredData  = Question(foodName: [], selectedAnswerIndex: nil, ratin: [], ingred:[] )
    
    var searchController: UISearchController!
    
    let tableView = UITableView.init(frame: .zero)
    
    var ArrayParsSaveElement = Question(foodName: [], selectedAnswerIndex: nil, ratin: [], ingred:[] ){
        didSet{
            DispatchQueue.main.async {[self] in
                filteredData.foodName! = ArrayParsSaveElement.foodName!
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recipteManage = JsonDec()
        recipteManage.fetchRecipte{ [self](rec) in
            rec.results.forEach{ elem in
                ArrayParsSaveElement.foodName?.append(elem.title)
                ArrayParsSaveElement.ratin?.append("\(elem.rating)")
            }
        }
        
        filteredData.foodName! = ArrayParsSaveElement.foodName!
        
        self.view.addSubview(self.tableView)
        self.tableView.register(RecipCelll.self, forCellReuseIdentifier: "RecipCell")
        setUpCell()
        view.backgroundColor = .white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredData.foodName!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RecipCell", for: indexPath) as! RecipCelll
        cell.nameFood.text = filteredData.foodName![indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let index = ArrayParsSaveElement.foodName?.firstIndex(of: "\(filteredData.foodName![indexPath.row])") {
            ArrayParsSaveElement.selectedAnswerIndex = index
        }
        
        let controller = DetailViewViewController()
        controller.recip = ArrayParsSaveElement
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filteredData.foodName! = searchText.isEmpty ? ArrayParsSaveElement.foodName! : ArrayParsSaveElement.foodName!.filter({$0.contains(searchText)})
            tableView.reloadData()
        }
    }
}



