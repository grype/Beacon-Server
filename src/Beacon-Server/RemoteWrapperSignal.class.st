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

{ #category : #'gt-inspector-extension' }
RemoteWrapperSignal >> gtSignalDesriptionIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite text
		title: [ 'Signal' translated ];
		display: [ self description ]
]

{ #category : #testing }
RemoteWrapperSignal >> isRemoteBeaconSignalOfType: aTypeName [
	^ self targetType = aTypeName
]

{ #category : #accessing }
RemoteWrapperSignal >> name [
	^ 'Remote Wrapper on '
		,
			(targetType ifNil: [ self target class name ] ifNotNil: [ :val | val ])
]

{ #category : #printing }
RemoteWrapperSignal >> printOneLineContentsOn: aStream [
	aStream
		nextPutAll:
			(self description isEmptyOrNil
				ifTrue: [ self target asString ]
				ifFalse: [ self description lineNumber: 1 ])
]

{ #category : #accessing }
RemoteWrapperSignal >> remoteBeaconType [ 
	^ targetType 
]

{ #category : #testing }
RemoteWrapperSignal >> remoteDataMatches: aString [
	^ ((self remoteDescriptionMatches: aString)
		or: [ self remoteTargetTypeMatches: aString ])
		or: [ self remoteSourceMatches: aString ]
]

{ #category : #testing }
RemoteWrapperSignal >> remoteTargetTypeMatches: aString [
	^ targetType isNotNil
		and: [ targetType asString includesSubstring: aString ]
]

{ #category : #accessing }
RemoteWrapperSignal >> targetType [
	^ targetType
]

{ #category : #accessing }
RemoteWrapperSignal >> targetType: anObject [
	targetType := anObject
]
