# child view 변경하기

user action으로 여러개의 child view를 스위치 하는 방법 중 하나 입니다. 

모든 VC를 add, autolayout을 잡아주고.  

view.isHidden 프로퍼를 이용해 화면에 보여지는 뷰 만 컨트롤 할 수 있습니다. 

```swift
class SearchViewController: UIViewController {
    // MARK: - Properties

    var viewModel: SearchViewModel?

    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "검색어를 입력해 주세요."
        search.showsScopeBar = true
        search.scopeButtonTitles = ["web", "image", "video"]
        search.searchTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()

    let suggestionVC: UIViewController = {
        let vc = SuggestionViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()

    let webResultVC: UIViewController = {
        let vc = WebResultViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()

    let imageResultVC: UIViewController = {
        let vc = ImageResultViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()

    let videoResultVC: UIViewController = {
        let vc = VideoResultViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan

        configureUI()
        configureChildVC()

        searchBar.delegate = self
    }

    // MARK: - Actions

    @objc func textDidChange() {
        suggestionVC.view.isHidden = false
        webResultVC.view.isHidden = true
        imageResultVC.view.isHidden = true
        videoResultVC.view.isHidden = true
    }

    // MARK: - Helpers
    func configureChildVC() {

        let safeArea = view.safeAreaLayoutGuide

        self.addChild(suggestionVC)
        self.addChild(webResultVC)
        self.addChild(imageResultVC)
        self.addChild(videoResultVC)

        self.view.addSubview(suggestionVC.view)
        self.view.addSubview(webResultVC.view)
        self.view.addSubview(imageResultVC.view)
        self.view.addSubview(videoResultVC.view)

        suggestionVC.didMove(toParent: self)
        webResultVC.didMove(toParent: self)
        imageResultVC.didMove(toParent: self)
        videoResultVC.didMove(toParent: self)

        NSLayoutConstraint.activate([
            suggestionVC.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            suggestionVC.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            suggestionVC.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            suggestionVC.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            webResultVC.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            webResultVC.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            webResultVC.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            webResultVC.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            imageResultVC.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            imageResultVC.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            imageResultVC.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            imageResultVC.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            videoResultVC.view.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            videoResultVC.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            videoResultVC.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            videoResultVC.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }

    func configureUI() {
        self.navigationItem.title = "SEARCH"

        let safeArea = view.safeAreaLayoutGuide

        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: searchBar.frame.height)
        ])
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        suggestionVC.view.isHidden = true
        webResultVC.view.isHidden = true
        imageResultVC.view.isHidden = true
        videoResultVC.view.isHidden = true

        if selectedScope == 0 {
            webResultVC.view.isHidden = false
        } else if selectedScope == 1 {
            imageResultVC.view.isHidden = false
        } else {
            videoResultVC.view.isHidden = false
        }
    }
}

```
