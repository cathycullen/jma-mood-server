class Mood < ActiveRecord::Base
  belongs_to :user

  # get weekly energy levels for user in terms of percentages
  #[{"Level 1" => .25}, {"Level 2" => .75}]
  def weekly_energy_levels_for_user()
    results = []
    total = Mood.where(:user_id => @user.id, 
    	:created_at => 1.week.ago..Time.now).count

    for level in 1..7
    	if Mood.where(:user_id => user_for_auth_token.id, :created_at => 1.week.ago..Time.now, :energy_level => level).count > 0
	   		results << {:level => "Level "+level.to_s, :pct => ((Mood.where(:user_id => @user.id, :created_at => 1.week.ago..Time.now, :energy_level => level).count / total.to_f) * 100 ) }
	   	end
		end
  end

   def test_weekly_energy_levels_for_user()
    results = []
    total = Mood.where(:user_id => 2, 
    	:created_at => 1.week.ago..Time.now).count

    for level in 1..7
    	if Mood.where(:user_id => 2, :created_at => 1.week.ago..Time.now, :energy_level => level).count > 0
	   		results << {:level => level, :pct => (Mood.where(:user_id => 2, :created_at => 1.week.ago..Time.now, :energy_level => level).count / total.to_f) * 100  }
	   	end
		end
  end
end
