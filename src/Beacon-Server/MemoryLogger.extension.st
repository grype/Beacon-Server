Extension { #name : #MemoryLogger }

{ #category : #'*Beacon-Server' }
MemoryLogger class >> gtCallEventsOn: aCollectionOfSignals [
	| analyzer builder isCallStateEvent isCallEvent isUpdateCallEvent |

	analyzer := CdSignalAnalyzer new.
	analyzer signals: aCollectionOfSignals.

	isCallStateEvent := [ :anEvent | 
	(anEvent isKindOf: RemoteWrapperSignal)
		and: [ anEvent targetType = 'UniversalCall' ] ].
	isCallEvent := [ :anEvent | 
	(anEvent isKindOf: RemoteWrapperSignal)
		and: [ anEvent targetType = 'CallEvent' ] ].
	isUpdateCallEvent := [ :anEvent | anEvent matches: 'updateServer(call:)' ].

	builder := CdEventBuilder new.
	builder
		displayNameForEvent: [ :anEvent | 
			(isCallStateEvent cull: anEvent)
				ifTrue: [ anEvent targetType ]
				ifFalse: [ anEvent source fileName asPath basename ] ].
	builder timeOfEvent: [ :anEvent | anEvent timestamp ].
	builder
		elementForEvent: [ :anEvent | 
			| container shape label text element |

			container := RTCompositeShape new.
			shape := RTEllipse new
				size: 20;
				color: Color white;
				yourself.
			(isCallEvent cull: anEvent)
				ifTrue: [ (anEvent target at: #isLocal)
						ifTrue: [ shape color: Color green ]
						ifFalse: [ shape color: Color red ] ]
				ifFalse: [ (isUpdateCallEvent cull: anEvent)
						ifTrue: [ shape color: Color yellow ]
						ifFalse: [ shape color: Color gray ] ].
			text := (isCallStateEvent cull: anEvent)
				ifTrue: [ anEvent target at: #state ]
				ifFalse: [ (isCallEvent cull: anEvent)
						ifTrue: [ anEvent target at: #type ]
						ifFalse: [ anEvent properties at: #status ] ].
			label := RTLabel new
				text: text;
				yourself.
			container
				add: shape;
				add: label;
				vertical.
			element := container elementOn: anEvent.
			element @ RTPopup.
			element ].
	builder events
		addAll:
			(OrderedCollection new
				addAll: analyzer callStateSignals;
				addAll: analyzer callEventSignals;
				addAll: analyzer callServerUpdateSignals;
				sorted: [ :a :b | a timestamp < b timestamp ]).
	^ builder
]

{ #category : #'*Beacon-Server' }
MemoryLogger >> gtInspectorCallEventsIn: composite [
	<gtInspectorPresentationOrder: 10>

	composite roassal2
		title: [ 'Call Events' translated ];
		when: [ (CdSignalAnalyzer new signals: recordings) callEventSignals isNotEmpty ];
		initializeView: [ MemoryLogger gtCallEventsOn: (recordings select: #isRemoteBeaconSignal) ]
]

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
MemoryLogger >> gtInspectorRecordingsIn: composite [
	<gtInspectorPresentationOrder: 0>
	| live |
	live := true.
	composite fastTable
		title: 'Recordings';
		display: [ self recordings reverse ];
		column: 'Timestamp'
			evaluated: [ :each | each timestamp asString ]
			width: 80;
		column: 'Process' evaluated: [ :each | each processId ifNotNil: [:pid | pid asString] ];
		column: 'Type' evaluated: [ :each | each name ] width: 80;
		column: 'Contents'
			evaluated:
				[ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ];
		showOnly: 50;
		beMultiple;
		updateOn: Announcement from: [ self announcer ];
		selectionAct: [ :table | 
			recordings := self recordings \ table selection.
			table update ]
			icon: GLMUIThemeExtraIcons glamorousRemove
			entitled: 'Remove';
		act: [ :table | 
			self reset.
			table update ]
			icon: GLMUIThemeExtraIcons glamorousRemove
			entitled: 'Remove all';
		selectionAct: [ :table | 
			(UIManager default
				chooseForSaveFileReference: 'Select output file'
				extensions: #(#ston)
				path: FileLocator home / 'recordings.ston')
				ifNotNil: [ :file | 
					(STONWriter on: file writeStream)
						nextPut: table selection;
						close ] ]
			icon: GLMUIThemeExtraIcons glamorousSave
			entitled: 'Save selected';
		act: [ :table | 
			(UIManager default
				chooseExistingFileReference: 'Select STON file'
				extensions: #(#ston)
				path: FileLocator home)
				ifNotNil: [ :file | 
					(STONReader on: file readStream) next
						ifNotNil: [ :newRecordings | 
							recordings
								addAll: (newRecordings sorted: [ :a :b | a timestamp < b timestamp ]) ] ] ]
			icon: GLMUIThemeExtraIcons glamorousOpen
			entitled: 'Load from file';
		dynamicActions: [ :t | 
			{(GLMGenericAction new
				action: [ t unregisterFromAllAnnouncements.
					t pane updateToolbar ];
				icon: GLMUIThemeExtraIcons glamorousRedCircle;
				title: 'Stop').
			(GLMGenericAction new
				action: [ t pane update ];
				icon: GLMUIThemeExtraIcons glamorousGreenCircle;
				title: 'Play')} ]
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
	| width height group analyzer b n ds |

	group := aCollectionOfSignals groupedBy: #gtInspectorDisplayType.
	analyzer := (aCollectionOfSignals collect: #timestamp) asSet
		sorted: [ :x :y | x < y ].
	width := 20.
	height := 25.

	b := RTGrapher new.
	width := width * analyzer size.
	height := height * group keys size.
	b extent: width @ height.

	n := RTMultiLinearColorForIdentity new.
	n colors: RTPalette c4.
	"n objects: group keys."
	n
		objects: (aCollectionOfSignals collect: #gtInspectorDisplayType) asSet asOrderedCollection.

	ds := RTData new.
	ds interaction popupText: [ :aSignal | aSignal printString ].
	ds dotShape circle color: [ :each | n rtValue: each gtInspectorDisplayType ]; size: 10.
"	ds dotShape circle color: [ :each | n rtValue: each class ]."
	ds points: aCollectionOfSignals.
	ds x: [ :each | analyzer indexOf: each timestamp ].
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
		numberOfTicks: analyzer size;
		smallFontSize;
		labelRotation: -30;
		labelConversion: [ :i | 
			0 = i
				ifTrue: [ '' ]
				ifFalse: [ (analyzer at: i) asString ] ].

	b build.
	^ b view
]

{ #category : #'*Beacon-Server' }
MemoryLogger >> selectFrom: fromBlock to: toBlock [
	| first last |
	first := fromBlock
		ifNil: [ recordings ]
		ifNotNil: [ recordings select: fromBlock ].
	first isEmptyOrNil
		ifTrue: [ ^ OrderedCollection new ].
	first := first minFor: #timestamp.

	last := toBlock
		ifNil: [ recordings ]
		ifNotNil: [ recordings select: toBlock ].
	last isEmptyOrNil
		ifTrue: [ ^ OrderedCollection with: first ].
	last := last maxFor: #timestamp.
	^ recordings
		select: [ :each | 
			each timestamp >= first timestamp
				and: [ each timestamp <= last timestamp ] ]
]
