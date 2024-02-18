import UIKit

final class CountDownCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .vertical
        itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 150)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CountDownCollectionViewDelegate: AnyObject {
    var countDowns: [CountDownEntity] { get }
}

final class CountDownCollectionView: UICollectionView {
    weak var viewDelegate: CountDownCollectionViewDelegate?

    private let collectionLayout = CountDownCollectionViewLayout()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CountDownCollectionView {
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
        register(CountDownCell.self, forCellWithReuseIdentifier: CountDownCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource
extension CountDownCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewDelegate else { return 0 }
        return viewDelegate.countDowns.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountDownCell.identifier, for: indexPath) as! CountDownCell
        cell.setupCell(countDown: (viewDelegate?.countDowns[indexPath.item])!) //TODO: add guard

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CountDownCollectionView: UICollectionViewDelegateFlowLayout {
}

extension CountDownCollectionView: CountDownCellDelegate {
}
