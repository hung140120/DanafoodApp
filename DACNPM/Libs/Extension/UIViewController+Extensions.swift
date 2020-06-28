//
//  UIViewController.swift
//  zody-native-app
//
//  Created by TruongVO07 on 5/31/18.
//  Copyright © 2018 Zody. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Init
extension UIViewController {
    static func vc() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }

//    static func vc(from storyboard: Storyboard) -> UIViewController {
//        let storyboard = UIStoryboard(storyboard: storyboard)
//        let identifier = String(describing: self)
//        return storyboard.instantiateViewController(withIdentifier: identifier)
//    }
}

//MARK: -
extension UIViewController {
    func lock() {
        view.isUserInteractionEnabled = false
    }

    func unLock() {
        view.isUserInteractionEnabled = true
    }
}

//MARK: - Alert
extension UIViewController {
    func alert(error: Error) {
        if (error as NSError).code == 444 { return } // Don't show error when cancel request
        alert(title: "", msg: error.localizedDescription, buttons: ["OK"], handler: nil)
    }

    func alert(title: String = "", msg: String, buttons: [String], handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for button in buttons {
            let action = UIAlertAction(title: button, style: .default, handler: { action in
                DispatchQueue.main.async {
                    handler?(action)
                }
            })
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}

enum DialogAction: Int {
    case OkAction = 0
    case CancelAction = -1
}

extension UIViewController {
    typealias AlertActionBlock = (String, Int) -> Void
    // MARK: AlertViewController.
    func showDialogWithTitle(title: String?, message: String?,
                             cancelTitle: String? = NSLocalizedString("Cancel", comment: ""),
                             okTitle: String = NSLocalizedString("OK", comment: ""),
                             inViewController: UIViewController? = nil,
                             completeHandler: AlertActionBlock?) -> Void {
        showAlertWithTitle(title: title ?? "", message: message, cancelTitle: cancelTitle, otherTitles: [okTitle],
                           preferredStyle: .alert, inViewController: inViewController, completeHandler: completeHandler)
    }
    // MARK: AlertViewController Type ActionSheet
    func showActionSheetWithMessage(message: String?, cancelTitle: String, titleOtherButtons: String ..., inViewController: UIViewController? = nil,
                                    completeHandler: @escaping AlertActionBlock) -> Void {

        showAlertWithTitle(message: message, cancelTitle: cancelTitle, otherTitles: titleOtherButtons,
                           preferredStyle: .actionSheet,
                           inViewController: inViewController, completeHandler: completeHandler)
    }
    func showAlertWithTitle(title: String? = nil, message: String?, cancelTitle: String? = nil, otherTitles: [String],
                            preferredStyle: UIAlertController.Style, inViewController: UIViewController? = nil,
                            completeHandler: AlertActionBlock?) -> Void {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (title) in
                completeHandler?(cancelTitle, DialogAction.CancelAction.rawValue)
            }
            alertController.addAction(cancelAction)
        }

        for (index, value) in otherTitles.enumerated() {
            let action = UIAlertAction(title: value, style: .default, handler: { (alertAction) -> Void in
                completeHandler?(value, index)
            })
            if (cancelTitle != nil) {
                action.setValue(UIColor.red, forKey: "titleTextColor")
            }
            alertController.addAction(action)
        }

        if let viewController = inViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    func goto(withIdentifier seque: String, sender: Any? = nil) {
        self.performSegue(withIdentifier: seque, sender: sender)
    }
    //    func goto(withStoryboar fileName: String, withIndentifier indentifier: String ) {
    //        let storyboard = UIStoryboard(name: fileName, bundle: nil)
    //        let controller = storyboard.instantiateViewController(withIdentifier: indentifier)
    //        self.navigationController?.pushViewController(controller, animated: true)
    ////        self.present(controller, animated: true, completion: nil)
    //    }

    func goto(withStoryboar fileName: String, present isPresent: Bool = false) {
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() {
            if (!isPresent) {
                if self.navigationController?.viewControllers.last != self {
                    return
                }
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            }
        }
    }

    func goto(withStoryboar fileName: String, withIndentifier indentifier: String, present isPresent: Bool = false ) {
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: indentifier)
        if (!isPresent) {
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            self.present(controller, animated: true, completion: nil)
        }
    }

    func gotoBlock<T: UIViewController>(withStoryboar fileName: String, aClass: T.Type, present isPresent: Bool = false, sendData: ((T?) -> Swift.Void)) {
        let className = String(describing: aClass)
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        let controller: T = storyboard.instantiateViewController(withIdentifier: className) as! T
        if (!isPresent) {
            sendData(controller)
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            self.present(controller, animated: true, completion: nil)
        }
    }

    func getViewControler<T: UIViewController>(withStoryboar fileName: String? = nil, aClass: T.Type) -> T? {
        let className = String(describing: aClass)
        var storyboard: UIStoryboard? = nil
        if fileName == nil {
            storyboard = self.storyboard
        } else {
            storyboard = UIStoryboard(name: fileName!, bundle: nil)
        }
        if storyboard != nil {
            let controller: T? = storyboard!.instantiateViewController(withIdentifier: className) as? T
            return controller
        } else {
            return nil
        }
    }

    func getViewControler(withStoryboar fileName: String, identifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        let controller: UIViewController? = storyboard.instantiateViewController(withIdentifier: identifier) as? UIViewController
        return controller
    }

    func back(animated: Bool = true, isDismiss: Bool = false) {
        if (isDismiss) {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            self.view.window!.layer.add(transition, forKey: kCATransition)
            self.dismiss(animated: false)
        } else if (self.navigationController != nil) {
            self.navigationController?.popViewController(animated: animated)
        } else {
            self.dismiss(animated: animated)
        }
    }

    func gotoPresentLeft(withStoryboar fileName: String, withIndentifier indentifier: String) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: indentifier)
        present(controller, animated: false, completion: nil)
    }

    func gotoPresentLeft<T: UIViewController>(withStoryboar fileName: String? = nil, aClass: T.Type, sendData: ((T?) -> Swift.Void)) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        //        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        if let controller = getViewControler(withStoryboar: fileName, aClass: aClass) {
            sendData(controller)
            present(controller, animated: false, completion: nil)
        }
    }

    class func getRoot() -> UIViewController {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let viewController = appDelegate.window?.rootViewController
        return viewController!;
    }

    class func setRoot(withStoryboar fileName: String, identifier: String) {
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        if let window = appDelegate.window {
            window.rootViewController = controller
            window.backgroundColor = UIColor.white
            window.makeKeyAndVisible()
        }
    }

    class func getVisibleViewController(_ _rootViewController: UIViewController? = nil) -> UIViewController? {

        var rootViewController = _rootViewController
        if rootViewController == nil {
            rootViewController = getRoot()
        }

        if rootViewController?.presentedViewController == nil {
            return rootViewController
        }

        if let presented = rootViewController?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            } else if presented.isKind(of: UITabBarController.self){
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }

            return getVisibleViewController(presented)
        }
        return nil
    }

    func insert(vc: UIViewController, index: Int) {
        var vcs = self.navigationController?.viewControllers
        vcs?.insert(vc, at: index)
        if let vcs = vcs {
            self.navigationController?.setViewControllers(vcs, animated: false)
        }
    }

    func back<T: UIViewController>(aClass: T.Type, animated: Bool = true) {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc.isKind(of: aClass) {
                self.navigationController?.popToViewController(vc, animated: animated)
            }
        }
    }
    
    func backPresentRight(withStoryboar fileName: String, withIndentifier indentifier: String? = nil) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        if let indentifier = indentifier {
            let controller = storyboard.instantiateViewController(withIdentifier: indentifier)
            present(controller, animated: false, completion: nil)
        } else {
            if let controller = storyboard.instantiateInitialViewController() {
                controller.modalPresentationStyle = .fullScreen
                present(controller, animated: false, completion: nil)
            }
        }
    }
    
    func setTabBarVisible(visible: Bool, animated: Bool) {

        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time

        // bail if the current state matches the desired state
        if (isTabBarVisible == visible) { return }

        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)

        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)

        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }

    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
}
