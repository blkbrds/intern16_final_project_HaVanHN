//
//  OptionalExt.swift
//  EateryTour
//
//  Created by NganHa on 9/28/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation

extension Optional {

  func unwrapped(or defaultValue: Wrapped) -> Wrapped {
    return self ?? defaultValue
  }

  func unwrapped(or error: Error) throws -> Wrapped {
    guard let wrapped = self else { throw error }
    return wrapped
  }
}
