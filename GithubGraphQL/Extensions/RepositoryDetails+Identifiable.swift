//
//  RepositoryDetails+Identifiable.swift
//  GithubGraphQL
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import Foundation

extension RepositoryDetails: Identifiable, Equatable {
  public static func == (lhs: RepositoryDetails, rhs: RepositoryDetails) -> Bool {
    return lhs.owner.login == rhs.owner.login && lhs.url == rhs.url
  }

  public var id: String {
    return url
  }
}
