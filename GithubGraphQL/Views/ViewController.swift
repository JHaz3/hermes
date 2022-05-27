import UIKit
import Apollo

class ViewController: UIViewController {
    
    @IBOutlet weak var gitRepoCollectionView: UICollectionView!
    
    var viewModel: ViewModel!
    var lastConnection: SearchRepositoriesQuery.Data.Search?
    var activeRequest: Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(delegate: self)
        viewModel.search(phrase: "graphql")
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureCollectionView() {
        gitRepoCollectionView.delegate = self
        gitRepoCollectionView.dataSource = self
        gitRepoCollectionView.frame = view.bounds
        gitRepoCollectionView.collectionViewLayout = createTwoColmnFlowLayout()
    }
    
}// End of Class

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = gitRepoCollectionView.dequeueReusableCell(withReuseIdentifier: "gitRepoCell", for: indexPath) as? GitRepoCollectionViewCell else { return UICollectionViewCell() }
        let object = viewModel.list[indexPath.row]
        
        cell.nameLabel.text = "Name: \(object.owner.login)"
        cell.starCountLabel.text = "Stars: \(object.stargazers.totalCount)"
        
        let imageString = object.owner.avatarUrl
        if let url = URL(string: imageString) {
            let request = URLRequest(url: url)
            cell.avatarImageView.setImage(using: request)
        }
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            
        }
    }
    
    func createTwoColmnFlowLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(5.0), heightDimension: .fractionalHeight(5.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(64))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(190)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ViewController: ViewModelDelegate {
    func listLoadedSuccessfully() {
        self.gitRepoCollectionView.reloadData()
    }
    
    func encountered(_ error: Error) {
        print("Error error read all about it")
    }
    
    
}
