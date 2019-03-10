Extension { #name : #MemoryLogger }

{ #category : #'*Beacon-Server' }
MemoryLogger >> gtInspectorGroupedByProcessIn: composite [
	<gtInspectorPresentationOrder: 1>
	composite fastTable 
		title: 'By Process';
		display: [ (self recordings reverse groupedBy: [ :each | each processId ]) associations ];
		column: 'Process Id' evaluated: [ :each | each key ];
		column: 'Instances' evaluated: [ :each | each value size ];
		send: [ :each | each value ]
]

{ #category : #'*Beacon-Server' }
MemoryLogger >> gtInspectorTimeline: composite [
	<gtInspectorPresentationOrder: 1>
	| b ds n group dates |

	composite roassal2
		title: [ 'Timeline' translated ];
		when: [ self recordings isNotEmpty ];
		updateOn: Announcement from: [ self announcer ];
		initializeView: [ b := RTGrapher new.
			b extent: 300 @ 200.

			group := self recordings groupedBy: #gtInspectorDisplayType.
			dates := (self recordings collect: #timestamp) asSet
				sorted: [ :x :y | x < y ].

			n := RTMultiLinearColorForIdentity new.
			n colors: RTPalette c4 shuffle.
			n objects: group keys.

			ds := RTData new.
			ds interaction popupText: [ :aSignal | aSignal printString ].
			ds dotShape circle color: [ :each | n rtValue: each gtInspectorDisplayType ].
			ds points: self recordings.
			ds x: [ :each | dates indexOf: each timestamp ].
			ds y: [ :each | group keys indexOf: each gtInspectorDisplayType ].
			b add: ds.

			b axisY
				numberOfTicks: (group keys size max: 2);
				labelRotation: -30;
				labelConversion: [ :each | 
					each = 0
						ifTrue: [ '' ]
						ifFalse: [ group keys at: each ] ].

			b axisX
				numberOfTicks: dates size;
				labelRotation: -30;
				labelConversion: [ :i | 
					0 = i 
						ifTrue: [ '' ]
						ifFalse: [ (dates at: i) asString ] ].

			b build.
			b view ]
]
