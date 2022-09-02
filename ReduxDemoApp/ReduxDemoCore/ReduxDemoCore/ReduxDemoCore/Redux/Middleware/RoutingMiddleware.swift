import ReSwift

public func createRoutingMiddleware() -> Middleware<AppState> {
    RoutingMiddleware().asMiddleware()
}

private final class RoutingMiddleware {
    func asMiddleware() -> Middleware<AppState> {
        createMiddleware { context, action in
            switch action {
            case let itemListAction as Actions.ItemListAction:
                self.handleItemListAction(action: itemListAction, dispatch: context.dispatch, next: context.next)
            case let itemDetailsAction as Actions.ItemDetails:
                self.handleItemDetailsAction(action: itemDetailsAction, dispatch: context.dispatch, next: context.next)
            default:
                context.next(action)
            }
        }
    }
}

extension RoutingMiddleware {
    private func handleItemListAction(action: Actions.ItemListAction, dispatch: @escaping DispatchFunction, next: @escaping DispatchFunction) {
        switch action {
        case .moveToDetails(let detailsItem):
            dispatch(InternalActions.ItemDetails.select(detailsItem))
            dispatch(Actions.RoutingAction(destination: .itemDetails))
        case .addNewItem:
            dispatch(Actions.AlertAction.alertClosed)
            next(action)
        }
    }
    
    private func handleItemDetailsAction(action: Actions.ItemDetails, dispatch: @escaping DispatchFunction, next: @escaping DispatchFunction) {
        switch action {
        case .exitDetails:
            dispatch(Actions.RoutingAction(destination: .itemList))
            next(Actions.ItemDetails.exitDetails)
        }
    }
}
