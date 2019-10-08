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
    var article: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = article;
        
        // Do any additional setup after loading the view.
        var d = UIApplication.shared.delegate as! AppDelegate
        var t = NSEntityDescription.entity(forEntityName: "Topics", in: d.persistentContainer.viewContext)
        var o = NSManagedObject(entity: t!, insertInto: d.persistentContainer.viewContext)
        do {
            try d.persistentContainer.viewContext.save()
        } catch {
            print("OOOPS")
        }
        
        self.tableView.register(UINib.init(nibName: "NewsTitleCell", bundle: nil), forCellReuseIdentifier: "newsTitleCell")
        self.tableView.separatorStyle = .none
        
        let baseRequest = BaseHttpRequest();
        
        self.showIndicator(withTitle: "Loading...", and: "getting list of articles")
        let url = "https://newsapi.org/v2/everything?q="+self.article+"&apiKey=9ff1fdcc97804ae0861c05b1f7696fee"
        baseRequest.getDataFromServer(baseUrl: url){ (data)
            in
            DispatchQueue.main.async {
                self.hideIndicator()
            }
            let responseData = data as [Article]?;
            if responseData != nil {
                DispatchQueue.main.async {
                    self.things = responseData!;
                    self.tableView.reloadData()
                }
            } else {
                print("something is wrong")
            }
        };
        
//        let decoder = JSONDecoder()
//        if let url = URL(string: "https://newsapi.org/v2/everything?q=swift&apiKey=9ff1fdcc97804ae0861c05b1f7696fee") {
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data else {
//                    return
//                }
//                do {
//                    struct Articles : Codable{let articles:[Article]}
//
//                    let parsed = try decoder.decode(Articles.self, from: data)
//                    self.things = parsed.articles
//                    for p in parsed.articles {
//                        print(p.title)
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }
//                } catch {
//                    print("OOPS")
//                }
//            }.resume()
//        };
        
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


        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTitleCell", for: indexPath) as! NewsTitleCell
        
//        cell.textLabel?.text = self.things[indexPath.item].title! + "dsadsad"
        
        if self.things[indexPath.item].title != nil {
            cell.lblDescription?.text = self.things[indexPath.item].title!
        } else {
            cell.lblDescription?.text = "Title not found"
        }

        if self.things[indexPath.item].urlToImage != nil {
            cell.imgNews.setImageFromUrl(ImageURL: self.things[indexPath.item].urlToImage! )
        }

        cell.selectionStyle = .none;
//        cell.containerView.dropShadow();
        cell.containerView!.layer.cornerRadius = 10;
        
        return cell
    }
    
}

extension UIImageView {
    
    func setImageFromUrl(ImageURL :String) {
        URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}


extension UIViewController {
    func showIndicator(withTitle title: String, and Description:String) {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = title
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = Description;
        Indicator.backgroundView.style = .solidColor;
        Indicator.backgroundView.color = UIColor.init(white: 0.0, alpha: 0.3);
        Indicator.show(animated: true)
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
