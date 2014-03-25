class SettingsController < ApplicationController
  
  def index
    
  end 
  
  def loadStuff
    puts "loading"
    
    # f = File.open('file.txt', 'a+')
    # f.write("AB\tR\tHR\tRBI\tBB\tK\tSB\tAVG\tOBP\tSLG\tOPS\n")
    Player.delete_all([" created_at between ? AND ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year])
    positions = {"C" => 0, "1B" => 1, "2B" => 2, "3B" => 3, "SS" => 4, "OF" => 5, "DH" => 11}
    # for j in 0..15
    positions.each_pair do|k,v|
      for i in 0..8
        doc = Nokogiri::HTML(open("http://games.espn.go.com/flb/tools/projections?&display=alt&slotCategoryId=#{v}&startIndex=" + (i*15).to_s))
        players = doc.css('table.tableBody')
        for p in players
          pla = Player.create
          z = p.css('tr')[0].css('td')[0].text.strip.split(",")
          
          pla.position = k
          pla.mlbTeam = z[1].strip.split(" ")[0]
          puts pla.mlbTeam
           
          if p.css('tr').size == 4
            pla.espnNotes = p.css('tr')[3].text
          end
          
          pla.first = p.css('a').text
          pla.team_id = Team.find_by_teamName("Free").id
          pla.espnId = p.css('a').attribute("playerid").value
          pla.espnValue = 0
          pla.sbcValue = 0
          
          if p.css('tr')[2].css('td')[0].text.include? "2013"
              pla.ab = p.css('tr')[2].css('td')[2].text 
              pla.r = p.css('tr')[2].css('td')[3].text 
              pla.hr = p.css('tr')[2].css('td')[4].text 
              pla.rbi = p.css('tr')[2].css('td')[5].text 
              pla.bb = p.css('tr')[2].css('td')[6].text 
              pla.k = p.css('tr')[2].css('td')[7].text 
              pla.sb = p.css('tr')[2].css('td')[8].text 
              pla.avg = p.css('tr')[2].css('td')[9].text 
              pla.obp = p.css('tr')[2].css('td')[10].text
              pla.slg = p.css('tr')[2].css('td')[11].text    
              pla.ops = p.css('tr')[2].css('td')[12].text  
          end

          array = "NYM, Mil, Pit, LAD, Col, Cin, Atl, Mia, ChC, StL, Wsh, Phi, SF, SD, Ari"
          if array.include? pla.mlbTeam
              puts 'already here'
              pla.delete
          elsif Player.find_by_espnId(pla.espnId)
              p = Player.find_by_espnId(pla.espnId)
              p.position = p.position + ', ' + k
              p.save
              pla.delete
            
          else
            puts "teamName"
              puts pla.mlbTeam
              pla.save
          end     

        end
      end
    end
    
    positions = {"SP" => 14, "RP" => 15}
    # for j in 0..15
    positions.each_pair do|k,v|
        if k == "SP"
          limit = 15
        else
          limit = 8
        end
        for i in 0..limit
            doc = Nokogiri::HTML(open("http://games.espn.go.com/flb/tools/projections?&display=alt&slotCategoryId=#{v}&startIndex=" + (i*15).to_s))
            players = doc.css('table.tableBody')
            for p in players
                pla = Player.create
                z = p.css('tr')[0].css('td')[0].text.strip.split(",")
                
                pla.position = k
                # puts z[1].strip.split(" ")[0]
                pla.mlbTeam = z[1].strip.split(" ")[0]
                
                if p.css('tr').size == 4
                    pla.espnNotes = p.css('tr')[3].text
                end
                
                pla.first =  p.css('a').text
                pla.team_id = Team.find_by_teamName("Free").id
                pla.espnId = p.css('a').attribute("playerid").value
                pla.espnValue = 0
                pla.sbcValue = 0
                
                if p.css('tr')[2].css('td')[0].text.include? "2013"
                    pla.g =  p.css('tr')[2].css('td')[2].text
                    pla.gs = p.css('tr')[2].css('td')[3].text
                    pla.ip = p.css('tr')[2].css('td')[4].text
                    pla.pbb = p.css('tr')[2].css('td')[5].text
                    pla.pk = p.css('tr')[2].css('td')[6].text
                    pla.w = p.css('tr')[2].css('td')[7].text
                    pla.sv = p.css('tr')[2].css('td')[8].text
                    pla.hd = p.css('tr')[2].css('td')[9].text
                    pla.era = p.css('tr')[2].css('td')[10].text
                    pla.whip = p.css('tr')[2].css('td')[11].text
                    pla.k9 = p.css('tr')[2].css('td')[12].text
                end
                
                array = "NYM, Mil, Pit, LAD, Col, Cin, Atl, Mia, ChC, StL, Wsh, Phi, SF, SD, Ari"
                if array.include? pla.mlbTeam
                  pla.delete
                elsif Player.find_by_espnId(pla.espnId)
                  p = Player.find_by_espnId(pla.espnId)
                  p.position = p.position + ', ' + k
                  p.save
                  pla.delete                    
                else
                  # puts "teamName"
                  # puts pla.mlbTeam
                  pla.save
                end
                
            end
        end
    end
    
    doc = Nokogiri::HTML(open("http://espn.go.com/fantasy/baseball/story/_/page/MLBDK2K13ranks_AL_300/top-300-players"))
    players = doc.css('tr.last')
    for p in players
        
        if (p.css('td')[0].text.strip  =~ /^[-+]?[0-9]+$/)
            puts p.css('td')[7].text.strip
            pla = Player.find_by_first(p.css('td')[1].text.strip)
            if pla
              pla.espnValue = p.css('td')[7].text.strip.gsub('$', '')
              pla.save
            end
            # puts p.css('td')[1].text.strip
            # puts p.css('td')[7].text.strip
        end

        
    end
    
    redirect_to "/"
  end
  
end
