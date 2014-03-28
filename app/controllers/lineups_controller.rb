class LineupsController < ApplicationController

	def index
		@mlbT = [Player.where("mlbTeam is 'Bal' and starter is 1"),Player.where("mlbTeam is 'Bos' and starter is 1"),
			Player.where("mlbTeam is 'CWS' and starter is 1"),Player.where("mlbTeam is 'Cle' and starter is 1"),Player.where("mlbTeam is 'Det' and starter is 1"),
			Player.where("mlbTeam is 'Hou' and starter is 1"),Player.where("mlbTeam is 'KC' and starter is 1"),
			Player.where("mlbTeam is 'LAA' and starter is 1"),Player.where("mlbTeam is 'Min' and starter is 1"),
			Player.where("mlbTeam is 'NYY' and starter is 1"),Player.where("mlbTeam is 'Oak' and starter is 1"),
			Player.where("mlbTeam is 'Sea' and starter is 1"),Player.where("mlbTeam is 'TB' and starter is 1"),
			Player.where("mlbTeam is 'Tex' and starter is 1"),Player.where("mlbTeam is 'Tor' and starter is 1")]

	end
end
