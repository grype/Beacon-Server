Trait {
	#name : #TBeaconMaterializing,
	#superclass : nil,
	#type : nil,
	#category : #'Beacon-Server-Server'
}

{ #category : #'instance creation' }
TBeaconMaterializing classSide >> fromDictionary: aDict [
	| instance setter |
	instance := self new.
	aDict associationsDo: [ :each | 
		setter := (each key , ':') asSymbol.
		(instance respondsTo: setter) ifTrue: [ instance perform: setter with: each value ]
		].
	^ instance
]
