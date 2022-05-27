//
//  RepositoryListView.swift
//  GithubGraphQL
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI

struct RepositoryListView: View {
  @ObservedObject var viewModel: RepositoryListViewModel

  var body: some View {
    VStack(spacing: 15) {
      SearchBar(placeHolder: "Search".localized, text: $viewModel.phrase) {
        viewModel.refresh()
      }
      .frame(maxHeight: 50)
      .background(Color.pink)
      if let disclaimer = viewModel.disclaimer {
        DisclaimerView(disclaimer: disclaimer)
          .accessibilityElement()
          .accessibilityIdentifier("RepositoryListViewDisclaimerScreen")
          .padding()
      } else {
        List(viewModel.values) { value in
          RepositoryRow(value: value)
            .accessibilityElement()
            .accessibilityIdentifier("RepositoryRow")
            .padding()
            .onAppear {
              self.viewModel.fetch(lastValue: value)
            }
        }
        .listStyle(.plain)
        .inMemoryImagesStored(cache: viewModel.imageCache)
      }
    }    
  }
}
