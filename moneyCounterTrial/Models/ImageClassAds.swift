
//  Created by PUGAZHENTHI VENKATACHALAM on 25/10/19.

import UIKit
let ohmsLawImage = UIImage(named: "ohmsImage.png")
let energyCostImage = UIImage(named: "energyImage.png")
let civilImage = UIImage(named: "civilCalculatorImage.png")
let physicsImage = UIImage(named: "physicsImage.png")
let unitsImage = UIImage(named: "unitsImage.png")
let concreteImage = UIImage(named: "concreteImage.png")
let beamImage = UIImage(named: "beamImage.png")
let hydraulicsImage = UIImage(named: "hydraulicsImage.png")
let pilingImage = UIImage(named: "pilingImage.png")
let surveyImage = UIImage(named: "surveyImage.png")
let soilImage = UIImage(named: "soilImage.png")
let columnImage = UIImage(named: "columnImage.png")
let bridgeImage = UIImage(named: "bridgeImage.png")
let timberImage = UIImage(named: "timberImage.png")
let highwaysImage = UIImage(named: "highwaysImage.png")
let geoImage = UIImage(named: "geoImage.png")

@objc class ImageClassAds: NSObject {
    
    var imageArrayAds = [
        ohmsLawImage,
        energyCostImage,
        civilImage,
        physicsImage,
        unitsImage,
        concreteImage,
        beamImage,
        columnImage,
        hydraulicsImage,
        pilingImage,
        surveyImage,
        soilImage,
        bridgeImage,
        timberImage,
        highwaysImage,
        geoImage
        
    ]
    
    var appIdArray = [
        491898006,  //civil engg calculators and Converters
        531132387,  //civil engg calculators and Converters
        
        673068400,  //civil engg calculators and Converters
        827404220, //physics
        531049678,  //units
        643608704,  //concrete
        1046482593,  //beam
        1148046540,  //column
        602612855, //hydra
        1181385535,  //piling
        641965073,  //survey
        635284491,  //soil
        1446174057,  //bridge
        646321927,  //timber
        661032270,  //highways
        1489296731, //geo
    ]  //movie
    func imageForCellAds(row :Int) -> UIImage {
        
        return imageArrayAds[row]!
    }
    func appIdForCellAds(row : Int) -> Int {
        return appIdArray[row]
    }

}

