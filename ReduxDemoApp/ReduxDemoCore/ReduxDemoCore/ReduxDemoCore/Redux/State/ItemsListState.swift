import ReSwift

extension Actions {
    public enum ItemListAction: Action {
        case addNewItem(String)
        case moveToDetails(String)
    }
}

public struct ItemsListState {
    public var items: [String]
    
    init(items: [String] = []) {
        self.items = items
    }
    
    mutating private func addItem(name: String) {
        items.append(name)
    }
}

extension ItemsListState {
    public static func reduce(action: Action, state: Self?) -> Self {
        var state = state ?? ItemsListState()
        
        switch action {
        case let publicActions as Actions.ItemListAction:
            reduce(action: publicActions, state: &state)
        default:
            break
        }
        
        return state
    }
    
    private static func reduce(action: Actions.ItemListAction, state: inout Self) {
        switch action{
        case .addNewItem(let itemName):
            state.addItem(name: itemName)
        case .moveToDetails:
            break
        }
    }
}
