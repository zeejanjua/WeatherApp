
import UIKit

class BaseController: UIViewController {
    
    //MARK: - ViewController Methods
    override func loadView() {
        super.loadView()
        //* Disabling swipe back gesture *//
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //* Make default settings for nav bar *//
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
}
