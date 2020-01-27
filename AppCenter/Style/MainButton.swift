//
//  MainButton.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

class MainButton: UIButton {

    enum BColor {
        case blue
        case white
    }
    
    private var shadowHeight: CGFloat = 10.0
    private var choosenColor = BColor.blue
    
    func setupButton(color: BColor = .blue, title: String) {
        
        setTitle(title, for: .normal)
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        
        switch color {
        case .blue:
            choosenColor = .blue
            backgroundColor = UIColor.deepSkyBlue
            setTitleColor(.white, for: .normal)
            shadowHeight = 5.0
            setShadowLayer(color: .blue, shadowRadius: 7.0, opacity: 0.5, height: shadowHeight)
        case .white:
            choosenColor = .white
            backgroundColor = UIColor.white
            setTitleColor(.black, for: .normal)
            shadowHeight = 2.0
            setShadowLayer(color: .white, shadowRadius: 5.0, height: shadowHeight)
        }
    }

    // Animation
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.backgroundColor = self.getButtonColor(color: self.choosenColor, tapped: true)
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.layer.shadowOffset = CGSize(width: 3.0, height: 4.0)
            self.layer.shadowOpacity = 0.6
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.backgroundColor = self.getButtonColor(color: self.choosenColor, tapped: false)
            self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            self.layer.shadowOffset = CGSize(width: 3.0, height: self.shadowHeight)
            self.layer.shadowOpacity = 0.4
        })
    }

    // Shadow
    private func setShadowLayer(color: BColor, shadowRadius: CGFloat, opacity: Float = 0.4, height: CGFloat = 2.0) {
        switch color {
        case .blue:
            layer.shadowColor = UIColor.deepSkyBlue.cgColor
        case .white:
            layer.shadowColor = UIColor.lightBlueGrey.cgColor
        }
        
        layer.shadowOffset = CGSize(width: 0.0, height: height)
        layer.masksToBounds = false
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        layer.cornerRadius = frame.height / 2
    }
    
    private func getButtonColor(color: BColor, tapped: Bool) -> UIColor {
        switch color {
        case .blue:
            return tapped ? UIColor.deepSkyBlueTapped : UIColor.deepSkyBlue
        case .white:
            return tapped ? UIColor.whiteTapped : UIColor.white
        }
    }

}

