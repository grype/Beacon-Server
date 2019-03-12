Extension { #name : #RemoteContextStackSignal }

{ #category : #'*Beacon-Server' }
RemoteContextStackSignal >> gtInspectorDisplayType [
	^ self source ifNil: [ super gtInspectorDisplayType ] ifNotNil: [ :val | val gtInspectorDisplayString ]
]
