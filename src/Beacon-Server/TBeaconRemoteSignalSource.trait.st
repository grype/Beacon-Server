Trait {
	#name : #TBeaconRemoteSignalSource,
	#instVars : [
		'identifier'
	],
	#category : #'Beacon-Server-Server'
}

{ #category : #accessing }
TBeaconRemoteSignalSource >> identifier [
	^ identifier
]

{ #category : #accessing }
TBeaconRemoteSignalSource >> identifier: anObject [
	identifier := anObject
]
