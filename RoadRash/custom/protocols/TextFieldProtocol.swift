//
//  TextFieldProtocol.swift
//  RoadRash
//
//  Created by yadhukrishnan E on 23/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

protocol TextFieldProtocol {
    
}

extension TextFieldProtocol {
    func clearText(vehicle: VehicleButton) {
        vehicle.stringValue = ""
    }
}
