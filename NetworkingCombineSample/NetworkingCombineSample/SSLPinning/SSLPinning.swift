//
//  ValidatorPolicy.swift
//  SSLPinning
//
//  Created by Balraj Verma on 12/11/20.
//  Copyright © 2020 Balraj Verma. All rights reserved.
//

import Foundation
import Alamofire



class SSLPinning {
    let session: Session
    private static let shared = SSLPinning()
    private static let sharedTest = TestEnvCertificate(systemBundle: "JsonPlaceHolder", typeOf: "cer", password: "")
    
    let evaluaccctors = [
      "jsonplaceholder.typicode.com":
        PinnedCertificatesTrustEvaluator(certificates: [certificate])]
    
    
    init() {
        let congig = URLSessionConfiguration.default
        session = Session(
            configuration: \
                congig,
            serverTrustManager: ServerTrustManager(evaluators:evaluaccctors)
        )
    }
    
    static let certificate = SSLPinning.certificate(filename: "JsonPlaceHolder")
    // Return certificate to validate with Host
    private static func certificate(filename: String) -> SecCertificate {
      let filePath = Bundle.main.path(forResource: filename, ofType: "cer")!
      let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
      let certificate = SecCertificateCreateWithData(nil, data as CFData)!
      return certificate
    }

  
    static func request(_ convertible: URLRequestConvertible, mTLSEnable: Bool = false) -> DataRequest {
        // shared.session.request(convertible)
        if mTLSEnable == true {
            return shared.session.request(convertible)
                .authenticate(with: sharedTest.urlCredential())
        }
        return shared.session.request(convertible)
           // .authenticate(with: sharedTest.urlCredential())
    }
}



