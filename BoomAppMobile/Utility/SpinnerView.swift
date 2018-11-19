//
//  SpinnerView.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit

protocol SpinnerViewInterface {
    func show()
    func show(showDelay: Double)
    func hide()
    func hide(easeOutDelay: Double)
}
extension SpinnerViewInterface {
    func show() {
        show(showDelay: 0.0)
    }
    func hide() {
        hide(easeOutDelay: 0.0)
    }
}
final class SpinnerView: UIView, SpinnerViewInterface {
    static let sharedInstance = { return SpinnerView() }()
    private let activityView = UIActivityIndicatorView()
    private var startDelayed = false
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.black
        translatesAutoresizingMaskIntoConstraints = false
        accessibilityIdentifier = "spinner_view"
        
        activityView.startAnimating()
        activityView.style = UIActivityIndicatorView.Style.whiteLarge
        activityView.color = UIColor.white
        addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        activityView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    func show(showDelay: Double = 0.0) {
        guard showDelay > 0 else { addToWindow(); return }
        startDelayed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + showDelay) {[weak self] in
            if self?.startDelayed ?? false { self?.startDelayed = false; self?.addToWindow() }
        }
    }
    func hide(easeOutDelay: Double = 0.5) {
        startDelayed = false
        guard easeOutDelay > 0 else { removeFromWindow(); return }
        let animations: () -> () = { [weak self] in self?.alpha = 0.0 }
        let completion: (Bool) -> () = { [weak self] _ in self?.removeFromWindow() }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, delay: easeOutDelay, options: UIView.AnimationOptions.curveEaseOut, animations: animations, completion: completion)
        }
    }
    private func addToWindow() {
        alpha = 0.4
        guard let mainWindow = UIApplication.shared.delegate?.window, let window = mainWindow else {return}
        
        window.addSubview(self)
        pinFullScreen(to: window)
        layoutIfNeeded()
        window.setNeedsUpdateConstraints()
        window.updateConstraintsIfNeeded()
    }
    private func removeFromWindow() {
        self.removeFromSuperview()
    }
}
