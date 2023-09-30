module SingleInstanceModel
    def self.instance
      @instance ||= self.first_or_create
    end
  end