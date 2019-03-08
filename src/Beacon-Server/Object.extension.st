Extension { #name : #Object }

{ #category : #'*Beacon-Server' }
Object >> isRemoteSignalWithStack [
	^ self class hasTraitComposition
		and: [ self class traitComposition allTraits
				includes: TBeaconRemoteCallStack ]
]
