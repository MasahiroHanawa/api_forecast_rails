module Forecasts

  module SearchService
    module_function

    def random_city(params = {})
      city_ids = []
      token = params[:token]
      city_records = CityRecord.where('token = ?', token)
      if city_records.any?
        city_records.each do |city_record|
          city_ids.push(city_record.city_id)
        end
        city = City.where("city_id NOT IN (?)", city_ids).order("RANDOM()").first()
      else
        city = City.order("RANDOM()").first()
      end
      if !city.blank?
        CityRecord.transaction do
          new_city_record = CityRecord.new
          new_city_record.city_id = city[:city_id]
          new_city_record.name = city[:name]
          new_city_record.token = token
          new_city_record.save
          if new_city_record.save
            @city = city
          else
            @city = nil
            raise ActiveRecord::Rollback
          end
        end
      else
        @city = nil
      end

      return @city
    end
  end
end
