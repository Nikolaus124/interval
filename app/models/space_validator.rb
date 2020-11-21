class SpaceValidator < ActiveModel::Validator

  def validate(record)
    d_spaces = Space.where(["doctor_id = :doctor_id and create_date = :create_date", {doctor_id: record.doctor_id, create_date: record.create_date}])
    p_spaces = Space.where(["patient_id = :patient_id and create_date = :create_date", {patient_id: record.patient_id, create_date: record.create_date}])

    if d_spaces.length == 0
      return
    end
    if p_spaces.length == 0
      return
    end
    if d_spaces.length == 1
      if one_rec(d_spaces, record) == false
        record.errors[:base] << "This interval is busy"
        return
      end
    end

    if p_spaces.length == 1
      if one_rec(d_spaces, record) == false
        record.errors[:base] << "You have to visit another doctor"
        return
      end
    end

    if ins(d_spaces, record) == false
      record.errors[:base] << "This interval is busy"
    end

    if ins(p_spaces, record) == false
      record.errors[:base] << "You have to visit another doctor"
    end
  end


  private

  def ins(spaces, record)
    sp_s = Time.parse(spaces.first.start_time)
    r_e = Time.parse(record.end_time)

    if (sp_s.hour * 60 + sp_s.min) >= (r_e.hour * 60 + r_e.min)
      return true
    end

    sp_e = Time.parse(spaces.last.end_time)
    r_s = Time.parse(record.start_time)

    if (sp_e.hour * 60 + sp_e.min) <= (r_s.hour * 60 + r_s.min)
      return true
    end

    spaces.each_with_index do |a, i|
      sp_s = Time.parse(spaces[i].start_time)
      sp_e = Time.parse(spaces[i].end_time)

      r_s = Time.parse(record.start_time)
      r_e = Time.parse(record.end_time)

      sp1_s = Time.parse(spaces[i+1].start_time)
      sp1_e = Time.parse(spaces[i+1].end_time)

      if (sp_e.hour * 60 + sp_e.min) <= (r_s.hour * 60 + r_s.min)
        if (r_e.hour * 60 + r_e.min) <= (sp1_s.hour * 60 + sp1_s.min)
          return true
        end
      else
        return false
      end
    end
  end

  def one_rec(space, record)
    sp_s = Time.parse(space.first.start_time)
    sp_e = Time.parse(space.first.end_time)

    r_s = Time.parse(record.start_time)
    r_e = Time.parse(record.end_time)

    if (sp_e.hour * 60 + sp_e.min) <= (r_s.hour * 60 + r_s.min)
      return true
    elsif (sp_s.hour * 60 + sp_s.min) >= (r_e.hour * 60 + r_e.min)
      return true
    else
      return false
    end

  end
end
