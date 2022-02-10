//
//  Extension + CryptCollectionView.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 10.02.2022.
//

import UIKit

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CryptoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crypts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CryptCustomCollectionViewCell.identifier, for: indexPath) as? CryptCustomCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(image: crypts[indexPath.row].image,
                       title: crypts[indexPath.row].name,
                       subtitle: crypts[indexPath.row].priceOnCrypt,
                       price: "$\(crypts[indexPath.row].priceOnDollar)",
                       product: "\(crypts[indexPath.row].percent)%")
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemTeal
        cell.selectedBackgroundView = backgroundView

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(crypts[indexPath.row])
        
        
    }
}
// MARK: - UICollectionViewDelegateFlowLayout for setting size/space/section cell
extension CryptoCollectionViewController: UICollectionViewDelegateFlowLayout {
        fileprivate var sectionInsets: UIEdgeInsets {
            return .zero
        }

        fileprivate var itemsPerRow: CGFloat {
            return 2
        }

        fileprivate var interitemSpace: CGFloat {
            return 5.0
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            let sectionPadding = sectionInsets.left * (itemsPerRow + 1)
            let interitemPadding = max(0.0, itemsPerRow - 1) * interitemSpace
            let availableWidth = collectionView.bounds.width - sectionPadding - interitemPadding
            let widthPerItem = availableWidth / itemsPerRow

            return CGSize(width: widthPerItem, height: widthPerItem)
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return interitemSpace
        }
}
