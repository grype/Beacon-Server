Extension { #name : #SequenceableCollection }

{ #category : #'*Beacon-Server' }
SequenceableCollection >> gtInspectorCallGraphIn: composite [

	<gtInspectorPresentationOrder: 1>
	| frames |
	composite roassal2
		title: [ 'Call Graph' translated ];
		when: [ 
			self isCollection and: [ 
					self
						detect: [ :each | each isRemoteSignalWithStack ]
						ifFound: [ true ]
						ifNone: [ false ] ] ];
		initializeView: [ RTMondrian new ];
		painting: [ :view | 
			| stackedSignals |
			view shape label
				text: [ :each | 
					(each module , ' ' , each invocation) displayString ];
				color: [ Smalltalk ui theme textColor ].
			stackedSignals := self select: #isRemoteSignalWithStack.
			view nodes: (stackedSignals flatCollect: #stack) asSet.
			stackedSignals do: [ :aSignal | 
				frames := aSignal stack sorted: [ :a :b | a index > b index ].
				frames overlappingPairsDo: [ :a :b | 
					view edges connectFrom: [ :x | b ] to: [ :x | a ] ] ].
			view layout tree ]
]
