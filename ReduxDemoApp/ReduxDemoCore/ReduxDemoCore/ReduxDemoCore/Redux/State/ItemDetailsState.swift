//
//  ItemDetailsState.swift
//  ReduxDemoCore
//
//  Created by Nikita Krupiei on 16.08.2022.
//

import ReSwift

extension Actions {
    public enum ItemDetails: Action {
        case exitDetails
    }
}

extension InternalActions {
    enum ItemDetails: Action {
        case select(String)
    }
}

public struct ItemDetailsState {
    public var item: String
}

extension ItemDetailsState {
    public static func reduce(action: Action, state: Self?) -> Self? {
        
        switch action {
        case InternalActions.ItemDetails.select(let itemName):
            return Self(item: itemName)
        case Actions.ItemDetails.exitDetails:
            return nil
        default:
            break
        }
        
        return state
    }
}
