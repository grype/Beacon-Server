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
		column: 'Process' evaluated: [ :each | each processId asString ];
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
	ds dotShape circle color: [ :each | n rtValue: each gtInspectorDisplayType ]; size: 10.
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
