Extension { #name : #StringSignal }

{ #category : #'*Beacon-Server' }
StringSignal >> matches: aString [
	| query |

	query := aString asLowercase.
	^ (super matches: query)
		or: [ message isNotNil
				and: [ message asLowercase includesSubstring: query ] ]
]
