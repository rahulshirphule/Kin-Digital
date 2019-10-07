//
//  ViewController.swift
//  newsr
//
//  Created by Bryn Divey on 2019/09/23.
//  Copyright © 2019 Bryn Divey. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var things = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var d = UIApplication.shared.delegate as! AppDelegate
        var t = NSEntityDescription.entity(forEntityName: "Topics", in: d.persistentContainer.viewContext)
        var o = NSManagedObject(entity: t!, insertInto: d.persistentContainer.viewContext)
        do {
            try d.persistentContainer.viewContext.save()
        } catch {
            print("OOOPS")
        }

      
        
        let decoder = JSONDecoder()
        if let url = URL(string: "https://newsapi.org/v2/everything?q=swift&apiKey=9ff1fdcc97804ae0861c05b1f7696fee") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    return
                }
                do {
                    struct Articles : Codable{let articles:[Article]}

                    let parsed = try decoder.decode(Articles.self, from: data)
                    self.things = parsed.articles
                    for p in parsed.articles {
                        print(p.title)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } catch {
                    print("OOPS")
                }
            }.resume()
        };
        //brokeparsedData = decoder.decode(Article.self, from: YourJsonData)
        //print(self.parsed)

    }


}

extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.things.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.item)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")

        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        cell.textLabel?.text = self.things[indexPath.item].title! + "dsadsad"
        
        return cell
    }
}

