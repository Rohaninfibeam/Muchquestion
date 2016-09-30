module UpdateTest
	def update
		@test=Test.find(params[:id])
		Test.update(testparams)
	end
end