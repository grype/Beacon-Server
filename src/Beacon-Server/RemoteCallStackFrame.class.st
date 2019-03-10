"
I am a generic representation of an execution stack frame.

I encapsulate various properties often found in stack frames: index, address, invocation...

I am used to capture stack traces transported via remote beacon signals.

Instance Variables
	address:		<Number> - Memory address
	index:		<Number>	- Frame index
	invocation:		<String> - Description of the invocation, e.g. function name + line number...
	module:		<String> - Identifier of a module per invocation, e.g. application or framework name

"
Class {
	#name : #RemoteCallStackFrame,
	#superclass : #Object,
	#traits : 'TBeaconMaterializing',
	#classTraits : 'TBeaconMaterializing classTrait',
	#instVars : [
		'index',
		'module',
		'address',
		'invocation'
	],
	#category : #'Beacon-Server-Server'
}

{ #category : #comparing }
RemoteCallStackFrame >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ index = anObject index and: [ address = anObject address ]
]

{ #category : #accessing }
RemoteCallStackFrame >> address [
	^ address
]

{ #category : #accessing }
RemoteCallStackFrame >> address: anObject [
	address := anObject
]

{ #category : #comparing }
RemoteCallStackFrame >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ index hash bitXor: address hash
]

{ #category : #accessing }
RemoteCallStackFrame >> index [
	^ index
]

{ #category : #accessing }
RemoteCallStackFrame >> index: anObject [
	index := anObject
]

{ #category : #accessing }
RemoteCallStackFrame >> invocation [
	^ invocation
]

{ #category : #accessing }
RemoteCallStackFrame >> invocation: anObject [
	invocation := anObject
]

{ #category : #accessing }
RemoteCallStackFrame >> module [
	^ module
]

{ #category : #accessing }
RemoteCallStackFrame >> module: anObject [
	module := anObject
]

{ #category : #printing }
RemoteCallStackFrame >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		print: index;
		nextPutAll: ' ';
		nextPutAll: module;
		nextPutAll: ' ';
		nextPutAll: ((address printStringRadix: 16) copyReplaceFrom: 1 to: 3 with: '0x');
		nextPutAll: ' ';
		nextPutAll: invocation
]
