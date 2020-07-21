//
//  Cache.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import Foundation

public final class Cache<Key: Hashable, Value> {
    private let nsCache = NSCache<WrappedKey, Entry>()
    private let keyManager = KeyManager()
    
    private var entryLifetime: TimeInterval? = nil
    
    public init(maxEntryCount: Int = 250, entryLifetime: TimeInterval? = nil) {
        nsCache.countLimit = maxEntryCount
        self.entryLifetime = entryLifetime
        nsCache.delegate = keyManager
    }
    
    public func insert(_ value: Value, forKey key: Key) {
        var expirationDate: Date?
        
        if let entryLifetime = entryLifetime {
            expirationDate = Date().addingTimeInterval(entryLifetime)
        }
        
        let entry = Entry(key: key, value: value, expirationDate: expirationDate)
        setEntry(entry, forKey: key)
    }
    
    public func insert(_ entry: Entry) {
        setEntry(entry, forKey: entry.key)
    }
    
    public func setEntry(_ entry: Entry, forKey key: Key) {
        nsCache.setObject(entry, forKey: WrappedKey(key))
        keyManager.keys.insert(key)
    }
    
    public func removeValue(forKey key: Key) {
        nsCache.removeObject(forKey: WrappedKey(key))
        keyManager.keys.remove(key)
    }
    
    public func value(_ key: Key) -> Value? {
        return entry(forKey: key)?.value
    }
    
    public subscript (key: Key) -> Value? {
        get { return value(key) }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
    
    public func totalStoredKeys() -> Int {
        return keyManager.keys.count
    }
    
    public func allStoredKeys() {
        print(keyManager.keys)
    }
}

private extension Cache {
    func entry(forKey key: Key) -> Entry? {
        guard let entry = nsCache.object(forKey: WrappedKey(key)) else {
            return nil
        }
        
        guard !entry.hasExpired else {
            removeValue(forKey: key)
            return nil
        }
        
        return entry
    }
}

extension Cache {
    public final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date?
        
        var hasExpired: Bool {
            guard let expirationDate = expirationDate else {
                return false
            }
            
            return Date() >= expirationDate
        }
        
        init(key: Key, value: Value, expirationDate: Date?) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) { self.key = key }
        
        override var hash: Int { return key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else { return false }
            return value.key == key
        }
    }
    
    final class KeyManager: NSObject, NSCacheDelegate {
        var keys =  Set<Key>()
        
        func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
            guard let entry = obj as? Entry else {
                return
            }
            
            keys.remove(entry.key)
        }
    }
}

extension Cache.Entry: Codable where Key: Codable, Value: Codable {}

extension Cache: Codable where Key: Codable, Value: Codable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.filter { !$0.hasExpired }.forEach(insert)
    }
    
    public func encode(to encoder: Encoder) throws {
        let currentEntries = keyManager.keys.compactMap(entry).filter { !$0.hasExpired }
        var container = encoder.singleValueContainer()
        try container.encode(currentEntries)
    }
    
    public func saveToDisk(withName name: String, fileManager: FileManager = .default) -> Result<Void, Error> {
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent(name + ".cache")
        
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: fileURL)
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}

