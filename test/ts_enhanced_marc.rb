#!/usr/bin/env ruby

# local marc library gets tested
# not already installed one
$LOAD_PATH.unshift("enhanced_marc")

require 'test/unit'
require 'rubygems'
require 'enhanced_marc'

class LeaderTypeDetectionTest < Test::Unit::TestCase  
  attr_reader :rec_types
  
  def setup    
    @rec_types = {
      'BKS' => { :type => ['a','t'],	        :blvl => ['a','c','d','m'] },
      'SER' => { :type => ['a'],	            :blvl => ['b','i','s'] },
      'VIS' => { :type => ['g','k','r','o'],  :blvl => ['a','b','c','d','i','m','s'] },
      'MIX' => { :type => ['p'],	            :blvl => ['c','d'] },
      'MAP' => { :type => ['e','f'],	        :blvl => ['a','b','c','d','i','m','s'] },
      'SCO' => { :type => ['c','d'],	        :blvl => ['a','b','c','d','i','m','s'] },
      'REC' => { :type => ['i','j'],	        :blvl => ['a','b','c','d','i','m','s'] },
      'COM' => { :type => ['m'],	            :blvl => ['a','b','c','d','i','m','s'] }
    }
  end
  
  def test_leader_defaults
    leader = MARC::Leader.new('------------------------')
    assert_equal leader, '----------22--------4500'
  end
  
  def test_type_translator
    @rec_types.each_key do |type|
      @rec_types[type][:type].each do |type_code|        
        @rec_types[type][:blvl].each do |blvl_code|
          leader = MARC::Leader.new("      #{type_code}#{blvl_code}                ")          
          assert_equal leader, "      #{type_code}#{blvl_code}  22        4500"
          assert_equal type, leader.get_type
        end
      end
    end
  end  
end