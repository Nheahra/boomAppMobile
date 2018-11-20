//
//  ContainerViewController.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/20/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController {
    
    enum SlideOutState {
        case bothCollapsed
        case menuPanelExpanded
        case sortPanelExpanded
    }
    
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    var currentState: SlideOutState = .bothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var menuViewController: SidePanelViewController?
    var sortViewController: SidePanelViewController?
    
    let centerPanelExpandedOffSet: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        centerNavigationController.didMove(toParent: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
}

extension ContainerViewController: CenterViewControllerDelegate {
    func toggleMenu() {
        let notAlreadyExpanded = (currentState != .menuPanelExpanded)
        if notAlreadyExpanded {
            addMenuViewController()
        }
        animateMenuPanel(shouldExpand: notAlreadyExpanded)
    }
    func toggleSort() {
        let notAlreadyExpanded = (currentState != .sortPanelExpanded)
        if notAlreadyExpanded {
            addSortViewController()
        }
        animateSortPanel(shouldExpand: notAlreadyExpanded)
    }
    func collapsePanels() {
        switch currentState {
        case .menuPanelExpanded:
            toggleMenu()
        case .sortPanelExpanded:
            toggleSort()
        default:
            break
        }
    }
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController){
        sidePanelController.delegate = centerViewController
        view.insertSubview(sidePanelController.view, at: 0)
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    func addMenuViewController() {
        guard menuViewController == nil else { return }
        if let vc = UIStoryboard.menuViewController() {
            vc.menuOptions = MenuOption.menuOptions()
            addChildSidePanelController(vc)
            menuViewController = vc
        }
    }
    func addSortViewController() {
        guard sortViewController == nil else { return }
        if let vc = UIStoryboard.sortViewController() {
            vc.menuOptions = MenuOption.sortOptions()
            addChildSidePanelController(vc)
            sortViewController = vc
        }
    }
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {self.centerNavigationController.view.frame.origin.x = targetPosition},
                       completion: completion)
    }
    func animateMenuPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .menuPanelExpanded
            animateCenterPanelXPosition(targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffSet)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) {finished in
                self.currentState = .bothCollapsed
                self.menuViewController?.view.removeFromSuperview()
                self.menuViewController = nil
            }
        }
    }
    func animateSortPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .sortPanelExpanded
            animateCenterPanelXPosition(targetPosition: -centerNavigationController.view.frame.width + centerPanelExpandedOffSet)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.currentState = .bothCollapsed
                self.sortViewController?.view.removeFromSuperview()
                self.sortViewController = nil
            }
        }
    }
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        switch recognizer.state {
            case .began:
                if currentState == .bothCollapsed {
                    if gestureIsDraggingFromLeftToRight {
                    addMenuViewController()
                    } else {
                        addSortViewController()
                    }
                showShadowForCenterViewController(true)
                }
            case .changed:
                if let rview = recognizer.view {
                    rview.center.x = rview.center.x + recognizer.translation(in: view).x
                    recognizer.setTranslation(CGPoint.zero, in: view)
                }
            case .ended:
                if let _ = menuViewController,
                    let rview = recognizer.view {
                    let hasMovedGreaterThanHalfway = rview.center.x < 0
                    animateMenuPanel(shouldExpand: hasMovedGreaterThanHalfway)
                }
            default:
                break
        }
    }
}

private extension UIStoryboard {
    static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    static func menuViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "MenuViewController") as? SidePanelViewController
    }
    static func sortViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "SortViewController") as? SidePanelViewController
    }
    static func centerViewController() -> CenterViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
    }
}
