Trait {
	#name : #TBeaconRemoteSignal,
	#instVars : [
		'source',
		'userInfo'
	],
	#category : #'Beacon-Server-Signals'
}

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
	^ source identifier asString
]

{ #category : #accessing }
TBeaconRemoteSignal >> source [
	^ source
]

{ #category : #accessing }
TBeaconRemoteSignal >> source: anObject [
	source := anObject
]

{ #category : #accessing }
TBeaconRemoteSignal >> userInfo [
	^ userInfo
]

{ #category : #accessing }
TBeaconRemoteSignal >> userInfo: anObject [
	userInfo := anObject
]
