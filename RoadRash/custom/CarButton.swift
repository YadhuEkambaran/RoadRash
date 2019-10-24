//
//  MaxButton.swift
//  RoadRash
//
//  Created by yadhukrishnan E on 19/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

class CarButton: VehicleButton {

    var category: CarType
    
    required init() {
        self.category = CarType.TOURING
        super.init()
    }
    
    required init(brandName: String, modelName: String, maximalSpeed: Double, weight: Int, fuel: Double, economy: Double, category: CarType) {
        self.category = category
        super.init(brandName: brandName, modelName: modelName, maximalSpeed: maximalSpeed, weight: weight, fuel: fuel, economy: economy)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(brandName: String, modelName: String, maximalSpeed: Double, weight: Int, fuel: Double, economy: Double) {
        fatalError("init(brandName:modelName:maximalSpeed:weight:fuel:economy:) has not been implemented")
    }
    
    override func toString() -> String {
        return ("\(self.brandName) \(modelName) -> speed max -> \(speed) \(Constants.SPEED_UNIT), weight = \(self.weight) \(Constants.WEIGHT_UNIT)  car category \(category)")
    }
    
}
