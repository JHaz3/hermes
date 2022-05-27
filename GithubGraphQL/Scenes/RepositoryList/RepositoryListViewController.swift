import UIKit
import SwiftUI

class RepositoryListViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupRepositoryListView()
  }

  private func setupRepositoryListView() {
    let viewModel = RepositoryListViewModel()
    let repositoryListView = RepositoryListView(viewModel: viewModel)
    let childViewController = UIHostingControllerWrapper(shouldShowNavigationBar: true, rootView: repositoryListView)
    let childView: UIView = childViewController.view
    addChild(childViewController)
    childViewController.didMove(toParent: self)
    view.addSubview(childView)
    childView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      childView.heightAnchor.constraint(equalTo: view.heightAnchor),
      childView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])
  }
}
