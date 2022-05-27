//
//  RepositoryRow.swift
//  GithubGraphQL
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI

struct RepositoryRow: View {
  let value: RepositoryDetails

  private let ownerUsernameFormat: String = "Owner: %@"

  var body: some View {
    HStack(spacing: 20) {
      SwiftUIImage(value.owner.avatarUrl) { image in
        image
          .resizable()
          .scaledToFit()
          .frame(width: 50, height: 50)
      }
      .clipShape(Circle())
      VStack(spacing: 10) {
        Text(value.name)
          .font(.headline)
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(String(format: ownerUsernameFormat, value.owner.login))
          .font(.subheadline)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}
