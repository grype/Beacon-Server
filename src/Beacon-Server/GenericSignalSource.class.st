"
I am a generic representation of a text-based source of a remote beacon signal.

In addition to the properties provided by ==TBeaconRemoteSignalSource==, I encapsulate various properties such as module, file, line number and function name, often found in text-based logging facilities.

Instance Variables
	fileName:		<String>
	functionName:		<String>
	line:		<Number>
	module:		<String>
			
"
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

{ #category : #'gt-inspector-extension' }
GenericSignalSource >> gtInspectorDisplayString [
	| str |
	functionName ifNotNil: [ :val | ^ val ].
	fileName ifNotNil: [ :val | ^ '{1}:{2}' format: { val. line } ].
	str := '' writeStream.
	self printOneLineContentsOn: str.
	^ str contents truncateTo: 32
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
