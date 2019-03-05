Class {
	#name : #RemoteExceptionSignal,
	#superclass : #ExceptionSignal,
	#category : #'Beacon-Server-Signals'
}

{ #category : #'gt-inspector-extension' }
RemoteExceptionSignal >> gtInspectorStackIn: composite [
	composite fastList
		title: 'Stack';
		display: [ self stack ]
]
