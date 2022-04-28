//
//  ExtremelyRoundedCornerUIView.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 27/04/22.
//

import Foundation
import UIKit

@IBDesignable public class ExtremelyRoundedCornerUIView: UIView {

    override public func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = 14;
        self.layer.masksToBounds = true
    }
}
