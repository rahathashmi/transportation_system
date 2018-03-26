class Trip < ApplicationRecord
  
  belongs_to :vehicle
  belongs_to :user
  belongs_to :company
  
  validates :user_id, presence: true
  validates :vehicle_id, presence: true
  validates :company_id, presence: true
  validates :start_time, presence: true
  
  validate :user_and_vehicle_belongs_to_company
  validate :user_and_vehicle_presence  
  

  
  scope :filter_by_user, ->(user_email = nil) {
    if user_email.present?
      eager_load(:user).where("#{User.table_name}.email LIKE ? OR #{User.table_name}.id LIKE ?", "%#{user_email.downcase}%","%#{user_email.downcase}%")
    end
  }
  scope :filter_by_vehicle, ->(id = nil) {
    if id.present?
      eager_load(:vehicle).where("#{Vehicle.table_name}.id LIKE ?", "%#{id.downcase}%")
    end
  }
  scope :filter_by_all, ->(user_email = nil, id = nil) {
    if user_email.present? && id.present?
      eager_load(:user, :vehicle).where("#{User.table_name}.email LIKE ? OR #{Vehicle.table_name}.id LIKE ? ", "%#{user_email.downcase}%", "%#{id.downcase}%")
    end
  }
  
  scope :date_check, ->(start_time = nil, end_time = nil) {
    if (start_time.present? && end_time.present?) && start_time.to_date <= end_time.to_date
      where("start_time IS NOT NULL and end_time BETWEEN ? AND ?",start_time.to_date,end_time.to_date)
    end
  }
  
  private
  
  def user_and_vehicle_belongs_to_company
    if self.company_id.present?
      company = Company.find(self.company_id)
      if company.vehicles.find_by(id: vehicle_id).blank?
        errors.add(:vehicle," does not belong to company")
      end
      if company.users.find_by(id: user_id).blank?
        errors.add(:user, " does not belong to company")
      end
    end
  end
  
  def user_and_vehicle_presence
    if self.vehicle_id.present?
      vehicle = Vehicle.find_by_id(vehicle_id)
      unless vehicle.nil?
        if vehicle.trips.present?
          if vehicle.trips.where("end_time IS NULL OR start_time > ? AND ? < end_time AND ? < end_time", self.start_time, self.start_time, self.end_time).present?
            errors.add(:vehicle_id, "is not available for trip")
          end
        end
      else
        errors.add(:user_id, "record not found")
      end
    end
    if self.user_id.present?
      user = User.find_by_id(user_id)
      unless user.nil?
        if user.trips.present?
          if user.trips.where("end_time IS NULL OR start_time > ? AND ? < end_time AND ? < end_time", self.start_time, self.start_time, self.end_time).present?
            errors.add(:user_id, "is not available for trip")
          end
        end
      else
        errors.add(:user_id, "record not found")
      end
    end
  end
  
end
