module MARC

  # A class that represents an individual MARC record. Every record
  # is made up of a collection of MARC::Field objects. 

  class BookRecord < Record

    def initialize
      super
      @leader[6] = 'a' if @leader[6,1] == ' '
      @leader[7] = 'm' if @leader[7,1] == ' '    
      @record_type = 'BKS'  
      @bibliographic_level = @leader.get_blvl
      self.extend BookType
      self.inspect_fixed_fields
    end
    
    def is_valid_type?
      return false unless @leader[6,1].match(/[at]{1}/)
      return true
    end
    def is_valid_blvl?
      return false unless @leader[7,1].match(/[acdm]{1}/)    
      return true
    end
    def self.new_from_record(record)
      rec = BookRecord.new
      record.instance_variables.each { | var |
        rec.instance_variable_set(var, record.instance_variable_get(var))
      }
      return Exception.new("Incorrect type declaration in leader") unless rec.is_valid_type?
      return Exception.new("Incorrect bibliographic declaration in leader") unless rec.is_valid_blvl?
      return rec
    end    
    
  end
end
