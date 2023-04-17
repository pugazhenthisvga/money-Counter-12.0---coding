//
//  ModelManager.swift
//  CustomSplitControl

import UIKit
import CoreLocation
// quick singleton implementation for our ModelManager.
private let _singletonInstance = ModelManager()

class ModelManager: NSObject {
    // shared instance of ModelManager.
    class var sharedInstance: ModelManager { return _singletonInstance }
    class var sharedInstance1: ModelManager { return _singletonInstance }
    var moreAppCandies = [Candy]()
   
    override init() {
        super.init()
        // initialize list of people

        moreAppCandies = [
            Candy( name:NSLocalizedString("ohmsLawCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:5),
            Candy( name:NSLocalizedString("energyCostCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:5),
        Candy( name:NSLocalizedString("civilCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:5),
        Candy( name:NSLocalizedString("myPhysicsCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:1),
        Candy( name:NSLocalizedString("unitsConverter",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:3),
        Candy( name:NSLocalizedString("concreteCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:9),
        Candy( name:NSLocalizedString("beamCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:7),
        Candy( name:NSLocalizedString("columnCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:13),
        Candy( name:NSLocalizedString("hydraulicsCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:8),
        Candy( name:NSLocalizedString("pilingCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:10),
        Candy( name:NSLocalizedString("surveyCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:11),
        Candy( name:NSLocalizedString("soilCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:12),
        Candy( name:NSLocalizedString("bridgeCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:14),
        Candy( name:NSLocalizedString("timberCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:14),
        Candy( name:NSLocalizedString("highwaysCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:14),
        Candy( name:NSLocalizedString("geometricCalculator",comment:"CONVERTER"),segueNo: "moreAppsSegue",index:15)]
        
        
            
   
   
}
}
