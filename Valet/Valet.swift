//
//  Valet.swift
//  Valet
//
//  Created by Eric Muller on 6/20/16.
//  Copyright © 2016 Square, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


public struct Valet
{
    public enum Accessibility
    {
        case WhenUnlocked
        case AfterFirstUnlock
        case Always
        @available(iOS 8.0, OSX 10.10, *)
        case WhenPasscodeSetThisDeviceOnly
        case WhenUnlockedThisDeviceOnly
        case AfterFirstUnlockThisDeviceOnly
        case AlwaysThisDeviceOnly
    }

    public let accessibility: Accessibility
    public let identifier: String

    let backingValet: VALValet

    // MARK: Initializers

    public init(available: Accessibility, withIdentifier identifier: String)
    {
        precondition(!identifier.isEmpty)
        backingValet = VALValet(identifier: identifier, accessibility: available.backing())!
        accessibility = available
        self.identifier = identifier
    }

    public init(available: Accessibility, withSharedIdentifier sharedIdentifier: String)
    {
        precondition(!sharedIdentifier.isEmpty)
        backingValet = VALValet(sharedAccessGroupIdentifier: sharedIdentifier, accessibility: available.backing())!
        accessibility = available
        identifier = sharedIdentifier
    }

    // MARK: Keychain Access

    public func canAccessKeychain() -> Bool
    {
        return backingValet.canAccessKeychain()
    }

    public func contains(key: String) -> Bool
    {
        return backingValet.containsObjectForKey(key)
    }

    public func allKeys() -> Set<String>
    {
        return backingValet.allKeys()
    }

    // MARK: Setters

    public func set(string: String, forKey key: String) -> Bool
    {
        return backingValet.setString(string, forKey: key)
    }

    public func set(object: NSData, forKey key: String) -> Bool
    {
        return backingValet.setObject(object, forKey: key)
    }

    // MARK: Getters

    public func get(key: String) -> String?
    {
        return backingValet.stringForKey(key)
    }

    public func get(key: String) -> NSData?
    {
        return backingValet.objectForKey(key)
    }

    // MARK: Removal

    public func remove(key: String) -> Bool
    {
        return backingValet.removeObjectForKey(key)
    }

    public func removeAll() -> Bool
    {
        return backingValet.removeAllObjects()
    }

    // TODO: Migration

    public enum MigrationResult
    {
        case Success
        case Failure(FailureReason)
        public enum FailureReason: ErrorType
        {
            case InvalidQuery
            case NoItemsToMigrateFound
            case CouldNotReadKeychain
            case KeyInQueryResultInvalid
            case DataInQueryResultInvalid
            case DuplicateKeyInQueryResult
            case KeyInQueryResultAlreadyExistsInValet
            case CouldNotWriteToKeychain
            case RemovalFailed
            case NotYetImplementedLol
        }
    }

    public func migrate(_: Valet, removeOnSuccess remove: Bool) -> MigrationResult
    {
        return .Failure(.NotYetImplementedLol)
    }

    public func migrate(secItemQuery: [String: AnyObject], removeOnSuccess remove: Bool) -> MigrationResult
    {
        return .Failure(.NotYetImplementedLol)
    }
}


extension Valet: Equatable {}

public func ==(lhs: Valet, rhs: Valet) -> Bool
{
    return lhs.backingValet.isEqualToValet(rhs.backingValet)
}


extension Valet.Accessibility
{
    func backing() -> VALAccessibility
    {
        switch self {
        case .WhenUnlocked:
            return VALAccessibility.WhenUnlocked
        case .AfterFirstUnlock:
            return VALAccessibility.AfterFirstUnlock
        case .Always:
            return VALAccessibility.Always
        case .WhenPasscodeSetThisDeviceOnly:
            return VALAccessibility.WhenPasscodeSetThisDeviceOnly
        case .WhenUnlockedThisDeviceOnly:
            return VALAccessibility.WhenUnlockedThisDeviceOnly
        case .AfterFirstUnlockThisDeviceOnly:
            return VALAccessibility.AfterFirstUnlockThisDeviceOnly
        case .AlwaysThisDeviceOnly:
            return VALAccessibility.AlwaysThisDeviceOnly
        }
    }
}
