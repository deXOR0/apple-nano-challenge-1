//
//  RoundedUIView.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 27/04/22.
//

import Foundation
import UIKit

@IBDesignable public class CircularUIView: UIView {

    override public func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}
