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
        @available(OSX 10.10, *)
        case WhenPasscodeSetThisDeviceOnly
        case WhenUnlockedThisDeviceOnly
        case AfterFirstUnlockThisDeviceOnly
        case AlwaysThisDeviceOnly

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

    let backingValet: VALValet?

    public init(available: Accessibility, withIdentifier: String)
    {
        backingValet = VALValet(identifier: withIdentifier, accessibility: available.backing())
    }

    public init(available: Accessibility, withSharedIdentifier: String)
    {
        backingValet = VALValet(sharedAccessGroupIdentifier: withSharedIdentifier, accessibility: available.backing())
    }
}

