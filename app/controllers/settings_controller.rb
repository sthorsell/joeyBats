class SettingsController < ApplicationController
  
  def index
    
  end 
  
  def loadStuff
    puts "loading"
    
    # f = File.open('file.txt', 'a+')
    # f.write("AB\tR\tHR\tRBI\tBB\tK\tSB\tAVG\tOBP\tSLG\tOPS\n")
    # Player.delete_all([" created_at between ? AND ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year])
    
    positions = {"C" => 0, "1B" => 1, "2B" => 2, "3B" => 3, "SS" => 4, "OF" => 5, "DH" => 11}
    # for j in 0..15
    positions.each_pair do|k,v|
      for i in 0..8
        doc = Nokogiri::HTML(open("http://games.espn.go.com/flb/tools/projections?&display=alt&slotCategoryId=#{v}&startIndex=" + (i*15).to_s))
        players = doc.css('table.tableBody')
        for p in players
          if Player.where([" created_at between ? AND ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year]).find_by_espnId(p.css('a').attribute("playerid").value) == nil
            pla = Player.create
            z = p.css('tr')[0].css('td')[0].text.strip.split(",")
            
            pla.position = k
            pla.mlbTeam = z[1].strip.split(" ")[0]
             
            if p.css('tr').size == 4
              pla.espnNotes = p.css('tr')[3].text
              pla.espnNotes = pla.espnNotes.force_encoding("ISO-8859-1").encode("utf-8", replace:nil)
            end
            
            pla.first = p.css('a').text
            n = pla.first.strip.split(" ")
            pla.last = n[1] + ', ' + n[0]
            pla.team_id = Team.find_by_teamName("Free").id
            pla.espnId = p.css('a').attribute("playerid").value
            pla.espnValue = 0
            pla.sbcValue = 0
            # Need to change this from hard code
            # pla.year_id = 2
            
            if p.css('tr')[2].css('td')[0].text.include? "2014"
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
                pla.delete
            elsif Player.where("team_id = 1").find_by_espnId(pla.espnId)
                p = Player.where("team_id = 1").find_by_espnId(pla.espnId)
                p.position = p.position + ', ' + k
                p.save
                pla.delete            
            else
              puts pla.attributes
                pla.save
            end     
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
          limit = 18
        end
        for i in 0..limit
            doc = Nokogiri::HTML(open("http://games.espn.go.com/flb/tools/projections?&display=alt&slotCategoryId=#{v}&startIndex=" + (i*15).to_s))
            players = doc.css('table.tableBody')
            for p in players
                if Player.where([" created_at between ? AND ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year]).find_by_espnId(p.css('a').attribute("playerid").value) == nil
                  pla = Player.create
                  z = p.css('tr')[0].css('td')[0].text.strip.split(",")
                  
                  pla.position = k
                  # puts z[1].strip.split(" ")[0]
                  pla.mlbTeam = z[1].strip.split(" ")[0]
                  
                  if p.css('tr').size == 4
                      pla.espnNotes = p.css('tr')[3].text
                      pla.espnNotes = pla.espnNotes.force_encoding("ISO-8859-1").encode("utf-8", replace:nil)
                  end
                  
                  pla.first =  p.css('a').text
                  pla.team_id = Team.find_by_teamName("Free").id
                  pla.espnId = p.css('a').attribute("playerid").value
                  
                  pla.espnValue = 0
                  pla.sbcValue = 0
                  
                  if p.css('tr')[2].css('td')[0].text.include? "2014"
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
                  elsif Player.where("team_id = 1").find_by_espnId(pla.espnId)
                    p = Player.where("team_id = 1").find_by_espnId(pla.espnId)
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
    end
    
    # doc = Nokogiri::HTML(open("http://espn.go.com/fantasy/baseball/story/_/page/MLBDK2K13ranks_AL_300/top-300-players"))
    # players = doc.css('tr.last')
    # for p in players
        
    #     if (p.css('td')[0].text.strip  =~ /^[-+]?[0-9]+$/)
    #         puts p.css('td')[7].text.strip
    #         pla = Player.find_by_first(p.css('td')[1].text.strip)
    #         if pla
    #           pla.espnValue = p.css('td')[7].text.strip.gsub('$', '')
    #           pla.save
    #         end
    #         # puts p.css('td')[1].text.strip
    #         # puts p.css('td')[7].text.strip
    #     end

        
    # end
    
    redirect_to "/"
  end
  
  def loadLineups

    teams = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15']

    # for t in teams
      Player.update_all(starter:0)
      html = `phantomjs /Users/Stevo/Code/joeyBats/public/charts/15.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/1.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/2.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/3.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/4.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/5.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/6.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/7.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/8.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/9.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/10.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/11.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/12.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/13.js`
      html += `phantomjs /Users/Stevo/Code/joeyBats/public/charts/14.js`


      puts 'jshtml'
      # puts html
      doc = Nokogiri::HTML(html)
      players = doc.css('tr')
      numArray = ['1','2','3','4','5','6','7','8','9', 'CL', 'SU']
      for p in players
        # Use includes, can't look up doc right now
        puts p
        if p.css('td').count > 3 and 
            ( p.css('td')[2].text == '1' or p.css('td')[2].text == '2' or
              p.css('td')[2].text == '3' or p.css('td')[2].text == '4' or
              p.css('td')[2].text == '5' or p.css('td')[2].text == '6' or
              p.css('td')[2].text == '7' or p.css('td')[2].text == '8' or
              p.css('td')[2].text == '9' or p.css('td')[2].text == 'CL' or
              p.css('td')[2].text == 'SU' or p.css('td')[2].text == 'DL'

            )
            pos = p.css('td')[4].text
            name = p.css('td')[8].text
            pl = Player.where([" created_at between ? AND ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year]).find_by_first(name)
            if pl != nil
              
              if
                pl.starter = 1
              end
              if p.css('td')[21].text != ''
                if p.css('td')[2].text == 'DL'
                  pl.starter = 0
                  pl.injuryNotes = 'DL:' + p.css('td')[21].text + p.css('td')[22].text 
                else
                  pl.injuryNotes = p.css('td')[21].text + p.css('td')[22].text
                end
              end
              pl.save
            end
          end
      # end
    end
    redirect_to "/"
  end

  def getValues
    doc = Nokogiri::HTML(open("http://razzball.com/playerrater-preseason-alonly12team/"))
    players = doc.css('#neorazzstatstable').css('tr')
    puts 'h'
    # puts doc
    posArray = ['RF','CF','LF', 'OF', '3B', '2B', 'SS', '1B', 'C', 'SP', 'RP']
    for p in players
      puts
      if p.css('td')[3] != nil and posArray.include? p.css('td')[3].text.split(',')[0]
          n = p.css('td')[1].text
          e = p.css('td')[5].text
          puts n
          p = Player.where([" created_at between ? AND ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year]).find_by_first(n)
          if p != nil
            p.espnValue = e
            p.save
          end
        end
    end
    redirect_to "/"
  end

  def loadEspnLineups
        teams = ['bal/baltimore-orioles','bos/boston-red-sox', 'chw/chicago-white-sox','cle/cleveland-indians','det/detroit-tigers','hou/houston-astros',
      'kc/kansas-city-royals','laa/los-angeles-angels','min/minnesota-twins', 'nyy/new-york-yankees','oak/oakland-athletics',
      'sea/seattle-mariners','tb/tampa-bay-rays','tex/texas-rangers','tor/toronto-blue-jays']

    for t in teams
      doc = Nokogiri::HTML(open("http://espn.go.com/mlb/team/depth/_/name/" + t))
      rows = doc.css('table.tablehead tr')
      rows.shift
      rows.shift
      for p in rows
        
        if p.css('td')[0].text == 'Starting Pitcher'
          for i in 1..5

            n = p.css('td')[i].text
            pl = Player.where([" created_at between ? AND ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year]).find_by_first(n)
            if pl != nil
              pl.starter = 1
              pl.save
              puts pl.first
            end
          end

        else
          n = p.css('td')[1].text
          pl = Player.where([" created_at between ? AND ?", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year]).find_by_first(n)
          if pl != nil
            pl.starter = 1
            pl.save
            puts pl.first
          end
        end    
      end
    end
  end
end
