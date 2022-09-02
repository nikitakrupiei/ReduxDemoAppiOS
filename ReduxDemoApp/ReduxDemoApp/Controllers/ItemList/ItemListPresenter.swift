import ReduxDemoCore

struct ItemListPresenter: StatePresenter {
    struct Props {
        
        struct Cell {
            var title: String
            var selectionAction: () -> ()
        }
        
        var cells: [Cell]
        var addButtonPressedAction: () -> Void
    }
    
    static func present(state: AppState) -> Props {
        let propsCells = state.itemsListState.items.map { item in
            Props.Cell(title: item) {
                store.dispatch(Actions.ItemListAction.moveToDetails(item))
            }
        }
        
        return Props(cells: propsCells, addButtonPressedAction: {
            store.dispatch(Actions.AlertAction.showAlertOfType(.addNewItemToList))
        })
    }
}
