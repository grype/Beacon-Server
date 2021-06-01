Extension { #name : #ExceptionSignal }

{ #category : #'*Beacon-Server' }
ExceptionSignal >> gtInspectorDisplayType [
	^ self error class
]

{ #category : #'*Beacon-Server' }
ExceptionSignal >> matches: aString [
	| query |

	query := aString asLowercase.
	^ (super matches: query)
		or: [ (exception isNotNil
				and: [ exception asLowercase includesSubstring: query ])
				or: [ stack isNotNil
						and: [ stack
								anySatisfy: [ :frame | frame asString asLowercase includesSubstring: query ] ] ] ]
]
