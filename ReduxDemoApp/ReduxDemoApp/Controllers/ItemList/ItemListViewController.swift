//
//  ItemListViewControllet.swift
//  ReduxDemoApp
//
//  Created by Nikita Krupiei on 16.08.2022.
//

import UIKit
import ReSwift

final class ItemListViewController: StoreViewController<ItemListPresenter> {
    
    @IBOutlet private weak var tableView: UITableView!
    private var props: ItemListPresenter.Props?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items List"
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewItemButtonPressed)
        )
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    @objc func addNewItemButtonPressed() {
        props?.addButtonPressedAction()
    }
    
    override func render(props: ItemListPresenter.Props) {
        self.props = props
        self.tableView.reloadData()
    }
}

extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        props?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = props?.cells[indexPath.row].title
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props?.cells[indexPath.row].selectionAction()
    }
}
