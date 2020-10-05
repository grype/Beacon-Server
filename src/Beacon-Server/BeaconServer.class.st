"
I am a server for logging remote beacon signals.

I utilize JSON-RPC server for gathering remote signals in JSON format, materializing them into appropriate subclasses of BeaconSignal, and then emitting them.

To use me:

server := BeaconServer new.
server startOn: 4000. ""to start listening on port 4000""
server stop. ""to stop""

 
Instance Variables
	jrpcServer:		<JRPCServer>
"
Class {
	#name : #BeaconServer,
	#superclass : #Object,
	#instVars : [
		'jrpcServer'
	],
	#category : #'Beacon-Server-Server'
}

{ #category : #private }
BeaconServer class >> classEncodedInData: aDictionary [
	^ aDictionary
		at: #__class
		ifPresent: [ :cls | Smalltalk at: cls asSymbol ifAbsent: [ nil ] ]
		ifAbsent: [ nil ]
]

{ #category : #'event handling' }
BeaconServer >> handleEmittedData: aSignalData [
	| signal |
	
	signal := self signalFromData: aSignalData.
	signal emit
]

{ #category : #initialization }
BeaconServer >> initialize [
	super initialize.
	jrpcServer := JRPCServer http
		addHandlerNamed: 'emit'
			block: [ :signalData | 
				signalData do: [ :each | self handleEmittedData: each ] ];
		yourself
]

{ #category : #testing }
BeaconServer >> isRunning [ 
	^ jrpcServer isRunning 
]

{ #category : #private }
BeaconServer >> signalFromData: aSignalData [
	| signalClass signal source |

	signalClass := (self class classEncodedInData: aSignalData)
		ifNil: [ ^ nil ].
	(signalClass inheritsFrom: BeaconSignal)
		ifFalse: [ ^ nil ].

	signal := signalClass isBeaconMaterializable
		ifTrue: [ signalClass fromDictionary: aSignalData ]
		ifFalse: [ signalClass new ].

	signal isRemoteSignal
		ifTrue: [ source := self sourceFromData: aSignalData.
			signal source: source ].

	^ signal
]

{ #category : #private }
BeaconServer >> sourceFromData: aSignalData [
	| sourceData sourceClass |

	sourceData := aSignalData at: #source ifAbsent: [ ^ nil ].
	sourceClass := (self class classEncodedInData: sourceData)
		ifNil: [ GenericSignalSource ].
	sourceClass isBeaconRemoteSignalSource
		ifFalse: [ ^ nil ].
	^ sourceClass isBeaconMaterializable
		ifTrue: [ sourceClass fromDictionary: sourceData ]
		ifFalse: [ sourceClass new ]
]

{ #category : #'starting/stopping' }
BeaconServer >> startOn: aPort [
	self isRunning ifTrue: [ self stop ].
	jrpcServer
		port: aPort;
		start
]

{ #category : #'starting/stopping' }
BeaconServer >> stop [
	jrpcServer stop
]
