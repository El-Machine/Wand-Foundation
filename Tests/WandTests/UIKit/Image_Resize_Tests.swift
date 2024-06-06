///
/// Copyright © 2020-2024 El Machine 🤖
/// https://el-machine.com/
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
/// 1) LICENSE file
/// 2) https://apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// 2020 El Machine

#if canImport(UIKit)
import UIKit.UIImage

import Any_
import WandFoundation
import Wand

import XCTest

final
class Image_Resize_Tests: ImageTestCase {

    private
    let dimension: CGFloat = CGFloat((Int.random(in: 10...555)))

    private
    lazy
    var size = CGSize(width: dimension, height: dimension)

    override
    func setUpWithError() throws {
        guard image == nil else {
            return
        }
    }

    func test_Image_Fill() {
        let e = expectation()

        let calculated =  round( inSize.width / (inSize.height / dimension) )

        image | .fill(to: size) { (out: UIImage) in

            let size = out.size
            if
                round(size.height).isEqual(to: self.dimension),
                round(size.width).isEqual(to: calculated)
            {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    func test_Image_Fit() {
        let e = expectation()
print("ddd: %i", dimension)
        let calculated = round( inSize.height / (inSize.width / dimension) )

        image | .fit(to: size) { (out: UIImage) in

            let size = out.size

            if
                round(size.width).isEqual(to: self.dimension),
                round(size.height).isEqual(to: calculated)
            {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    func test_Image_Scale() {
        let e = expectation()

        let d = dimension

        image | .scale(to: size) { (scaled: UIImage) in

            let size = scaled.size
            if size.width == d && size.height == d {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

}

#endif
