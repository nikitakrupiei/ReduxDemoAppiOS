//
//  AlertProvider.swift
//  ReduxDemoApp
//
//  Created by Nikita Krupiei on 25.08.2022.
//

import UIKit
import ReduxDemoCore

struct AlertProvider {
    func provideAlert(of type: ApplicationAlerts) -> UIAlertController{
        switch type {
        case .addNewItemToList:
            return createAddNewItemToListAlert()
        }
    }
    
    private func createDefaultCancelAction() -> UIAlertAction {
        UIAlertAction(title: "Cancel", style: .destructive) { _ in
            dispatchCloseAlert()
        }
    }
    
    private func dispatchCloseAlert() {
        store.dispatch(Actions.AlertAction.alertClosed)
    }
    
    private func createAddNewItemToListAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Enter element name", message: nil, preferredStyle: .alert)
        alert.addTextField()

        let okAction = UIAlertAction(title: "Add", style: .default) { [weak alert] _ in
            guard let textField = alert?.textFields?.first, let text = textField.text, !text.isEmpty else {
                dispatchCloseAlert()
                return
            }

            store.dispatch(Actions.ItemListAction.addNewItem(text))
        }
        
        let cancelAction = createDefaultCancelAction()

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        return alert
    }
}
