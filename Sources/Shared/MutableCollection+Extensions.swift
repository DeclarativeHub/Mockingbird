//
//  MutableCollection+Extensions.swift
//  Mockingbird
//
//  Created by Srdan Rasic on 24/11/2019.
//

extension MutableCollection {

   mutating func mutableForEach(_ body: (inout Element) throws -> ()) rethrows {
       for index in indices {
           try body(&self[index])
       }
   }
}
