helpers do
  def energy_levels_for_user(moods)
    results = []
    total = moods.count

    for level in 1..7
			if moods.where(:energy_level => level).count > 0
	   		results << {:level => "Level "+level, :pct => ((moods.where(:energy_level => level).count / total) * 100 ) }
	   	end
		end

  end
end
