//
//  Router.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

protocol RouterProtocol : Presentable {
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(transition: UIViewControllerAnimatedTransitioning?)
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
    func popToModule(module: Presentable?, animated: Bool)
    
}

final class Router : NSObject, RouterProtocol {
    
    
    private weak var rootController : UINavigationController?
    private var completions : [UIViewController : () -> Void]
    private var transition : UIViewControllerAnimatedTransitioning?
    
    func toPresent() -> UIViewController? {
        return self.rootController
    }
    
    func push(_ module: Presentable?)  {
        self.push(module, transition: nil)
    }
    
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        self.push(module, transition: transition, animated: true)
    }
    
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)  {
        self.push(module, transition: transition, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?) {
        self.transition = transition
        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            self.completions[controller] = completion
        }
        self.rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule()  {
        self.popModule(transition: nil)
    }
    
    func popModule(transition: UIViewControllerAnimatedTransitioning?) {
        self.popModule(transition: transition, animated: true)
    }
    
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.transition = transition
        if let controller = rootController?.popViewController(animated: animated) {
            self.runCompletion(for: controller)
        }
    }
    
    func popToModule(module: Presentable?, animated: Bool) {
        if let controllers = self.rootController?.viewControllers , let module = module {
            for controller in controllers {
                if controller == module as! UIViewController {
                    self.rootController?.popToViewController(controller, animated: animated)
                    break
                }
            }
        }
    }
    
    
    func setRootModule(_ module: Presentable?) {
        self.setRootModule(module, hideBar: false)
    }
    
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.setViewControllers([controller], animated: false)
        self.rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = self.rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = self.completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    init(rootController : UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
        super.init()
        self.rootController?.delegate = self
    }
    
}


// MARK: - Extensions
// MARK: - UINavigationControllerDelegate

extension Router: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
    
}
