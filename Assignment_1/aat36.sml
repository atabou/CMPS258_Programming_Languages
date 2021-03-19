

fun score( student_record: int*string*real*real ) = 0.4 * (#3 student_record) + 0.6 * (#4 student_record)


fun scores( student_list: (int*string*real*real) list ) =
    
    if null student_list
    then []
    else ( #1 ( hd student_list ), score(hd student_list) ) :: scores( tl student_list )


fun getByID( student_list: (int*string*real*real) list, i: int ) = 
    
    if #1 (hd student_list) = i
    then hd student_list
    else getByID(tl student_list, i)


fun whoFailedMidterm( student_list: (int*string*real*real) list ) =

    if null student_list
    then []
    else if #3 (hd student_list) < 60.0 
         then #2 (hd student_list) :: whoFailedMidterm( tl student_list ) 
         else whoFailedMidterm( tl student_list ) 


fun allPassedFinal( student_list: (int*string*real*real) list ) =
    
    if null student_list
    then true
    else ( not (#4 (hd student_list) < 60.0) ) andalso allPassedFinal( tl student_list )


fun countPassedCourse ( student_list: (int*string*real*real) list ) =

    if null student_list
    then 0
    else 
        if score(hd student_list) < 60.0 
        then countPassedCourse(tl student_list) 
        else 1 + countPassedCourse( tl student_list )


fun studentsInRange( student_list: (int*string*real*real) list, range: real*real ) =
    if null student_list
    then []
    else
        if not ( score( hd student_list ) < #1 range orelse score( hd student_list ) > #2 range )
        then ( hd student_list ) :: studentsInRange( tl student_list, range )
        else studentsInRange( tl student_list, range )


fun countStudentsInRange (student_list: (int*string*real*real) list, ranges: (real*real) list ) =

    if null student_list
    then 0
    else 
        let

            fun isInside( student: (int*string*real*real), ranges: (real*real) list) = 
                if null ranges
                then false
                else not ( score( student ) < #1 (hd ranges) orelse score( student ) > #2 ( hd ranges ) ) orelse isInside( student, tl ranges )
            
            val is_inside = isInside( hd student_list, ranges )
        
        in

            if is_inside 
            then countStudentsInRange( tl student_list, ranges ) + 1
            else countStudentsInRange( tl student_list, ranges )

        end


fun studentWithHighestScore ( student_list: (int*string*real*real) list ) =

    if null student_list
    then (~1, "", ~1.0, ~1.0)
    else
        let

            val current = studentWithHighestScore( tl student_list )
        
        in
        
            if score( hd student_list ) > score( current ) then hd student_list else current
        
        end


fun insertAssignmentGrade ( student_list: (int*string*real*real) list, assignment_grades: real list ) =

    if null student_list
    then []
    else ( #1 (hd student_list), #2 (hd student_list), hd assignment_grades, #3 (hd student_list), #4 (hd student_list) ) :: insertAssignmentGrade( tl student_list, tl assignment_grades )



