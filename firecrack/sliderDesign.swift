//
//  sliderDesign.swift
//  Fireplay
//
//  Created by Paramesh on 17/02/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
@IBDesignable
class sliderDesign: UISlider {

    @IBInspectable var thumbImage: UIImage? {
        
        didSet {
            
            setThumbImage(thumbImage, for: .normal)

     }
  }

}
