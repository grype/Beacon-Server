Extension { #name : #BeaconSignal }

{ #category : #'*Beacon-Server' }
BeaconSignal >> gtInspectorDisplayType [
	^ self class name
]

{ #category : #'*Beacon-Server' }
BeaconSignal >> isBeaconSignal [
	^ true
]

{ #category : #'*Beacon-Server' }
BeaconSignal >> isRemoteBeaconSignal [
	^ false
]

{ #category : #'*Beacon-Server' }
BeaconSignal >> matches: aString [
	^ self name asLowercase includesSubstring: aString asLowercase 
]

{ #category : #'*Beacon-Server' }
BeaconSignal >> properties: anObject [
	properties := anObject
]

{ #category : #'*Beacon-Server' }
BeaconSignal >> timestamp: aDateAndTime [
	timestamp := aDateAndTime isString ifTrue: [ DateAndTime fromString: aDateAndTime ] ifFalse: [ aDateAndTime ]
]
