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
    private let homeNavigationView = HomeNavigationView()


    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - Private functions
private extension HomeViewController {
    func configure() {
        collectionView.viewDelegate = self
        view.backgroundColor = Resources.Colors.Backgrounds.background

        presenter?.viewLoaded()
    }

    func addViews() {
        [collectionView, homeNavigationView].forEach { view.addSubview($0) }
    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            homeNavigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeNavigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: homeNavigationView.bottomAnchor, constant: 10),
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

// MARK: - CountDownCellDelegate
extension HomeViewController: CountDownCellDelegate {
}
