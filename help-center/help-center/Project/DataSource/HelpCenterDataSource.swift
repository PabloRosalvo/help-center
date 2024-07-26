import UIKit

protocol HelpCenterSourceDelegate: AnyObject {
    func selectIndexPathRow(_ model: HelpeCenter)
}

final class HelpCenterDataSource: NSObject, UISearchBarDelegate {
    
    private lazy var contentView: HelpCenterHeaderView = {
        let view = HelpCenterHeaderView()
        return view
    }()
    
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
            collectionView?.register(HelpCenterHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
            
            if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.sectionHeadersPinToVisibleBounds = true
            }
        }
    }
}

extension HelpCenterDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 120)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension HelpCenterDataSource: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.modelList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HelpCenterCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let viewModel = viewModel else { return cell }
        
        cell.setup(viewModel, indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath) as? HelpCenterHeaderView else {
            return UICollectionReusableView()
        }
        if contentView.superview == nil {
            header.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: header.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: header.trailingAnchor),
                contentView.topAnchor.constraint(equalTo: header.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: header.bottomAnchor)
            ])
        }
        
        return header
    }
}
