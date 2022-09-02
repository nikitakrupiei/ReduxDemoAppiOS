import ReduxDemoCore

struct ItemDetailsPresenter: StatePresenter {
    struct Props {
        var title: String?
        var moveBackCompletion: () -> Void
    }
    
    static func present(state: AppState) -> Props {
        Props(
            title: state.itemDetailsState?.item,
            moveBackCompletion: {
                store.dispatch(Actions.ItemDetails.exitDetails)
            }
        )
    }
}
