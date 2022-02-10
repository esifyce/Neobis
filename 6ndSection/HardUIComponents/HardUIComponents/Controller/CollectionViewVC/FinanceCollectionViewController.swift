//
//  FinanceCollectionViewController.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 09.02.2022.
//

import UIKit

class FinanceCollectionViewController: UIViewController {

    // MARK: - Properties
    var finance = [Finance]()
    
    // MARK: - Views and Layout properties
    private lazy var balanceLabel: UILabel = {
        let balance = UILabel()
        balance.text = "Баланс"
        balance.font =  UIFont.systemFont(ofSize: 16, weight: .bold)
        
        view.addSubview(balance)
        
        balance.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }
        return balance
    }()
    
    private lazy var cashLabel: UILabel = {
        let cash = UILabel()
        cash.text = "$1200.89"
        cash.font =  UIFont.systemFont(ofSize: 44, weight: .regular)
        
        view.addSubview(cash)
        
        cash.snp.makeConstraints {
            $0.top.equalTo(balanceLabel.snp.top).inset(20)
            $0.centerX.equalToSuperview()
        }
        return cash
    }()
    
    private lazy var monthLabel: UILabel = {
        let month = UILabel()
        month.text = "Апрель 2020"
        month.font =  UIFont.systemFont(ofSize: 20, weight: .thin)
        
        view.addSubview(month)
        
        month.snp.makeConstraints {
            $0.top.equalTo(cashLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        return month
    }()
    
    private lazy var rightChevron: UIImageView = {
        let rightAngle = UIImageView()
        
        rightAngle.image = UIImage(systemName: "chevron.right")
        rightAngle.tintColor = UIColor.black
        
        view.addSubview(rightAngle)
    
        rightAngle.snp.makeConstraints {
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        return rightAngle
    }()
    
    private lazy var lefrChevron: UIImageView = {
        let leftAngle = UIImageView()
        leftAngle.tintColor = UIColor.black
        leftAngle.image = UIImage(systemName: "chevron.left")
        
        view.addSubview(leftAngle)

        leftAngle.snp.makeConstraints {
            $0.centerY.equalTo(monthLabel.snp.centerY)
            $0.left.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        return leftAngle
    }()
    
    private lazy var showAllButton: UIButton = {
        let showAll = UIButton()
        showAll.setTitle("Cм. ещё", for: .normal)
        showAll.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        showAll.setTitleColor(UIColor.black, for: .normal)
        
        view.addSubview(showAll)
        showAll.addTarget(self, action: #selector(showAllFinance), for: .touchUpInside)
        
        showAll.snp.makeConstraints {
            $0.bottom.greaterThanOrEqualTo(view.safeAreaLayoutGuide).inset(30)
            $0.centerX.equalToSuperview()
        }
        return showAll
    }()
    
    private lazy var windowTableView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        
        let window = UICollectionView(frame: .zero, collectionViewLayout: layout)
        window.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9803921569, blue: 0.9921568627, alpha: 1)
        
        view.addSubview(window)
        window.delegate = self
        window.dataSource = self
        
        window.register(FinanceCustomCollectionViewCell.self, forCellWithReuseIdentifier: FinanceCustomCollectionViewCell.identifier)
        
        window.snp.makeConstraints {
            $0.top.equalTo(monthLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(showAllButton.snp.top)
        }
        
        return window
    }()
    
    private lazy var windowView: UIView = {
        let window = UIView()
        window.backgroundColor = UIColor(named: "PrimaryBackground")
        
        view.addSubview(window)
        
        window.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(windowTableView.snp.top)
        }
        return window
    }()
    
    // list ours elements view
    private lazy var listLayoutViews = [windowView, showAllButton, balanceLabel, cashLabel, monthLabel, lefrChevron, rightChevron, windowTableView]
    
// MARK: - Lifecycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pass to every elements for show on screen
        let _ = listLayoutViews.compactMap { $0 }
        
        finance += FinanceValues.values
        
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9764705882, blue: 0.9921568627, alpha: 1)
    }
    
    // MARK: - @objc function
    @objc private func showAllFinance() {
        print("См. ещё")
    }
}
