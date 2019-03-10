"
I encapsulate a remote signal wrapping an arbitrary value, similar to ==WrapperSignal==.
"
Class {
	#name : #RemoteWrapperSignal,
	#superclass : #WrapperSignal,
	#traits : 'TBeaconRemoteSignal + TBeaconMaterializing',
	#classTraits : 'TBeaconRemoteSignal classTrait + TBeaconMaterializing classTrait',
	#instVars : [
		'targetType'
	],
	#category : #'Beacon-Server-Signals'
}

{ #category : #'gt-inspector-extension' }
RemoteWrapperSignal >> gtInspectorDisplayType [
	^ self targetType
]

{ #category : #accessing }
RemoteWrapperSignal >> name [
	^ 'Remote Wrapper on '
		,
			(targetType ifNil: [ self target class name ] ifNotNil: [ :val | val ])
]

{ #category : #printing }
RemoteWrapperSignal >> printOneLineContentsOn: aStream [
	aStream nextPutAll: self target
]

{ #category : #accessing }
RemoteWrapperSignal >> targetType [
	^ targetType
]

{ #category : #accessing }
RemoteWrapperSignal >> targetType: anObject [
	targetType := anObject
]
