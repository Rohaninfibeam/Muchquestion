require 'csv'
class TestUpload < ActiveRecord::Base
  def create_test
    tests=["Name","Time","Type"]
    question=["Qname","Question"]
    option=["Option-truth-value","Option-value"]
    question_type=["Question-type"]
    file=self.filename
    csvfile=CSV.read(file)
    header=csvfile.first
    truth,error=validate_header?(header)
    if(truth)
      option_count,qtype_count,test_count,ques_count=0,0,0,0
      options_attributes={}
      qtype_attributes={}
      test_attributes={}
      question_attributes={}
      testhash={}
      (csvfile.reverse.first csvfile.size-1).each do |row|
        new_row=Hash[header.zip(row)]

        if(has_value?(new_row,"option"))
          optionhash=new_row.slice(*option)
          options_attributes[option_count]=optionhash
          option_count=option_count+1
        end

        if(has_value?(new_row,"question_type"))
          qtypehash=new_row.slice(*question_type)
          qtype_attributes[qtype_count]=qtypehash
          qtype_count=qtype_count+1
        end

        if(has_value?(new_row,"question"))
          questionhash=new_row.slice(*question)
          questionhash.merge!("options_attributes"=>options_attributes,"questiontypes_attributes"=>qtype_attributes)
          question_attributes[ques_count]=questionhash
          ques_count=ques_count+1
          option_count=0
          qtype_count=0
          options_attributes={}
          qtype_attributes={}
        end

        if(has_value?(new_row,"tests"))
          testhash=new_row.slice(*tests)
          testhash.merge!("question_attributes"=>question_attributes)
          test_attributes[test_count]=testhash
          test_count=test_count+1
          ques_count=0
          question_attributes={}
        end

      end
      puts testhash
    else
      puts "Header is not valid - " << @error
    end
  end

  def validate_header?(header)
    testheader=["Name","Time","Type","Qname","Question","Option-truth-value","Option-value","Question-type"]
    testheader.each do |th|
      if(!header.include?(th))
        return false,"#{th} not present as header"
      end
    end
    return true
  end

  def has_value?(row,name)
    tests=["Name","Time","Type"]
    question=["Qname","Question"]
    option=["Option-truth-value","Option-value"]
    question_type=["Question-type"]
    var=binding.local_variable_get("#{name}")
    var.each do |v|
      if(row[v]==nil)
        return false
      end
    end
    return true
  end

end
