//
//  ArticleViewController.swift
//  newsr
//
//  Created by Rahul Shirphule on 2019/10/08.
//  Copyright © 2019 Bryn Divey. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController,UITableViewDataSource, UITableViewDelegate  {

    var things = ["apple","swift","bitcoin","domains"]
    var images = ["https://techcrunch.com/wp-content/uploads/2019/09/20190910173600_125767.jpg","https://i.kinja-img.com/gawker-media/image/upload/s--MI8gM3sK--/c_fill,fl_progressive,g_center,h_900,q_80,w_1600/r35teq2mwsq97oa7svlh.jpg","https://techcrunch.com/wp-content/uploads/2019/09/DSCF7794.jpg","https://i.kinja-img.com/gawker-media/image/upload/s--MI8gM3sK--/c_fill,fl_progressive,g_center,h_900,q_80,w_1600/r35teq2mwsq97oa7svlh.jpg"]
 
    @IBOutlet var btnAddKin: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnAddKin.layer.cornerRadius = 10;
//        things.append("apple");
//        things.append("swift");
//        things.append("bitcoin");
//        things.append("domains");
        
        self.tableView.register(UINib.init(nibName: "ArticleViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        self.tableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.things.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.item)
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleViewCell
        
        //        cell.textLabel?.text = self.things[indexPath.item].title! + "dsadsad"
        cell.lblArticle?.text = self.things[indexPath.item]
        
        cell.img.setImageFromUrl(ImageURL: self.images[indexPath.item])
        
        cell.selectionStyle = .none;
//        cell.containerView.dropShadow();
        cell.containerView!.layer.cornerRadius = 10;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsView = self.storyboard?.instantiateViewController(withIdentifier: "newsView") as! ViewController
        newsView.article = self.things[indexPath.row];
        self.navigationController?.pushViewController(newsView, animated: true);
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
