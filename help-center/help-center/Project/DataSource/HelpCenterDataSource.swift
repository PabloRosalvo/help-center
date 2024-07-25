import UIKit

protocol HelpCenterSourceDelegate: AnyObject {
    func seletectIndexPathRow(_ model: HelpeCenter)
}

final class HelpCenterDataSource: NSObject, UISearchBarDelegate {

    private weak var delegate: HelpCenterSourceDelegate?

    private var viewModel: HelpCenterViewModel? {
        didSet {
            collectionView?.reloadData()
        }
    }
        
    init(delegate: HelpCenterSourceDelegate) {
        self.delegate = delegate
    }
    
    func setViewModel(viewModel: HelpCenterViewModel) {
        self.viewModel = viewModel
    }
    
    var collectionView: UICollectionView? {
        didSet {
            collectionView?.register(HelpCenterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
  
}

extension HelpCenterDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 333, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 120)
    }

}

extension HelpCenterDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.modelList.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as? HelpCenterCollectionViewCell
        guard let cell = cell, let viewModel = viewModel else { return .init() }
        cell.setup(viewModel, indexPath)
        return cell
    }
    
}


