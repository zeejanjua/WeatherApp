
import Foundation

protocol BaseViewModelDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func showErrorAlert(message: String)
    func showSuccessAlert(message: String)
}

extension BaseViewModelDelegate {
    
    func showLoader(){}
    func hideLoader(){}
    func showErrorAlert(message: String) {}
    func showSuccessAlert(message: String) {}
}

public class BaseViewModel: NSObject {
    weak var baseDelegate: BaseViewModelDelegate?
}
