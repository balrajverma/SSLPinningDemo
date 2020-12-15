//
//  TestEnvCertificate.swift
//  NetworkingCombineSample
//
//  Created by Balraj Verma on 12/11/20.
//  Copyright © 2020 Balraj Verma. All rights reserved.
//

import Foundation
import Alamofire

class TestEnvCertificate {
    var label: String?
    var keyID: Data?
    var trust: SecTrust?
    var certChain: [SecTrust]?
    var identity: SecIdentity?
    var securityError: OSStatus?
    

    
    
    init(systemBundle: String, typeOf: String,  password: String) {
        let filePath = Bundle.main.path(forResource: systemBundle, ofType: typeOf)!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        
        var items: CFArray?
        let certOptions: NSDictionary = [kSecImportExportPassphrase as NSString: password as NSString]
        self.securityError = SecPKCS12Import(data as NSData, certOptions, &items)
        print(securityError)
        if securityError == errSecSuccess {
            let certiems: Array = (items! as Array)
            let dict: [String: AnyObject] = certiems.first! as! [String:AnyObject]
            self.label = dict[kSecImportItemLabel as String] as? String
            self.keyID = dict[kSecImportItemKeyID as String] as? Data
            self.trust = dict[kSecImportItemTrust as String] as! SecTrust
            self.certChain = dict[kSecImportItemCertChain as String] as? [SecTrust]
            self.identity = dict[kSecImportItemIdentity as String] as! SecIdentity
        }
    }
    
    func urlCredential() -> URLCredential {
    return URLCredential(identity: self.identity!, certificates: self.certChain!, persistence: URLCredential.Persistence.forSession)
    }
}
