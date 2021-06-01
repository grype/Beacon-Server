Extension { #name : #Collection }

{ #category : #'*Beacon-Server' }
Collection >> containsBeaconSignals [
	^ self isCollection
		and: [ self anySatisfy: [ :each | each isBeaconSignal ] ]
]

{ #category : #'*Beacon-Server' }
Collection >> gtInspectorCallEventsIn: composite [
	<gtInspectorPresentationOrder: 10>

	composite roassal2
		title: [ 'Call Events' translated ];
		when: [ self containsBeaconSignals ];
		initializeView: [ MemoryLogger gtCallEventsOn: (self select: #isRemoteBeaconSignal) ]
]

{ #category : #'*Beacon-Server' }
Collection >> gtInspectorTimeline: composite [
	<gtInspectorPresentationOrder: 3>

	composite roassal2
		title: [ 'Timeline' translated ];
		when: [ self containsBeaconSignals ];
		initializeView: [ MemoryLogger gtTimelineOn: (self select: #isBeaconSignal) ]
]
