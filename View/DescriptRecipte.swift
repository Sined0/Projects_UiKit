//
//  DescriptRecipte.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 14.03.2023.
//

import UIKit
import CoreData

var model = [DataFoods]()

class Todo: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: .zero)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.register(Cells.self, forCellReuseIdentifier: "Cells")
        setUpCell()
        view.backgroundColor = .white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        navigationItem.title = "Recipte name save"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetch()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath) as! Cells
        let rslt = model[indexPath.row]
        cell.name.text = rslt.names
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete"){_,_,_ in
            
            self.context.delete(model[indexPath.row])
            try! self.context.save()
            self.fetch()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
        
    }
    
    func fetch() {
        
        let req = NSFetchRequest<DataFoods>(entityName: "DataFoods")
        do {
            model = try context.fetch(req)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
