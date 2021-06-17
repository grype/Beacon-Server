Class {
	#name : #BeaconServerTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'Beacon-Server-Tests'
}

{ #category : #running }
BeaconServerTest >> setUp [
	super setUp.
	server := BeaconServer new.
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
