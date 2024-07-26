//
//  HelpCenterViewController.swift
//  help-center
//
//  Created by PABLO ROSALVO DE MELO LOPES on 25/07/24.
//

import UIKit

final class HelpCenterViewController: UIViewController, UISearchBarDelegate {
    
    private let viewModel: HelpCenterViewModel

    private let contentView: HelpCenterView = {
        let view = HelpCenterView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var dataSource: HelpCenterDataSource = {
        let source = HelpCenterDataSource(delegate: self)
        return source
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetch()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(back))
        self.view.backgroundColor = .clear
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    init(viewModel: HelpCenterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func back() {
        viewModel.backButtonTapped()
    }
    
    private func fetch() {
        self.startActivityIndicator()
            self.viewModel.fetch { [weak self] error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.stopActivityIndicator()
                if error == nil {
                    self.dataSource.setViewModel(viewModel: self.viewModel)
                    self.contentView.setDataSource(self.dataSource)
                    self.contentView.collectionView.reloadData()
                } else {
                    self.handleError()
                }
            }
        }
    }
    
    private func handleError() {
        self.ds.showError {
            self.fetch()
        }
    }
    
}

extension HelpCenterViewController: HelpCenterSourceDelegate {
    func selectIndexPathRow(_ model: HelpeCenter) {
        
    }
    
}
