//
//  KeyValueObserver.swift
//  Postgres
//
//  Created by Chris on 19/08/2016.
//  Copyright © 2016 postgresapp. All rights reserved.
//

import Foundation

class KeyValueObserver: NSObject {
	
	class func observe(_ object: NSObject, keyPath: String, options: NSKeyValueObservingOptions, callback: (() -> Void)) -> KeyValueObserver {
		let observer = KeyValueObserver(object, keyPath, options, callback)
		object.addObserver(observer, forKeyPath: keyPath, options: options, context: nil)
		return observer
	}
	
	
	private let object: NSObject
	private let keyPath: String
	private let options: NSKeyValueObservingOptions
	private let callback: () -> Void
	
	private init(_ object: NSObject, _ keyPath: String, _ options: NSKeyValueObservingOptions, _ callback: (() -> Void)) {
		self.object = object
		self.keyPath = keyPath
		self.options = options
		self.callback = callback
	}
	
	deinit {
		object.removeObserver(self, forKeyPath: keyPath)
	}
	
	
	override func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [NSKeyValueChangeKey : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
		callback()
	}
	
	
}
