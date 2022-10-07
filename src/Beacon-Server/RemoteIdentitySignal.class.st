Class {
	#name : #RemoteIdentitySignal,
	#superclass : #BeaconSignal,
	#traits : 'TBeaconRemoteSignal + TBeaconMaterializing',
	#classTraits : 'TBeaconRemoteSignal classTrait + TBeaconMaterializing classTrait',
	#instVars : [
		'version',
		'info'
	],
	#category : #'Beacon-Server-Signals'
}

{ #category : #accessing }
RemoteIdentitySignal >> info [
	^ info
]

{ #category : #accessing }
RemoteIdentitySignal >> info: anObject [
	info := anObject
]

{ #category : #'*Beacon-Server' }
RemoteIdentitySignal >> isRemoteIdentitySignal [
	^ true
]

{ #category : #accessing }
RemoteIdentitySignal >> printOneLineContentsOn: stream [
	version
		ifNotNil: [ :v | 
			stream
				nextPutAll: 'Beacon/';
				nextPutAll: v asString ].
	info
		ifNotNil: [ :i | 
			stream
				nextPut: $(;
				nextPutAll: i asString;
				nextPut: $) ]
]

{ #category : #accessing }
RemoteIdentitySignal >> version [
	^ version
]

{ #category : #accessing }
RemoteIdentitySignal >> version: anObject [
	version := anObject
]
