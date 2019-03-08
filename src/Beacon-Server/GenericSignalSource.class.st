Class {
	#name : #GenericSignalSource,
	#superclass : #Object,
	#traits : 'TBeaconRemoteSignalSource + TBeaconMaterializing',
	#classTraits : 'TBeaconRemoteSignalSource classTrait + TBeaconMaterializing classTrait',
	#instVars : [
		'module',
		'fileName',
		'line',
		'functionName'
	],
	#category : #'Beacon-Server-Server'
}

{ #category : #accessing }
GenericSignalSource >> fileName [
	^ fileName
]

{ #category : #accessing }
GenericSignalSource >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
GenericSignalSource >> functionName [
	^ functionName
]

{ #category : #accessing }
GenericSignalSource >> functionName: anObject [
	functionName := anObject
]

{ #category : #accessing }
GenericSignalSource >> line [
	^ line
]

{ #category : #accessing }
GenericSignalSource >> line: anObject [
	line := anObject
]

{ #category : #accessing }
GenericSignalSource >> module [
	^ module
]

{ #category : #accessing }
GenericSignalSource >> module: anObject [
	module := anObject
]

{ #category : #printing }
GenericSignalSource >> printOn: aStream [
	self identifier
		ifNotNil: [ :val | 
			aStream
				nextPutAll: val greaseString;
				nextPut: Character space ].
	aStream
		nextPut: $[;
		nextPutAll: module;
		nextPut: $.;
		nextPutAll: fileName;
		nextPut: $:;
		nextPutAll: line greaseString;
		nextPut: $];
		nextPut: Character space;
		nextPutAll: functionName
]
