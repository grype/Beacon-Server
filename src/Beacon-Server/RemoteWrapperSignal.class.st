Class {
	#name : #RemoteWrapperSignal,
	#superclass : #WrapperSignal,
	#traits : 'TBeaconRemoteSignal',
	#classTraits : 'TBeaconRemoteSignal classTrait',
	#instVars : [
		'targetType'
	],
	#category : #'Beacon-Server-Signals'
}

{ #category : #accessing }
RemoteWrapperSignal >> name [
	^ 'Remote Wrapper on '
		,
			(targetType ifNil: [ self target class name ] ifNotNil: [ :val | val ])
]

{ #category : #printing }
RemoteWrapperSignal >> printOneLineContentsOn: stream [
	stream nextPutAll: self target
]

{ #category : #accessing }
RemoteWrapperSignal >> targetType [
	^ targetType
]

{ #category : #accessing }
RemoteWrapperSignal >> targetType: anObject [
	targetType := anObject
]
