Extension { #name : #Beacon }

{ #category : #'*Beacon-Server' }
Beacon >> when: anAnnouncementClass do: aValuable for: aSubscriber [
	self announcer when: anAnnouncementClass do: aValuable for: aSubscriber
]
