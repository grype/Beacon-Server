Class {
	#name : #BeaconServerTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'remoteIdentifier',
		'remoteModule'
	],
	#category : #'Beacon-Server-Tests'
}

{ #category : #tests }
BeaconServerTest >> createGenericSourceData [
	^ Dictionary new
		at: #identifier put: remoteIdentifier;
		at: #module put: remoteModule;
		at: #fileName put: 'test.c';
		at: #line put: 123;
		at: #functionName put: 'main';
		yourself
]

{ #category : #tests }
BeaconServerTest >> createRemoteContextSignalData [
	^ Dictionary new
		at: #'__class' put: RemoteContextStackSignal name;
		at: #stack put: self createRemoteStackData;
		at: #source put: self createGenericSourceData;
		yourself
]

{ #category : #tests }
BeaconServerTest >> createRemoteStackData [
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
BeaconServerTest >> setUp [
	super setUp.
	server := BeaconServer new.
	remoteIdentifier := Smalltalk image shortImageName.
	remoteModule := self class packages anyOne name.
]

{ #category : #running }
BeaconServerTest >> tearDown [ 
	super tearDown.
	server stop
]

{ #category : #tests }
BeaconServerTest >> testInitialization [
	server isRunning should not be
]

{ #category : #tests }
BeaconServerTest >> testSignalFromData [
	| data signal |

	data := self createRemoteContextSignalData.
	signal := server signalFromData: data.
	signal should not be: nil.
	signal class should be: RemoteContextStackSignal.
	signal source should not be: nil.
	signal source class should be: GenericSignalSource.
	signal stack should not be: nil.
	signal stack size should equal: (data at: #stack) size.
	signal stack first class should equal: RemoteCallStackFrame
]

{ #category : #tests }
BeaconServerTest >> testSourceFromData [
	| source sourceData |

	sourceData := self createGenericSourceData.
	source := server
		sourceFromData:
			(Dictionary new
				at: #source put: sourceData;
				yourself).
	source class should be: GenericSignalSource.
	#(#identifier #module #fileName #line #functionName)
		do:
			[ :selector | (source perform: selector) should equal: (sourceData at: selector) ]
]

{ #category : #tests }
BeaconServerTest >> testStartOn [
	server startOn: 9999.
	server isRunning should be.
]

{ #category : #tests }
BeaconServerTest >> testStop [
	server startOn: 9999.
	server stop.
	server isRunning should not be
]
