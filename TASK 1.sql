SELECT
    h.HorseName,
    m.MeetingDate,
    c.CourseName,
    r.Title AS RaceTitle,
    r.ScheduledTime,
    r.DistanceText,
    r.Going,
    hr.FinishPosition,
    hr.CloseUp
FROM Horse AS h
INNER JOIN Horse_Race AS hr
    ON h.HorseID = hr.HorseID
INNER JOIN Race AS r
    ON hr.RaceID = r.RaceID
INNER JOIN Meeting AS m
    ON r.MeetingID = m.MeetingID
INNER JOIN Course AS c
    ON m.CourseID = c.CourseID
WHERE h.HorseName = 'Rubi Light'
ORDER BY
    m.MeetingDate,
    r.ScheduledTime;