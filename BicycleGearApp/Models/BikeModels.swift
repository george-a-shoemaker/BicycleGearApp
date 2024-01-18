//
//  File.swift
//  BicycleGearApp
//
//  Created by George Shoemaker on 12/20/23.
//

import Foundation
import BicycleGearMath

enum DevelopmentUnit {
    case metersOfDevelopment
    case gearInches
}

enum LengthUnit {
    case inch
    case meter
}

struct Bike {
    let name: String
    let ratio: Ratio
    let wheel : Wheel
    
    private lazy var development: Double = {
        gearDevelopment(
            chainring: ratio.chainring,
            cog: ratio.cog,
            circumferance: wheel.circumferance
        )
    }()
    
    lazy var metersOfDevelopment: Double = {
        switch wheel.unit {
            case .inch: return metersFrom(inches: development)
            case .meter: return development
        }
    }()
    
    lazy var gearInches: Double = {
        switch wheel.unit {
            case .inch: return development
            case .meter: return inchesFrom(meters: development)
        }
    }()
}

struct Ratio {
    let chainring : Int
    let cog : Int
    let ratio: Double
    
    init(chainring: Int, cog: Int) {
        self.chainring = chainring
        self.cog = cog
        self.ratio = ratioOf(chainring: chainring, cog: cog)
    }
    
    lazy var skidPatches: Int = {
        return skidPatchesOf(chainring: chainring, cog: cog)
    }()
    
    lazy var skidPatchesAmbidextrous: Int = {
        return skidPatchesAmbidextrousOf(chainring: chainring, cog: cog)
    }()
}

struct Wheel {
    let name: String
    let circumferance: Double
    let unit: LengthUnit
}
