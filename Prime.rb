require 'prime'

#create a ring with of 5 octaves of C minor
rScale = scale(:C3,:harmonic_minor).pop
rScale = rScale.concat(scale(:C4,:harmonic_minor).pop)
rScale = rScale.concat(scale(:C5,:harmonic_minor).pop)
rScale = rScale.concat(scale(:C6,:harmonic_minor))
rScale = rScale.concat(scale(:C7,:harmonic_minor))

#set up the sound
aNoteLen = 0.5
use_synth :mod_saw
use_bpm 80
use_synth_defaults mod_phase: 0.25, release: 0.25

#calculate the tune
index = 3  #leave some room to reverse direction at 2, etc
direction = 1  #start going forward
i = 0  #
aTune = []
aTiming = []
aRange = *(1..200)
aRange.each do |i|
  i += 1
  if index == rScale.length  #out scale room
    break
  end
  if i.prime?()
    aTiming << aNoteLen
    direction = direction * -1
  else
    aTiming << aNoteLen / 2.0
  end
  index += direction
  if
    aTune << rScale[index]
  end
end

rFours = (ring 0.75,0.5,0.5,0.3)
live_loop :tick do
  sample :drum_cymbal_closed, release: 0.125, amp: rFours.tick
  sleep 0.125
end

#play it
play_pattern_timed aTune,aTiming
