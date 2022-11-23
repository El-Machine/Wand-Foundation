//  Copyright (c) 2020-2021 El Machine (http://el-machine.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Alex Kozin
//  2020 El Machine
//

import Pipe
import XCTest

class URL_JSONObject_Tests: XCTestCase {

    @available(iOS 16.0, *)
    func test_URL_Array() {
        let e = expectation()

        let q = URLQueryItem(name: "q", value: "swift")

        var url = URL(string: "https://api.github.com/repositories")!
        url.append(queryItems: [q])

        url | { (array: [Any]) in

            if !array.isEmpty {
                e.fulfill()
            }

        }

        waitForExpectations()
    }

    func test_URL_Dictionary() {
        let e = expectation()

        //(1...42).any
        //Don't use random, because some repos is already 🧟‍♀️
        let id: Int = 42

        var url = URL(string: "https://api.github.com/repositories")!

        if #available(iOS 16.0, *) {
            url.append(path: String(describing: id))
        } else {
            url.appendPathComponent(String(describing: id))
        }

        url | { (dictionary: [String: Any]) in

            if dictionary["id"] as? Int == id {
                e.fulfill()
            }

        }

        waitForExpectations()
    }



}