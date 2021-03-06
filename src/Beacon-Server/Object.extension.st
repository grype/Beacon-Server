Extension { #name : #Object }

{ #category : #'*Beacon-Server' }
Object class >> isBeaconMaterializable [
	^ self hasTraitComposition and: [ self traitComposition allTraits includes: TBeaconMaterializing ]
]

{ #category : #'*Beacon-Server' }
Object class >> isBeaconRemoteSignalSource [
	^ self hasTraitComposition
		and:
			[ self traitComposition allTraits includes: TBeaconRemoteSignalSource ]
]

{ #category : #'*Beacon-Server' }
Object >> isBeaconSignal [
	^ false
]

{ #category : #'*Beacon-Server' }
Object >> isRemoteBeaconSignal [
	^ false
]

{ #category : #'*Beacon-Server' }
Object >> isRemoteBeaconSignalOfType: aTypeName [
	^ false
]

{ #category : #'*Beacon-Server' }
Object >> isRemoteSignal [
	^ self class hasTraitComposition
		and: [ self class traitComposition allTraits
				includes: TBeaconRemoteSignal ]
]

{ #category : #'*Beacon-Server' }
Object >> isRemoteSignalWithStack [
	^ self class hasTraitComposition
		and:
			[ self class traitComposition includesTrait: TBeaconRemoteCallStack ]
]

{ #category : #'*Beacon-Server' }
Object >> remoteBeaconType [
	^ nil
]
