CREATE DATABASE IF NOT EXISTS India_Election_Results;
USE  India_Election_Results;
select * from 
partywise_Results;
# India General elections Result analysis 2024

# Total Seats
SELECT
DISTINCT COUNT(Parliament_Constituency) AS Total_Seats
FROM constituencywise_results;

# What is the total number of seats available for elections in each state
SELECT
      s.state AS State_Name,
      COUNT(cr.Constituency_ID) AS Total_Seats_Available
FROM 
     constituencywise_results cr
JOIN 
      statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
      states s ON sr.State_ID =  s.State_ID
GROUP BY s.State
ORDER BY Total_Seats_Available desc;

# Total Seats Won by NDA Alliance
SELECT
       SUM(CASE
               WHEN Party IN (
               'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM',
                'United Peopleâ€™s Party, Liberal - UPPL'

                )Then Won
               ELSE 0
               END )AS  NDA_Total_Seats_Wont
               
FROM partywise_results;

# Seats Won by Nda Alliance Parties
SELECT
        Party AS Party_Name,
        Won AS Seats_Won
FROM  
      partywise_results
WHERE  
     Party in(
      'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM',
                'United Peopleâ€™s Party, Liberal - UPPL'
)
ORDER BY seats_won DESC;
# Total Seats Won by I.N.D.I.Alliance
SELECT
      SUM(CASE
               WHEN party IN(
                               'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
                )
			  THEN Won
              ELSE 0
              END) AS INDIA_Total_Seats_Won
FROM
       partywise_results;

# Seats Won by I.N.D.I.A Alliance Parties
SELECT
       party AS Party_Name,
       Won AS Seats_Won
FROM partywise_results
WHERE Party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
)
ORDER BY seats_Won DESC;
# Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

 WITH Party_Alliance  AS (
  SELECT
        p.*,
        CASE
            WHEN p.Party IN(
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',	
                'Indian Union Muslim League - IUML',
                'Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
			THEN 'I.N.D.I.A'
		WHEN p.party IN(
				'Bharatiya Janata Party - BJP',
                'Telugu Desam - TDP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM',
                'United Peopleâ€™s Party, Liberal - UPPL'
            )
		THEN 'NDA'
        ELSE 'OTHER'
	END AS Party_Alliance
FROM  Partywise_Results p
)
SELECT
       pa.party_Alliance,
	   COUNT(cr.Constituency_ID) AS Seats_Won
FROM constituencywise_results cr
JOIN Party_Alliance pa ON cr.Party_ID =  pa.party_id
GROUP BY pa.party_Alliance
ORDER BY Seats_Won DESC ;

# Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
WITH Party_Alliance  AS (
  SELECT
        p.*,
        CASE
            WHEN p.Party IN(
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',	
                'Indian Union Muslim League - IUML',
                'Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
			THEN 'I.N.D.I.A'
		WHEN p.party IN(
				'Bharatiya Janata Party - BJP',
                'Telugu Desam - TDP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM',
                'United Peopleâ€™s Party, Liberal - UPPL'
            )
		THEN 'NDA'
        ELSE 'OTHER'
	END AS Party_Alliance
FROM  Partywise_Results p
)
select 
       cr.Winning_Candidate,
       pa.party,
       Pa.Party_Alliance,
       cr.Total_Votes,
       cr.Margin,
       cr.Constituency_Name,
       s.state
From constituencywise_results cr
join party_alliance pa on cr.Party_ID = pa.Party_ID
join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s on sr.State_ID = s.State_ID
where 
      s.State = "Telangana"
and   cr.Constituency_Name = "Hyderabad";


# What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

select 
       cd.Candidate,
       cd.Party,
       cd.EVM_Votes,
       cd.Postal_Votes,
       cd.Total_Votes,
       cr.Constituency_Name
from constituencywise_details cd

join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
where  cr.Constituency_Name = "Nizamabad"
order by cd.Total_Votes desc;

# Which parties won the most seats in s State, and how many seats did each party win?
select 
       p.party,
       count(cr.Constituency_ID) as Seats_Won
from constituencywise_results cr
Join partywise_results p on cr.Party_ID = p.Party_ID
join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s on sr.State_ID = s.State_ID
where s.state = 'maharashtra'
group by p.Party
order by seats_won desc;

WITH Party_Alliance_pa  AS (
  SELECT
        p.*,
        CASE
            WHEN p.Party IN(
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',	
                'Indian Union Muslim League - IUML',
                'Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
			THEN 'I.N.D.I.A'
		WHEN p.party IN(
				'Bharatiya Janata Party - BJP',
                'Telugu Desam - TDP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM',
                'United Peopleâ€™s Party, Liberal - UPPL'
            )
		THEN 'NDA'
        ELSE 'OTHER'
	END AS Party_Alliance
FROM  Partywise_Results p
)
select 
  s.state as State_Name, 
  count(cr.Constituency_ID) as Total_Seats,
  sum(case when pa.party_alliance = 'NDA' THen 1 else 0 end) as NDA_Seats_Won,
  sum(case when pa.party_alliance = 'I.N.D.I.A' THen 1 else 0 end) as INDIA,
  sum(case when pa.party_alliance = 'OTHER' THen 1 else 0 end) as OTHERS
 
from constituencywise_results cr
join party_alliance_pa pa on cr.Party_ID = pa.party_id
join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s on sr.State_ID = s.State_ID
Where pa.party_Alliance in("Nda","I.n.d.i.a","Other")
group by s.State
order by s.State;

# Which candidate received the highest number of EVM votes in each constituency (Top 10)?
select  
      cr.Constituency_Name,
      cd.Constituency_ID,
      cd.Candidate,
      cd.EVM_Votes
from constituencywise_details cd
join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
join (
       select
		Constituency_ID,
        max(EVM_Votes) as Max_Votes
	    from constituencywise_details cd
        group by Constituency_ID
        ) max_votes_Table on cd.Constituency_ID = max_votes_Table.Constituency_ID
        and cd.EVM_Votes = max_votes_Table.max_votes
order by cd.EVM_Votes desc
limit 10;

# Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?

WITH RankedCandidates AS (
    SELECT 
        cd.Constituency_ID,
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,
        (cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY (cd.EVM_Votes + cd.Postal_Votes) DESC) AS VoteRank
    FROM 
        constituencywise_details cd
    JOIN 
        constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN 
        statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        states s ON sr.State_ID = s.State_ID
    WHERE 
        s.State = 'Telangana'
)

SELECT 
    cr.Constituency_Name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;
a
