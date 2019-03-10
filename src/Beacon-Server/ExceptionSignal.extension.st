Extension { #name : #ExceptionSignal }

{ #category : #'*Beacon-Server' }
ExceptionSignal >> gtInspectorDisplayType [
	^ self error class
]
