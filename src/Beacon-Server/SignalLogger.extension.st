Extension { #name : #SignalLogger }

{ #category : #'*Beacon-Server' }
SignalLogger >> startFiltering: aBlock [
	self isRunning
		ifTrue: [ self stop ].
	self beacon
		when: BeaconSignal
		do: [ :aSignal | 
			(aBlock cull: aSignal)
				ifTrue: [ self nextPut: aSignal ] ]
		for: self
]
