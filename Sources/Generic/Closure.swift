//
//  Closure.swift
//


/// A closure for compute value
public typealias Compute<Value> = () -> Value


/// A closure for available value
public typealias Available<Value> = (Value) -> Void
