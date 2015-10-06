//
//  Photo.swift
//  PeekPop
//
//  Created by Frederik Jacques on 06/10/15.
//  Copyright © 2015 Frederik Jacques. All rights reserved.
//

import UIKit

struct Photo {

    let caption:String
    let imageName:String
    let city:String
    
    init( caption:String, imageName:String, city:String ){
        
        self.caption = caption
        self.imageName = imageName
        self.city = city
        
    }
    
}
