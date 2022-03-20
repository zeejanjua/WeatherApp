

enum Route: String {

    case weatherInfo = "onecall"
    
    func url() -> String{
        return Constants.baseURL + self.rawValue
    }
}
