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
    var isDataLoading: Bool = false;
    var pageNo = 1;
    var pageSize = 20;
    
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
        
        getArticleData();
    
    }
    
    func getArticleData() {
        let baseRequest = BaseHttpRequest();
        
        DispatchQueue.main.async {
            self.showIndicator(withTitle: "Loading...", and: "getting list of articles")
        }
        
        let baseUrl = "https://newsapi.org/v2/everything?q=";
        
        let url = "\(baseUrl)\(self.article ?? "")" + "&apiKey=9ff1fdcc97804ae0861c05b1f7696fee&pageSize=\(self.pageSize)&page=\(self.pageNo)";
        baseRequest.getDataFromServer(baseUrl: url,forView: self){ (data)
            in
            DispatchQueue.main.async {
                self.hideIndicator()
            }
            let responseData = data as [Article]?;
            if responseData != nil {
                DispatchQueue.main.async {
                    self.things = responseData!;
                    self.tableView.reloadData()
                    //Shoule be fix: This is hack updating the list to draw proper shadow
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.tableView.reloadData()
                    })
                }
            } else {
                print("something is wrong")
            }
        };
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
            cell.imgNews.layer.cornerRadius = 25;
        }

        cell.selectionStyle = .none;
        cell.containerView.dropShadow();
        cell.containerView!.layer.cornerRadius = 10;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
        {
            if !isDataLoading{
                isDataLoading = true
                self.pageNo=self.pageNo+1
//                self.offset=self.limit * self.pageNo
//                loadCallLogData(offset: self.offset, limit: self.limit)
                getArticleData()
                
            }
        }
        
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        isDataLoading = false
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
