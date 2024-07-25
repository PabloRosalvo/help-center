import Foundation

protocol NetworkApiProtocol {
    func fetchListNodes(completion: @escaping (HelpeCenter?, RequestError?)  -> Swift.Void)
}

class Network: NetworkApiProtocol {
    private let requestManagerProtocol: RequestManagerProtocol
    enum BaseUrl {
        static let url = "https://helpcenter.dev.homolog.me/v1/helpcenter/categories"
    }
    init(requestManagerProtocol: RequestManagerProtocol = RequestManager()) {
        self.requestManagerProtocol = requestManagerProtocol
    }
    func fetchListNodes(completion: @escaping (HelpeCenter?, RequestError?) -> Void) {
        guard let url = URL(string: BaseUrl.url) else {
            return
        }
        self.requestManagerProtocol.request(url: url, method: .get, parameters: nil, headers: nil) { (result: Result<HelpeCenter?>) in
            switch result {
            case .success(let model):
                completion(model, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
