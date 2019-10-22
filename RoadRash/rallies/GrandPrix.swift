//
//  GrandPrix.swift
//  RoadRash
//
//  Created by yadhukrishnan E on 22/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

class GrandPrix: Rally {
    
    var vehicles: [VehicleButton]
    
    init() {
        vehicles = [VehicleButton]()
    }
    
    func check() {
        if checkAllVehiclesAreCar() {
            print("Car race to start")
        } else if checkAllVehiclesAreMoto() {
            print("Moto race to start")
        } else {
            print("Invalid combo")
        }
    }
    
    
    func addVehicles(vehicle: VehicleButton?) {
        guard let vehicle = vehicle else {
            fatalError("Vehicle should not be nil")
        }
        
        self.vehicles.append(vehicle)
    }
    
    
    func checkAllVehiclesAreCar() -> Bool {
        for vehicle in self.vehicles {
            if let car = vehicle as? CarButton {
                if car.category == CarType.TOURING {
                    return false
                }
            } else if let moto = vehicle as? Motorcycle, moto.isTwoWheeled() {
                return false
            }
        }
        
        return true
    }
    
    
    func checkAllVehiclesAreMoto() -> Bool {
        for vehicle in self.vehicles {
            if let moto = vehicle as? Motorcycle, !moto.isTwoWheeled() {
                return false
            }
        }
        
        return true
    }
    
}
