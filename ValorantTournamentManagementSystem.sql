-- TABLE CREATION

CREATE TABLE Players(
    PlayerID numeric(11, 0) NOT NULL PRIMARY KEY,
    PlayerName varchar2(100),
    PlayerIGN varchar2(25),
    PlayerRank varchar2(25),
    PlayerRole varchar2(25)
);

CREATE TABLE Coach(
    CoachID numeric(11, 0) NOT NULL PRIMARY KEY,
    CoachName varchar2(100)
);

CREATE TABLE Team(
    TeamID numeric(11, 0) NOT NULL PRIMARY KEY,
    TeamName varchar2(100),
    PlayerOne number(11, 0),
    PlayerTwo number(11, 0),
    PlayerThree number(11, 0),
    PlayerFour number(11, 0),
    PlayerFive number(11, 0),
    PlayerReserve number(11, 0),
    CoachID numeric(11, 0),
    
    CONSTRAINT Team_FK FOREIGN KEY(PlayerOne) REFERENCES Players(PlayerID),
    CONSTRAINT Team_FK2 FOREIGN KEY(PlayerTwo) REFERENCES Players(PlayerID),
    CONSTRAINT Team_FK3 FOREIGN KEY(PlayerThree) REFERENCES Players(PlayerID),
    CONSTRAINT Team_FK4 FOREIGN KEY(PlayerFour) REFERENCES Players(PlayerID),
    CONSTRAINT Team_FK5 FOREIGN KEY(PlayerFive) REFERENCES Players(PlayerID),
    CONSTRAINT Team_FK6 FOREIGN KEY(PlayerReserve) REFERENCES Players(PlayerID),
    CONSTRAINT Team_FK8 FOREIGN KEY(CoachID) REFERENCES Coach(CoachID)
);

CREATE TABLE Organizer(
    OrganizerID numeric(11, 0) NOT NULL PRIMARY KEY,
    OrganizerName varchar2(100)
);

CREATE TABLE Tournament(
    TournamentID numeric(11, 0) NOT NULL PRIMARY KEY,
    TournamentType varchar2(25),
    TournamentName varchar2(100),
    TournamentDate date,
    OrganizerID numeric(11, 0),
    
    CONSTRAINT Tournament_FK FOREIGN KEY(OrganizerID) REFERENCES Organizer(OrganizerID)
);

CREATE TABLE Matchup(
    MatchupID numeric(11, 0) NOT NULL PRIMARY KEY,
    MatchupType varchar2(25),
    MatchupDate date,
    MatchupMap varchar2(25),
    MatchupTeamA numeric(11, 0),
    MatchupTeamB numeric(11, 0),
    TournamentID numeric(11, 0),
    
    CONSTRAINT Matchup_FK FOREIGN KEY(MatchupTeamA) REFERENCES Team(TeamID),
    CONSTRAINT Matchup_FK2 FOREIGN KEY(MatchupTeamB) REFERENCES Team(TeamID),
    CONSTRAINT Matchup_FK3 FOREIGN KEY(TournamentID) REFERENCES Tournament(TournamentID)
);

CREATE TABLE Results(
    ResultID numeric(11, 0) NOT NULL PRIMARY KEY,
    MatchupID numeric(11, 0),
    ResultScore varchar2(25),
    ResultWinner numeric(11, 0),
    ResultLoser numeric(11, 0),
    
    CONSTRAINT Result_FK FOREIGN KEY(ResultWinner) REFERENCES Team(TeamID),
    CONSTRAINT Result_FK2 FOREIGN KEY(ResultLoser) REFERENCES Team(TeamID),
    CONSTRAINT Result_FK3 FOREIGN KEY(MatchupID) REFERENCES Matchup (MatchupID)
);

CREATE TABLE PlayerStats(
    StatsID numeric(11, 0) NOT NULL PRIMARY KEY, 
    StatsKills numeric(3, 0),
    StatsAssists numeric(3, 0),
    StatsDeath numeric(3, 0),
    StatsCombat numeric(5, 0),
    StatsAgent varchar2(25),
    PlayerID numeric(11, 0),
    MatchupID numeric(11, 0),
    
    CONSTRAINT Stats_FK FOREIGN KEY(PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT Stats_FK2 FOREIGN KEY(MatchupID) REFERENCES Matchup(MatchupID)
);

CREATE TABLE ValorantTournament(
    PlayerID numeric(11, 0),
    CoachID numeric(11, 0),
    TeamID numeric(11, 0),
    OrganizerID numeric(11, 0),
    TournamentID numeric(11, 0),
    MatchupID numeric(11, 0),
    ResultID numeric(11, 0),
    StatsID numeric(11, 0),
    
    CONSTRAINT VT_FK FOREIGN KEY(PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT VT_FK2 FOREIGN KEY(CoachID) REFERENCES Coach(CoachID),
    CONSTRAINT VT_FK3 FOREIGN KEY(TeamID) REFERENCES Team(TeamID),
    CONSTRAINT VT_FK4 FOREIGN KEY(OrganizerID) REFERENCES Organizer(OrganizerID),
    CONSTRAINT VT_FK5 FOREIGN KEY(TournamentID) REFERENCES Tournament(TournamentID),
    CONSTRAINT VT_FK6 FOREIGN KEY(MatchupID) REFERENCES Matchup(MatchupID),
    CONSTRAINT VT_FK7 FOREIGN KEY(ResultID) REFERENCES Results(ResultID),
    CONSTRAINT VT_FK8 FOREIGN KEY(StatsID) REFERENCES PlayerStats(StatsID)
);

-- INSERTION STATEMENTS

-- COACH
INSERT INTO Coach VALUES (1, 'Michael Hockom');
INSERT INTO Coach VALUES (2, 'Don Muir');

-- PLAYERS
INSERT INTO Players VALUES (1, 'Peter Mazuryk', 'Asuna', 'Radiant', 'Initiator');
INSERT INTO Players VALUES (2, 'Sean Bezerra', 'bang', 'Radiant', 'Controller');
INSERT INTO Players VALUES (3, 'Brenden McGrath', 'stellar', 'Radiant', 'Sentinel');
INSERT INTO Players VALUES (4, 'Matthew Panganiban', 'Cryocells', 'Radiant', 'Duelist/Sentinel');
INSERT INTO Players VALUES (5, 'Derrek Ha', 'Derrek', 'Radiant', 'Initiator/Sentinel');
INSERT INTO Players VALUES (6, 'Tyson Ngo', 'TenZ', 'Radiant', 'Duelist');
INSERT INTO Players VALUES (7, 'Zachary Patrone', 'zekken', 'Radiant', 'All-rounder');
INSERT INTO Players VALUES (8, 'Gustavo Rossi', 'Sacy', 'Radiant', 'Initiator');
INSERT INTO Players VALUES (9, 'Hunter Mims', 'SicK', 'Radiant', 'Controller');
INSERT INTO Players VALUES (10, 'Bryan Luna', 'pANcada', 'Radiant', 'Controller');
INSERT INTO Players VALUES (11, 'Rory Jackson', 'dephh', 'Radiant', 'Initiator');

-- TEAM
INSERT INTO Team VALUES (1, '100 Thieves', 1, 2, 3, 4, 5, NULL, 1);
INSERT INTO Team VALUES (2, 'Sentinels', 6, 7, 8, 9, 10, 11, 2);

-- ORGANIZER
INSERT INTO Organizer VALUES (1, 'Riot Games');

-- TOURNAMENT
INSERT INTO Tournament VALUES (1, 'Last Chance Qualifier', 'Champions Tour NA', '08/12/2022', 1);

-- MATCHUP
INSERT INTO Matchup VALUES (1, 'Lower Round 2 - Game 1', '08/12/2022', 'Fracture', 1, 2, 1);
INSERT INTO Matchup VALUES (2, 'Lower Round 2 - Game 2', '08/12/2022', 'Breeze', 1, 2, 1);
INSERT INTO Matchup VALUES (3, 'Lower Round 2 - Game 3', '08/12/2022', 'Haven', 1, 2, 1);

-- RESULTS
INSERT INTO Results VALUES (1, 1, '15-17', 2, 1);
INSERT INTO Results VALUES (2, 2, '13-7', 1, 2);
INSERT INTO Results VALUES (3, 3, '13-11', 1, 2);

-- PLAYERSTATS
INSERT INTO PlayerStats VALUES (1, 28, 11, 18, 243, 'Raze', 1, 3);
INSERT INTO PlayerStats VALUES (2, 20, 9, 16, 154, 'Omen', 2, 3);
INSERT INTO PlayerStats VALUES (3, 29, 3, 23, 267, 'Chamber', 6, 1);
INSERT INTO PlayerStats VALUES (4, 18, 3, 13, 166, 'Chamber', 6, 2);

-- QUERIES

-- QUERY 1 Select/Where/2 Tables
SELECT t.TournamentID, t.TournamentName, m.MatchupID, m.MatchupType, m.MatchupTeamA, m.MatchupTeamB
FROM Tournament t, Matchup m
WHERE t.TournamentID = m.TournamentID;

-- QUERY 2 Select/Where/Having/Group
SELECT COUNT(PlayerID) AS Stats_Recorded, StatsAgent AS Agent_Played
FROM PlayerStats
HAVING COUNT(PlayerID) > 1
GROUP BY StatsAgent;

-- QUERY 3 Update Records w/ Subquery
UPDATE Results r
SET ResultScore = '17-15'
WHERE(
    SELECT TeamName
    FROM Team t
    WHERE t.TeamID = r.ResultWinner
) = 'Sentinels';

SELECT t.TeamName, r.ResultScore
FROM Results r, Team t
WHERE t.TeamID = r.ResultWinner;

-- QUERY 4 Insert w/ Subquery
INSERT INTO ValorantTournament
SELECT p.PlayerID, c.CoachID, team.TeamID, o.OrganizerID, tourna.TournamentID, m.MatchupID, r.ResultID, s.StatsID 
FROM Players p, Team team, Coach c, Matchup m, Results r, PlayerStats s, Tournament tourna, Organizer o
WHERE p.PlayerID IN (
    SELECT PlayerID
    FROM PlayerStats
    WHERE p.PlayerID = s.PlayerID
);

SELECT * FROM ValorantTournament;

-- QUERY 5 Display w/ Join ON
SELECT TeamID, TeamName, CoachID, ResultScore, MatchupType
FROM Team t
INNER JOIN Results ON t.TeamID = Results.ResultWinner
INNER JOIN Matchup ON Matchup.MatchupID = Results.MatchupID
WHERE Results.ResultWinner = 1;

-- QUERY 6 Display w/ Implicit Join
SELECT TournamentName, MatchupDate, MatchupType, ResultScore, TeamName AS Winning_Team
FROM Tournament t, Matchup m, Results r, Team t
WHERE t.TournamentID = m.TournamentID AND
r.MatchupID = m.MatchupID AND
t.TeamID = r.ResultWinner AND
MatchupDate = '08/12/2022';