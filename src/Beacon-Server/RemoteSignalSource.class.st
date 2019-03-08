Class {
	#name : #RemoteSignalSource,
	#superclass : #Object,
	#instVars : [
		'origin',
		'source',
		'timestamp'
	],
	#category : #'Beacon-Server-Server'
}

{ #category : #initialization }
RemoteSignalSource >> initialize [
	super initialize.
	timestamp := DateAndTime new
]

{ #category : #accessing }
RemoteSignalSource >> origin [
	^ origin
]

{ #category : #accessing }
RemoteSignalSource >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
RemoteSignalSource >> source [
	^ source
]

{ #category : #accessing }
RemoteSignalSource >> source: anObject [
	source := anObject
]

{ #category : #accessing }
RemoteSignalSource >> timestamp [
	^ timestamp
]

{ #category : #accessing }
RemoteSignalSource >> timestamp: anObject [
	timestamp := anObject
]
