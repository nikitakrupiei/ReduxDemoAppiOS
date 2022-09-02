import UIKit

final class ItemDetailsViewController: StoreViewController<ItemDetailsPresenter> {
    
    private var props: ItemDetailsPresenter.Props? {
        didSet{
            itemTitle.text = props?.title
        }
    }

    @IBOutlet private weak var itemTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Item details"
    }
    
    override func render(props: ItemDetailsPresenter.Props) {
        self.props = props
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent {
            props?.moveBackCompletion()
        }
    }
}
