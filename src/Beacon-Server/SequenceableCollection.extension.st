Extension { #name : #SequenceableCollection }

{ #category : #'*Beacon-Server' }
SequenceableCollection >> gtInspectorRemoteCallGraphIn: composite [
	<gtInspectorPresentationOrder: 1>
	| cls frames |
	composite roassal2
		title: [ 'Remote Call Graph' translated ];
		when: [ cls := self anyOne class.
			cls hasTraitComposition
				and: [ cls traitComposition allTraits includes: TBeaconRemoteCallStack ] ];
		initializeView: [ RTMondrian new ];
		painting: [ :view | 
			view shape label
				text: [ :each | (each module , '.' , each invocation) gtDisplayString ];
				color: [ Smalltalk ui theme textColor ].
			view nodes: (self flatCollect: #stack) asSet.
			self
				do: [ :aSignal | 
					frames := aSignal stack sorted: [ :a :b | a index > b index ].
					frames
						overlappingPairsDo: [ :a :b | view edges connectFrom: [ :x | b ] to: [ :x | a ] ] ].
			view layout tree ]
]
