//
//  Motorcycle.swift
//  RoadRash
//
//  Created by yadhukrishnan E on 22/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

class Motorcycle: VehicleButton {
    
        var isSideCarAvail: Bool
    
        required init() {
            self.isSideCarAvail = true
            super.init()
        }
       
        required init(brandName: String, modelName: String, maximalSpeed: Double, weight: Int, fuel: Int,    economy: Double, isSideCarAvail: Bool) {
            self.isSideCarAvail = isSideCarAvail
            super.init(brandName: brandName, modelName: modelName, maximalSpeed: maximalSpeed, weight: weight, fuel: fuel, economy: economy)
        }
       
    
        required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
        }
       
    
        required init(brandName: String, modelName: String, maximalSpeed: Double, weight: Int, fuel: Int,   economy: Double) {
            fatalError("init(brandName:modelName:maximalSpeed:weight:fuel:economy:) has not been implemented")
        }
       
    
       override func toString() {
            super.toString()
            var category: String
            if isSideCarAvail {
                category = "Moto, with sidecar"
            } else {
                category = "Moto"
            }
        
            print("\(self.brandName) \(modelName) -> speed max -> \(speed) \(Constants.SPEED_UNIT), weight = \(self.weight) \(Constants.WEIGHT_UNIT) category \(category)")
       }
    
    func isTwoWheeled() -> Bool {
        return self.isSideCarAvail
    }
    
}
