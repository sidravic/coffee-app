module TokenGeneratorService
  module ClassMethods
    def generate_unique_token
      unqiue_token = loop do
        token = SecureRandom.hex(2)
        break token if not where(token: token).exists?
      end
    end

    def generate_unique_token_for(field_name)
      unique_token = loop do
        token = SecureRandom.hex(2)
        condition = {field_name => token}
        break token if not where(condition).exists?
      end
    end

    def generate_unique_token_for_model(model, field)
      unique_token = loop do
        token = SecureRandom.hex
        break token if not model.where("#{field}": token).exists?
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end
