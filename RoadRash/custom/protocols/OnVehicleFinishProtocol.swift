//
//  OnVehicleFinishProtocol.swift
//  RoadRash
//
//  Created by yadhukrishnan E on 20/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

protocol OnVehicleFinishProtocol {
    func onFinished(vehicle v: VehicleButton)
    func onRaceFailed(vehicle v: VehicleButton)
}

