//
//  AllApiModel.swift
//  DemoTaskTblCollection
//
//  Created by Rakesh Gupta on 5/9/21.
//

import Foundation

class ImageModelData: NSObject {
    @objc var arrImage = [Any]()
    @objc var tagNum = NSInteger()
    
    init(data: Dictionary<String,Any>) {
        super.init()
        
        for (key,value) in data {
            if let v = value as? Array<Any> {
                var arr = [Any]()
                for i in v {
                    arr.append(i)
                }
                self.setValue(arr, forKey: key)
                
            }else{
                self.setValue(value, forKey: key)
            }
            
        }
    }
    
    override init() {
        super.init()
    }
}
