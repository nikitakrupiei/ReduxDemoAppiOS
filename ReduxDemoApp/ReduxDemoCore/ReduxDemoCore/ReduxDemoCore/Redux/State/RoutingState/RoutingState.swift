import ReSwift

public enum RoutingDestination: String {
    case itemList = "ItemListViewController"
    case itemDetails = "ItemDetailsViewController"
}

extension Actions {
    public struct RoutingAction: Action {
        public let destination: RoutingDestination
        
        public init(destination: RoutingDestination) {
            self.destination = destination
        }
    }
}

public struct RoutingState {
    public var navigationState: RoutingDestination
    public var alertState: AlertState?
    
    init(navigationState: RoutingDestination = .itemList, alertState: AlertState?) {
        self.navigationState = navigationState
    }
}

extension RoutingState {
    public static func reduce(action: Action, state: Self?) -> Self {
        var state = state ?? RoutingState(alertState: .reduce(action: action, state: state?.alertState))
        
        switch action {
        case let routingAction as Actions.RoutingAction:
            state.navigationState = routingAction.destination
        case _ as Actions.AlertAction:
            state.alertState = .reduce(action: action, state: state.alertState)
        default: break
        }

        return state
    }
}
