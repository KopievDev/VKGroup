//
//  Dictionary.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import Foundation

extension Dictionary {
    subscript(a idx: Key) -> [Any?] {
        get {
            return self[idx] as? [Any?] ?? []
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(a0 idx: Key) -> [Any?]? {
        get {
            return self[idx] as? [Any?]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(ad idx: Key) -> [[String: Any]] {
        get {
            return self[idx] as? [[String: Any]] ?? []
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(ad0 idx: Key) -> [[String: Any]]? {
        get {
            return self[idx] as? [[String: Any]]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(i idx: Key) -> Int {
        get {
            return self[idx] as? Int ?? 0
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(i0 idx: Key) -> Int? {
        get {
            return self[idx] as? Int
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    
    subscript(b idx: Key) -> Bool {
        get {
            return self[idx] as? Bool ?? false
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(b0 idx: Key) -> Bool? {
        get {
            return self[idx] as? Bool
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(f idx: Key) -> Float {
        get {
            return self[idx] as? Float ?? Float(self[idx] as? Double ?? 0.0)
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(f0 idx: Key) -> Float? {
        get {
            if let res = self[idx] as? Float {
                return res
            }
            
            if let res = self[idx] as? Double {
                return Float(res)
            }
            return nil
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(s idx: Key) -> String {
        get {
            return self[idx] as? String ?? ""
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(s0 idx: Key) -> String? {
        get {
            return self[idx] as? String
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(d idx: Key) -> [String: Any] {
        get {
            return self[idx] as? [String: Any] ?? [:]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(d0 idx: Key) -> [String: Any]? {
        get {
            return self[idx] as? [String: Any]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
}
