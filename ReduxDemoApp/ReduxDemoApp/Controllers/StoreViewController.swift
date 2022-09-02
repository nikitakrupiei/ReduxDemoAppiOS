import UIKit
import ReSwift
import ReduxDemoCore

protocol StatePresenter {
    associatedtype Props
    
    static func present(state: AppState) -> Props
    static func present(subscription: Subscription<AppState>) -> Subscription<Props>
}

extension StatePresenter {
    static func present(subscription: Subscription<AppState>) -> Subscription<Props> {
        subscription.select(present)
    }
}

extension StatePresenter where Props: Equatable {
    static func present(subscription: Subscription<AppState>) -> Subscription<Props> {
        subscription
            .select(present)
            .skipRepeats()
    }
}

class StoreViewController<Presenter: StatePresenter>: UIViewController, StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self, transform: Presenter.present)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: Presenter.Props) {
        render(props: state)
    }
    
    func render(props: Presenter.Props) {
        
    }
}
