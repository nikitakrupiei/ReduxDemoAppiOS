import ReSwift
import UIKit
import ReduxDemoCore

final class AppCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let alertProvider: AlertProvider
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        alertProvider = AlertProvider()
        self.window = window
        
        window.rootViewController = navigationController
        
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }
        }
    }
    
    private func pushViewController(identifier: String, animated: Bool) {
        let viewController = instantiateViewController(identifier: identifier)
        let newViewControllerType = type(of: viewController)
        
        if let currentVc = navigationController.topViewController {
            let currentViewControllerType = type(of: currentVc)
            if currentViewControllerType == newViewControllerType {
                return
            }
        }
        
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    private func instantiateViewController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    private func handleAlertState(state: AlertState?) {
        guard let state = state else {
            return
        }
        if let _ = navigationController.topViewController?.presentedViewController as? UIAlertController {
            return
        }

        let alert = alertProvider.provideAlert(of: state.currentAlertToShow)
        
        navigationController.topViewController?.present(alert, animated: true, completion: nil)
        
    }
}

extension AppCoordinator: StoreSubscriber {
    func newState(state: RoutingState) {
        let shouldAnimate = navigationController.topViewController != nil
        pushViewController(identifier: state.navigationState.rawValue, animated: shouldAnimate)
        
        handleAlertState(state: state.alertState)
    }
}
