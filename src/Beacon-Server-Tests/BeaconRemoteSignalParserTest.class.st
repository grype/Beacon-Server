Class {
	#name : #BeaconRemoteSignalParserTest,
	#superclass : #TestCase,
	#instVars : [
		'remoteModule',
		'remoteIdentifier',
		'parser'
	],
	#category : #'Beacon-Server-Tests'
}

{ #category : #private }
BeaconRemoteSignalParserTest >> createGenericSourceData [
	^ Dictionary new
		at: #identifier put: remoteIdentifier;
		at: #module put: remoteModule;
		at: #fileName put: 'test.c';
		at: #line put: 123;
		at: #functionName put: 'main';
		yourself
]

{ #category : #private }
BeaconRemoteSignalParserTest >> createRemoteContextSignalData [
	^ Dictionary new
		at: #'__class' put: RemoteContextStackSignal name;
		at: #stack put: self createRemoteStackData;
		at: #source put: self createGenericSourceData;
		yourself
]

{ #category : #private }
BeaconRemoteSignalParserTest >> createRemoteStackData [
	^ {{(#index -> 0).
	(#module -> remoteModule).
	(#address -> 1).
	(#invocation -> 'this')} asDictionary.
	{(#index -> 1).
	(#module -> remoteModule).
	(#address -> 1).
	(#invocation -> 'previous')} asDictionary}
]

{ #category : #running }
BeaconRemoteSignalParserTest >> setUp [

	super setUp.

	remoteIdentifier := Smalltalk image shortImageName.
	remoteModule := self class packages anyOne name.
	parser := BeaconRemoteSignalParser new
]

{ #category : #tests }
BeaconRemoteSignalParserTest >> testSignalFromData [
	| data signal |

	data := self createRemoteContextSignalData.
	signal := parser signalFromData: data.
	signal should not be: nil.
	signal class should be: RemoteContextStackSignal.
	signal source should not be: nil.
	signal source class should be: GenericSignalSource.
	signal stack should not be: nil.
	signal stack size should equal: (data at: #stack) size.
	signal stack first class should equal: RemoteCallStackFrame
]

{ #category : #tests }
BeaconRemoteSignalParserTest >> testSourceFromData [
	| source sourceData |

	sourceData := self createGenericSourceData.
	source := parser
		sourceFromData:
			(Dictionary new
				at: #source put: sourceData;
				yourself).
	source class should be: GenericSignalSource.
	#(#identifier #module #fileName #line #functionName)
		do:
			[ :selector | (source perform: selector) should equal: (sourceData at: selector) ]
]
