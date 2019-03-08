Trait {
	#name : #TBeaconRemoteCallStack,
	#instVars : [
		'stack'
	],
	#category : #'Beacon-Server-Signals'
}

{ #category : #'gt-inspector-extension' }
TBeaconRemoteCallStack >> gtInspectorCallGraphIn: composite [
	<gtInspectorPresentationOrder: 1>
	| frames |
	composite roassal2
		title: ['Call Graph' translated];
		initializeView: [ RTMondrian new ];
		painting: [ :view | 
			frames := self stack sorted: [ :a :b | a index > b index ].
			view shape label
				text:
					[ :each | (each module , '.' , each invocation) gtDisplayString ];
				color: [ Smalltalk ui theme textColor ].
			view nodes: frames.
			frames
				overlappingPairsDo: [ :a :b | view edges connectFrom: [ :x | b ] to: [ :x | a ] ].
			view layout tree ]
]

{ #category : #'gt-inspector-extension' }
TBeaconRemoteCallStack >> gtInspectorStackIn: composite [
	(self stack isNotNil
		and: [ self stack first isKindOf: RemoteCallStackFrame ])
		ifTrue: [  
			composite fastTable
			title: 'Stack' translated;
			display: [ self stack ];
			column: '#' translated evaluated: [ :val | val index ];
			column: 'Module' translated evaluated: [ :val | val module ];
			column: 'Address' translated evaluated: [ :val | (val address printStringRadix: 16) copyReplaceAll: '16r' with: '0x' ];
			column: 'Invocation' translated evaluated: [ :val | val invocation ]
			]
		ifFalse: [ composite fastList
				title: 'Stack' translated;
				display: [ self stack ] ]
]

{ #category : #accessing }
TBeaconRemoteCallStack >> stack [
	^ stack
]

{ #category : #accessing }
TBeaconRemoteCallStack >> stack: aStack [
	stack := aStack.
	(aStack isCollection and: [ aStack first isDictionary ]) ifFalse: [ ^ self ].
	stack := aStack collect: [ :each | RemoteCallStackFrame fromDictionary: each ]
]
