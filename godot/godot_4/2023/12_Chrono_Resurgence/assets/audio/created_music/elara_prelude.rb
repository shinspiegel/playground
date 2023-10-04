use_bpm 60

define :drum_loop do
  in_thread do
    loop do
      sample :bd_klub, amp: 0.8
      sleep 0.75
      
      sample :sn_soft, amp: 0.6
      sample :drum_cymbal_pedal, amp: 0.4
      sleep 0.75
      
      sample :drum_cymbal_pedal, amp: 0.4
      sleep 0.5
    end
  end
end


define :elara_blade_hollow do |amp_start=0.2, amp_increment=0.05|
  amp_current = amp_start
  in_thread do
    loop do
      sleep 2
      use_synth :blade
      play_pattern_timed [:D4, :E4, :F4, :E4], [0.5, 0.5, 0.5, 1], amp: amp_current
      
      use_synth :hollow
      play_pattern_timed [:A4, :G4, :F4, :D4], [0.5, 0.5, 0.5, 1], amp: amp_current
      
      amp_current = [amp_current + amp_increment, 0.6].min
    end
  end
end


define :elara_bells do
  in_thread do
    loop do
      use_synth :pretty_bell
      play_pattern_timed [:E6, :D6, :C6, :G5, :B4, :A4, :E5, :D5, :G4],
        [0.25, 0.25, 0.5, 0.25, 0.25, 0.25, 0.25, 0.5, 1],
        amp: 0.2
      sleep 4.5
    end
  end
end



define :elara_piano do
  in_thread do
    loop do
      use_synth :piano
      play [:D4, :A4], sustain: 2, amp: 0.4
      sleep 2.5
      play [:E4, :G4], sustain: 1.5, amp: 0.4
      sleep 2
    end
  end
end


define :elara_prelude do
  drum_loop
  
  sleep 4
  elara_blade_hollow
  
  sleep 8
  elara_bells
  
  sleep 12
  elara_piano
end


elara_prelude
sleep 30
stop