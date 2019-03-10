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
GenericSignalSource >> printFileDescriptionOn: aStream [
	(module isNil and: [ fileName isNil ])
		ifTrue: [ ^ self ].

	aStream nextPut: $[.
	module ifNotNil: [ :val | aStream nextPutAll: val ].
	fileName
		ifNotNil: [ :val | 
			module ifNotNil: [ aStream nextPut: $. ].
			aStream nextPutAll: fileName ].
	line
		ifNotNil: [ :val | 
			aStream
				nextPut: $:;
				nextPutAll: val greaseString ].
	aStream nextPut: $]
]

{ #category : #printing }
GenericSignalSource >> printFunctionDescriptionOn: aStream [
	self functionName
		ifNotNil: [ :val | 
			aStream
				nextPut: $#;
				nextPutAll: val;
				nextPut: $: ]
]

{ #category : #printing }
GenericSignalSource >> printIdentifierOn: aStream [
	self identifier
		ifNotNil: [ :val | aStream nextPutAll: val greaseString ]
]

{ #category : #printing }
GenericSignalSource >> printOn: aStream [
	| position advanced |

	position := aStream position.
	advanced := false.
	#(#printIdentifierOn: #printFileDescriptionOn: #printFunctionDescriptionOn:)
		do: [ :selector | 
			advanced
				ifTrue: [ aStream nextPut: Character space ].
			self perform: selector with: aStream ]
		separatedBy: [ advanced := aStream position ~= position.
			position := aStream position ]
]

{ #category : #printing }
GenericSignalSource >> printOneLineContentsOn: aStream [
	| position advanced |

	position := aStream position.
	advanced := false.
	#(#printFileDescriptionOn: #printFunctionDescriptionOn:)
		do: [ :selector | 
			advanced
				ifTrue: [ aStream nextPut: Character space ].
			self perform: selector with: aStream ]
		separatedBy: [ advanced := aStream position ~= position.
			position := aStream position ]
]
