class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
  serialize :role ,Array
  has_many :testusers, ->{where realtestuser_id: nil}
  has_many :tests, through: :testusers
  def self.from_google(auth_token)
  	data = auth_token.info
  	user = User.where(:email => data["email"]).first
  	if !user
  		@user=User.create(name: data["name"],email: data["email"],password: Devise.friendly_token[0,20])
  		return @user
  	else
  		return user
  	end
  end

  def admin?
    return self.role.include? "admin"
  end

  def findscore(test)
    @testuser=Testuser.where(:test_id=>test.id,:user_id=>self.id)
    ha={}
    test.questions.each do |que|
      ar=[]
      que.options.where(:istrue=>true).each do |opt|
        ar<<opt.id
      end
      ha[que.id]=ar
    end
    xx=@testuser.map do |tesus|
      quess={}
      tesus.userquestions.each do |usqu|
        ar=[]
        usqu.answerusers.where.not(:option_id=>0).each do |ansuse|
          ar<<ansuse.option_id
        end
        quess[usqu.question_id]=ar
      end
      quess
    end
    ans=[]
    xx.each do |x|
      cnt=0
      ha.each do |k,v|
        if x.key?(k) && (x[k].count<=v.count)
          v.each do |val|
            if x[k].include? val
              cnt=cnt+1
            end
          end
        end
      end
      ans<<cnt
    end
    return ans
  end

end
