"
I encapsulate a remote context signal, similar to ==ContextSignal==.
"
Class {
	#name : #RemoteContextStackSignal,
	#superclass : #ThisContextSignal,
	#traits : 'TBeaconRemoteSignal + TBeaconRemoteCallStack + TBeaconMaterializing',
	#classTraits : 'TBeaconRemoteSignal classTrait + TBeaconRemoteCallStack classTrait + TBeaconMaterializing classTrait',
	#category : #'Beacon-Server-Signals'
}

{ #category : #initialize }
RemoteContextStackSignal >> currentStack [
	^ self stack 
]

{ #category : #'*Beacon-Server' }
RemoteContextStackSignal >> gtInspectorDisplayType [
	^ self source ifNil: [ super gtInspectorDisplayType ] ifNotNil: [ :val | val gtInspectorDisplayString ]
]

{ #category : #'*Beacon-Server' }
RemoteContextStackSignal >> isRemoteContextStackSignal [
	^ true
]

{ #category : #printing }
RemoteContextStackSignal >> printOneLineContentsOn: aStream [
	self source printOneLineContentsOn: aStream
]
