Trait {
	#name : #TBeaconRemoteSignal,
	#instVars : [
		'source',
		'description',
		'debugDescription'
	],
	#category : #'Beacon-Server-Signals'
}

{ #category : #accessing }
TBeaconRemoteSignal >> debugDescription [
	^ debugDescription
]

{ #category : #accessing }
TBeaconRemoteSignal >> debugDescription: anObject [
	debugDescription := anObject
]

{ #category : #accessing }
TBeaconRemoteSignal >> description [
	^ description
]

{ #category : #accessing }
TBeaconRemoteSignal >> description: anObject [
	description := anObject
]

{ #category : #testing }
TBeaconRemoteSignal >> isRemoteBeaconSignal [ 
	^ true
]

{ #category : #testing }
TBeaconRemoteSignal >> matches: aString [
	^ (super matches: aString) or: [ self remoteDataMatches: aString ]
]

{ #category : #printing }
TBeaconRemoteSignal >> printOn: aStream [
	self printSourceContentsOn: aStream.
	super printOn: aStream
]

{ #category : #printing }
TBeaconRemoteSignal >> printSourceContentsOn: aStream [
	self source ifNotNil: [ :src | src printOn: aStream ]
]

{ #category : #accessing }
TBeaconRemoteSignal >> processId [
	^ source ifNotNil: [ :src | src identifier asString ]
]

{ #category : #testing }
TBeaconRemoteSignal >> remoteDataMatches: aString [
	^ (self remoteDescriptionMatches: aString)
		or: [ self remoteSourceMatches: aString ]
]

{ #category : #testing }
TBeaconRemoteSignal >> remoteDescriptionMatches: aString [
	^ {description.
	debugDescription}
		anySatisfy: [ :aDescription | 
			aDescription isNotNil
				and: [ aDescription asString includesSubstring: aString ] ]
]

{ #category : #testing }
TBeaconRemoteSignal >> remoteSourceMatches: aString [
	^ source isNotNil and: [ source asString includesSubstring: aString ]
]

{ #category : #accessing }
TBeaconRemoteSignal >> source [
	^ source
]

{ #category : #accessing }
TBeaconRemoteSignal >> source: anObject [
	source := anObject
]
