//
//  DetailViewViewController.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 15.03.2023.
//

import UIKit
import CoreData

struct QuestionDetail {
    
    var foodName: [String]?
    var selectedAnswerIndex: Int?
    var featured_image: [String]?
    var ingred: [String]?
    
}

class DetailViewViewController: UIViewController {
    
    var ArrayParsSaveElementSecond = QuestionDetail(foodName: [], selectedAnswerIndex: nil, featured_image: [], ingred:[]){
        didSet{
            DispatchQueue.main.async {[self] in
                reloadInputViews()
            }
        }
    }
    
    let recipteManageDetail = JsonDec()
    
    var recip: Question?{
        didSet {
            DispatchQueue.main.async {[self] in
                parsss()
            }
            
            DispatchQueue.main.async {[self] in
                sleep(UInt32(2.5))
                
                let names = ArrayParsSaveElementSecond.foodName![(recip?.selectedAnswerIndex)!]
                nameFoods.text = "\(names)"
                
                let resultImg = ArrayParsSaveElementSecond.featured_image![(recip?.selectedAnswerIndex)!]
                imageFoods.load(urlStr: resultImg)
                
                let reusltIng = ArrayParsSaveElementSecond.ingred![(recip?.selectedAnswerIndex)!]
                ingr.text = "\(reusltIng)"
                
                reloadInputViews()
            }
        }
    }
    
    var nameFoods = UILabel()
    let ingr = UILabel()
    var imageFoods = UIImageView()
    var buttIngr = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let marg = view.layoutMarginsGuide
        
        ingr.numberOfLines = 0
        ingr.setContentCompressionResistancePriority(.required, for: .vertical)
        
        view.addSubview(nameFoods)
        
        nameFoods.translatesAutoresizingMaskIntoConstraints = false
        nameFoods.topAnchor.constraint(equalTo: marg.topAnchor, constant: 8).isActive = true
        nameFoods.leadingAnchor.constraint(equalTo: marg.leadingAnchor, constant: 8).isActive = true
        
        view.addSubview(imageFoods)
        
        imageFoods.layer.cornerRadius = 20
        imageFoods.layer.masksToBounds = true
        imageFoods.translatesAutoresizingMaskIntoConstraints = false
        imageFoods.topAnchor.constraint(equalTo: nameFoods.topAnchor, constant: 24).isActive = true
        imageFoods.leadingAnchor.constraint(equalTo: marg.leadingAnchor, constant: 16).isActive = true
        imageFoods.trailingAnchor.constraint(equalTo: marg.trailingAnchor, constant: -16).isActive = true
        imageFoods.bottomAnchor.constraint(equalTo: marg.bottomAnchor, constant: -460).isActive = true
        
        view.addSubview(buttIngr)
        
        buttIngr.setTitle("Save favourites", for: .normal)
        buttIngr.translatesAutoresizingMaskIntoConstraints = false
        buttIngr.bottomAnchor.constraint(equalTo: marg.bottomAnchor, constant: -16).isActive = true
        buttIngr.leadingAnchor.constraint(equalTo: marg.leadingAnchor, constant: 16).isActive = true
        buttIngr.trailingAnchor.constraint(equalTo: marg.trailingAnchor, constant: -16).isActive = true
        buttIngr.addTarget(self, action: #selector(loadRecipte), for: .touchUpInside)
        
        view.addSubview(ingr)
        
        ingr.translatesAutoresizingMaskIntoConstraints = false
        ingr.topAnchor.constraint(equalTo: marg.topAnchor, constant: 300).isActive = true
        ingr.leadingAnchor.constraint(equalTo: marg.leadingAnchor, constant: 8).isActive = true
        ingr.trailingAnchor.constraint(equalTo: marg.trailingAnchor, constant: -8).isActive = true
        
        reloadInputViews()
        print(nameFoods)
        view.backgroundColor = .systemCyan
    }
    //сохранение данныъ в CoreData
    @objc private func  loadRecipte(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DataFoods", in: context)
        let newNote = DataFoods(entity: entity!, insertInto: context)
        newNote.names = nameFoods.text
        do
        {
            model.append(newNote)
            try context.save()
        }
        catch
        {
            print("context save error")
        }
    }
    
    func parsss() {
        recipteManageDetail.fetchRecipte{ [self](rec) in
            rec.results.forEach{ elem in
                ArrayParsSaveElementSecond.foodName?.append(elem.title)
                ArrayParsSaveElementSecond.featured_image?.append("\(elem.featured_image)")
                ArrayParsSaveElementSecond.ingred?.append(elem.ingredients.joined(separator: ", "))
            }
        }
    }
    
}

