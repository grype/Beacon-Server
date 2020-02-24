Extension { #name : #MemoryLogger }

{ #category : #'*Beacon-Server' }
MemoryLogger >> gtInspectorGroupedByProcessIn: composite [
	<gtInspectorPresentationOrder: 2>
	composite fastTable 
		title: 'By Process';
		display: [ (self recordings reverse groupedBy: [ :each | each processId ]) associations ];
		column: 'Process Id' evaluated: [ :each | each key ];
		column: 'Instances' evaluated: [ :each | each value size ];
		send: [ :each | each value ]
]

{ #category : #'*Beacon-Server' }
MemoryLogger >> gtInspectorTimeline: composite [
	<gtInspectorPresentationOrder: 3>

	composite roassal2
		title: [ 'Timeline' translated ];
		when: [ self recordings isNotEmpty ];
		updateOn: Announcement from: [ self announcer ];
		initializeView: [ self class gtTimelineOn: self recordings ]
]

{ #category : #'*Beacon-Server' }
MemoryLogger class >> gtTimelineOn: aCollectionOfSignals [
	| ratio width height group dates b n ds |

	group := aCollectionOfSignals groupedBy: #gtInspectorDisplayType.
	dates := (aCollectionOfSignals collect: #timestamp) asSet
		sorted: [ :x :y | x < y ].
	width := 150.
	height := 100.
	ratio := width / height.

	b := RTGrapher new.
	width := width * group keys size.
	height := width / ratio.
	b extent: width @ height.

	n := RTMultiLinearColorForIdentity new.
	n colors: RTPalette c4.
	"n objects: group keys."
	n
		objects: (aCollectionOfSignals collect: #gtInspectorDisplayType) asSet asOrderedCollection.

	ds := RTData new.
	ds interaction popupText: [ :aSignal | aSignal printString ].
	ds dotShape circle color: [ :each | n rtValue: each gtInspectorDisplayType ].
"	ds dotShape circle color: [ :each | n rtValue: each class ]."
	ds points: aCollectionOfSignals.
	ds x: [ :each | dates indexOf: each timestamp ].
	ds y: [ :each | group keys indexOf: each gtInspectorDisplayType ].
	b add: ds.

	b axisY
		numberOfTicks: group keys size + 1;
		labelRotation: -30;
		smallFontSize;
		labelConversion: [ :each | 
			each = 0
				ifTrue: [ '' ]
				ifFalse: [ group keys at: each ] ].

	b axisX
		numberOfTicks: dates size;
		smallFontSize;
		labelRotation: -30;
		labelConversion: [ :i | 
			0 = i
				ifTrue: [ '' ]
				ifFalse: [ (dates at: i) asString ] ].

	b build.
	^ b view
]
