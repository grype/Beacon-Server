Extension { #name : #ThisContextSignal }

{ #category : #'*Beacon-Server' }
ThisContextSignal >> matches: aString [
	| query |

	query := aString asLowercase.
	^ (super matches: query)
		or: [ stack isNotNil
				and: [ stack
						anySatisfy: [ :frame | frame asString asLowercase includesSubstring: query ] ] ]
]
