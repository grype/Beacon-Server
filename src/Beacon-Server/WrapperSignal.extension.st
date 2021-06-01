Extension { #name : #WrapperSignal }

{ #category : #'*Beacon-Server' }
WrapperSignal >> gtInspectorDisplayType [
	^ self target class name
]

{ #category : #'*Beacon-Server' }
WrapperSignal >> matches: aString [
	| query |

	query := aString asLowercase.
	^ (super matches: query)
		or: [ target isNotNil
				and: [ target asString asLowercase includesSubstring: query ] ]
]
