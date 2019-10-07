//
//  Article.swift
//  newsr
//
//  Created by Rahul Shirphule on 2019/10/07.
//  Copyright © 2019 Bryn Divey. All rights reserved.
//

import Foundation

struct Article : Codable{
    let author:String?
    let content:String?
    let description:String?
    let publishedAt:String?
    ///brokenlet source:String?
    let title:String?
    let url:String?
    let urlToImage:String?
}
