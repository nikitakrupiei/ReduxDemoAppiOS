import ReSwift

public struct AppState {
    public var routingState: RoutingState
    public var itemsListState: ItemsListState
    public var itemDetailsState: ItemDetailsState?
}

extension AppState {
    public static func reduce(action: Action, state: Self?) -> Self {
        AppState(
            routingState: .reduce(action: action, state: state?.routingState),
            itemsListState: .reduce(action: action, state: state?.itemsListState),
            itemDetailsState: .reduce(action: action, state: state?.itemDetailsState)
        )
    }
}
