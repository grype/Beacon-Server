Trait {
	#name : #TBeaconRemoteSignal,
	#instVars : [
		'source'
	],
	#category : #'Beacon-Server-Signals'
}

{ #category : #printing }
TBeaconRemoteSignal >> printOn: aStream [
	self printSourceContentsOn: aStream.
	super printOn: aStream
]

{ #category : #printing }
TBeaconRemoteSignal >> printOneLineContentsOn: aStream [
	self printSourceContentsOn: aStream.
	super printOneLineContentsOn: aStream
]

{ #category : #printing }
TBeaconRemoteSignal >> printSourceContentsOn: aStream [
	self source
		ifNotNil: [ :src | 
			src printOn: aStream.
			aStream nextPut: Character space ]
]

{ #category : #accessing }
TBeaconRemoteSignal >> source [
	^ source
]

{ #category : #accessing }
TBeaconRemoteSignal >> source: anObject [
	source := anObject
]
