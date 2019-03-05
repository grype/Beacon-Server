Class {
	#name : #BeaconServer,
	#superclass : #Object,
	#instVars : [
		'jrpcServer'
	],
	#category : #'Beacon-Server-Server'
}

{ #category : #'event handling' }
BeaconServer >> handleEmittedData: aSignalData [
	| signalClass signal |
	signalClass := aSignalData 
		at: #'__class'
		ifPresent: [ :cls | Smalltalk at: cls asSymbol ifAbsent: [ ^ nil ] ]
		ifAbsent: [ ^ nil ].
		
	signal := signalClass new.

	aSignalData associations
		do: [ :each | 
			| setter |
			setter := (each key , ':') asSymbol.
			(signal respondsTo: setter)
				ifTrue: [ signal perform: setter with: each value ] ].
	signal emit
]

{ #category : #initialization }
BeaconServer >> initialize [
	super initialize.
	jrpcServer := JRPCServer http
		port: 4000;
		addHandlerNamed: 'emit'
			block: [ :signalData | 
				signalData do: [ :each | self handleEmittedData: each ] ];
		yourself
]

{ #category : #initialization }
BeaconServer >> initializeOld [
	super initialize.
	jrpcServer := JRPCServer http
		port: 4000;
		addHandlerNamed: 'emit'
			block: [ :signalData | self handleEmittedData: signalData ];
		yourself
]

{ #category : #testing }
BeaconServer >> isRunning [ 
	^ jrpcServer isRunning 
]

{ #category : #'starting/stopping' }
BeaconServer >> start [
	jrpcServer start
]

{ #category : #'starting/stopping' }
BeaconServer >> stop [
	jrpcServer stop
]
