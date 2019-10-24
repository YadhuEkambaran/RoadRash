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
    
    var finishedVehicles: [VehicleButton]
    
    init() {
        vehicles = [VehicleButton]()
        finishedVehicles = []
    }
    
    func check(_ vehicles: [VehicleButton]) {
        if checkAllVehiclesAreCar(vehicles) {
            print("Car race to start")
        } else if checkAllVehiclesAreMoto(vehicles) {
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
    
    func isAllCar(_ vehicles: [VehicleButton]) -> Bool {
        for vehicle in vehicles {
            if vehicle is CarButton {
                
            } else {
                return false
            }
        }
        
        return true
    }
    
    func checkAllVehiclesAreCar(_ vehicles: [VehicleButton]) -> Bool {
        for vehicle in vehicles {
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
    
    
    func checkAllVehiclesAreMoto(_ vehicles: [VehicleButton]) -> Bool {
        for vehicle in vehicles {
            if let moto = vehicle as? Motorcycle {
                if !(moto.isTwoWheeled()) {
                    return false
                }
            } else {
                return false
            }
        }
        
        return true
    }
    
    func canConductRace() -> Bool {
        return vehicles.count >= 4
    }
    
    func selectParticipants() -> [VehicleButton] {
        var nums: [Int] = []
        for index in 0...(vehicles.count - 1) {
            nums.append(index)
        }
        var randomValues = [VehicleButton]()
        for _ in 1...4 {
            let randomNo = Int(arc4random_uniform(UInt32(nums.count)))
            randomValues.append(vehicles[randomNo])
            nums.remove(at: randomNo)
        }
        
        return randomValues
    }
    
    
    func updatePerformance() {
        let performcedCar = self.vehicles.sorted(by: {$0.vehiclePerformance > $1.vehiclePerformance})
        performcedCar[0].brandName = "\(performcedCar[0].brandName)(1st)"
        performcedCar[1].brandName = "\(performcedCar[1].brandName)(2nd)"
        performcedCar[2].brandName = "\(performcedCar[2].brandName)(3rd)"
        performcedCar[3].brandName = "\(performcedCar[3].brandName)(4th)"
    }
    
    
}
