Class {
	#name : #RemoteImportsSignal,
	#superclass : #BeaconSignal,
	#traits : 'TBeaconRemoteSignal + TBeaconMaterializing',
	#classTraits : 'TBeaconRemoteSignal classTrait + TBeaconMaterializing classTrait',
	#instVars : [
		'added',
		'removed'
	],
	#category : #'Beacon-Server-Signals'
}

{ #category : #accessing }
RemoteImportsSignal >> added [
	^ added
]

{ #category : #accessing }
RemoteImportsSignal >> added: anObject [
	added := anObject
]

{ #category : #'*Beacon-Server' }
RemoteImportsSignal >> isRemoteImportsSignal [
	^ true
]

{ #category : #accessing }
RemoteImportsSignal >> printOneLineContentsOn: stream [
	added
		ifNotNil: [ :imports | 
			stream
				nextPutAll: '+';
				nextPutAll: imports size asString ].
	removed
		ifNotNil: [ :imports | 
			added ifNotNil: [ stream nextPutAll: '/' ].
			stream
				nextPutAll: '-';
				nextPutAll: imports size asString ]
]

{ #category : #accessing }
RemoteImportsSignal >> removed [
	^ removed
]

{ #category : #accessing }
RemoteImportsSignal >> removed: anObject [
	removed := anObject
]
