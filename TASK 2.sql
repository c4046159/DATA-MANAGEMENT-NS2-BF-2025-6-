SELECT
    r.Title AS RaceTitle,
    m.MeetingDate,
    c.CourseName,
    hr.CloseUp AS CloseUpComments,
    hr.FinishPosition,
    hr.Age AS HorseAge,
    hr.WeightValue,
    hr.WeightText,
    hr.OfficialRating,
    h.HorseName,
    j.FullName AS Jockey,
    t.FullName AS Trainer,
    o.FullName AS Owner
FROM Race AS r
INNER JOIN Meeting AS m
    ON r.MeetingID = m.MeetingID
INNER JOIN Course AS c
    ON m.CourseID = c.CourseID
INNER JOIN Horse_Race AS hr
    ON r.RaceID = hr.RaceID
INNER JOIN Horse AS h
    ON hr.HorseID = h.HorseID
LEFT JOIN Person AS j
    ON hr.JockeyID = j.PersonID
LEFT JOIN Person AS t
    ON hr.TrainerID = t.PersonID
LEFT JOIN Person AS o
    ON hr.OwnerID = o.PersonID
WHERE r.RaceID = (
    SELECT hr2.RaceID
    FROM Horse AS h2
    INNER JOIN Horse_Race AS hr2
        ON h2.HorseID = hr2.HorseID
    WHERE h2.HorseName = 'Rubi Light'
    LIMIT 1
)
ORDER BY
    CASE
        WHEN hr.FinishPosition GLOB '[0-9]*'
        THEN CAST(hr.FinishPosition AS INTEGER)
        WHEN hr.FinishPosition = 'BD' THEN 998
        WHEN hr.FinishPosition = 'F' THEN 999
        WHEN hr.FinishPosition = 'PU' THEN 1000
        WHEN hr.FinishPosition = 'UR' THEN 1001
        ELSE 1002
    END,
    h.HorseName;