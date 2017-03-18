//
//  CustomFocusButton.swift
//  Fireplay
//
//  Created by Gowdhaman on 07/03/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit

class CustomFocusButton: UIButton {

    override var canBecomeFocused: Bool {
        return true
    }
    //We Can chance the focus behavior.... Is a good idea if we evidence it
    override func didUpdateFocus(in context: UIFocusUpdateContext,
                        with coordinator: UIFocusAnimationCoordinator) {
        
        //Bahavior we will trigger when view lost focus
        if context.previouslyFocusedView === self
        {
            UIButton.animate(withDuration: 0.1, animations: { () -> Void in
                context.previouslyFocusedView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
        
        //Bahavior we will trigger when view get focus
        if context.nextFocusedView === self
        {
            UIButton.animate(withDuration: 0.1, animations: { () -> Void in
                context.nextFocusedView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        
    }
}
