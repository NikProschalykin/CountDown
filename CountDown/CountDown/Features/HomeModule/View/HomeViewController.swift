import UIKit

protocol HomeViewProtocol: AnyObject {
    func showCountDowns(countDowns: [CountDownEntity])
}

class HomeViewController: UIViewController {
    // MARK: - Public
    var presenter: HomePresenterProtocol?

    // MARK: - Private
    internal var countDowns: [CountDownEntity] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private var collectionView = CountDownCollectionView()


    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
    }
}

// MARK: - Private functions
private extension HomeViewController {
    func configure() {
        collectionView.viewDelegate = self
        view.backgroundColor = Resources.Colors.Backgrounds.background
        title = "Отсчеты"

        presenter?.viewLoaded()
    }

    func addViews() {
        [collectionView].forEach { view.addSubview($0) }
    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - @objc extension
@objc extension HomeViewController {
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func showCountDowns(countDowns: [CountDownEntity]) {
        self.countDowns = countDowns
    }
}

// MARK: - CountDownCollectionViewDelegate
extension HomeViewController: CountDownCollectionViewDelegate {
}
