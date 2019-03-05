Trait {
	#name : #TBeaconRemoteSignal,
	#instVars : [
		'source'
	],
	#category : #'Beacon-Server-Signals'
}

{ #category : #accessing }
TBeaconRemoteSignal >> source [
	^ source
]

{ #category : #accessing }
TBeaconRemoteSignal >> source: anObject [
	source := anObject
]
