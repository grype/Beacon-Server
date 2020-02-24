Extension { #name : #Collection }

{ #category : #'*Beacon-Server' }
Collection >> containsBeaconSignals [
	^ self anySatisfy: [ :each | each isBeaconSignal ]
]

{ #category : #'*Beacon-Server' }
Collection >> gtInspectorTimeline: composite [
	<gtInspectorPresentationOrder: 3>

	composite roassal2
		title: [ 'Timeline' translated ];
		when: [ self containsBeaconSignals ];
		initializeView: [ MemoryLogger gtTimelineOn: (self select: #isBeaconSignal) ]
]
