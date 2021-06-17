Class {
	#name : #BeaconRemoteSignalParser,
	#superclass : #Object,
	#category : #'Beacon-Server-Server'
}

{ #category : #parsing }
BeaconRemoteSignalParser >> classEncodedInData: aDictionary [
	^ aDictionary
		at: #__class
		ifPresent: [ :cls | Smalltalk at: cls asSymbol ifAbsent: [ nil ] ]
		ifAbsent: [ nil ]
]

{ #category : #parsing }
BeaconRemoteSignalParser >> parse: data [
	^ self signalFromData: data
]

{ #category : #parsing }
BeaconRemoteSignalParser >> signalFromData: aSignalData [
	| signalClass signal |

	signalClass := (self classEncodedInData: aSignalData)
		ifNil: [ ^ nil ].
	(signalClass inheritsFrom: BeaconSignal)
		ifFalse: [ ^ nil ].

	signal := signalClass isBeaconMaterializable
		ifTrue: [ signalClass fromDictionary: aSignalData ]
		ifFalse: [ signalClass new ].

	signal isRemoteSignal
		ifFalse: [ ^ signal ].

	(self sourceFromData: aSignalData)
		ifNotNil: [ :source | signal source: source ].

	^ signal
]

{ #category : #parsing }
BeaconRemoteSignalParser >> sourceFromData: aSignalData [
	| sourceData sourceClass |

	sourceData := aSignalData at: #source ifAbsent: [ ^ nil ].
	sourceData ifNil: [ ^ nil ].
	sourceClass := (self classEncodedInData: sourceData)
		ifNil: [ GenericSignalSource ].
	sourceClass isBeaconRemoteSignalSource
		ifFalse: [ ^ nil ].
	^ sourceClass isBeaconMaterializable
		ifTrue: [ sourceClass fromDictionary: sourceData ]
		ifFalse: [ sourceClass new ]
]
