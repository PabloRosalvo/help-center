import Foundation

final class HelpCenterViewModel {
    private let api: NetworkApiProtocol
    private var model: HelpeCenter?
    var actionBackButtonTapped: (() -> Void)?

    init(api: NetworkApiProtocol = Network()) {
        self.api = api
    }
    func backButtonTapped() {
        actionBackButtonTapped?()
    }
    var modelList: [HelpeCenter.Item?] {
        return model?.items ?? []
    }
    
    func fetch(_ completion: @escaping (RequestError?) -> Void) {
        api.fetch { [weak self] model, error in
            guard error == nil else {
                completion(error)
                return
            }
            self?.model = model
            completion(error)
        }
    }
}
