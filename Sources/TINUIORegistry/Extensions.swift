/*
 TINUNotifications: A Swift library to access information from the IORegistry in a Swift-friendly easy-to-use way.
 Copyright (C) 2022 Pietro Caruso

 This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

 This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

 You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

import Foundation

//#if os(macOS) || targetEnvironment(macCatalyst)

import IOKit

public extension io_registry_entry_t{
    ///Returns the registry path of the current entry
    func getPath(relativeTo plane: IOPlane) -> String?{
        return MemoryManagement.getString(bufferSize: 1024, { cString in
            return IORegistryEntryGetPath(self, plane.iOKitName, cString) == kIOReturnSuccess
        })
    }
    
    ///Returns a new entry instance referencing the parent entry to the current one
    func getParentEntry(relativeTo plane: IOPlane) -> Self?{
        var entry: io_registry_entry_t = 0
        
        if IORegistryEntryGetParentEntry(self, plane.iOKitName, &entry) != kIOReturnSuccess{
            return nil
        }
        
        return entry
    }
    
    ///Returns a new entry instance referencing the first child entry of the current entry (if applicable)
    func getFirstChildEntry(relativeTo plane: IOPlane) -> Self?{
        var entry: io_registry_entry_t = 0
        
        if IORegistryEntryGetChildEntry(self, plane.iOKitName, &entry) != kIOReturnSuccess{
            return nil
        }
        
        return entry
    }
}

//#endif
