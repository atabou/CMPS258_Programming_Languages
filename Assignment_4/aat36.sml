

val score  = 
    fn (id, name, grade_1, grade_2) => 0.4*grade_1 + 0.6*grade_2


val scores = 
    fn student_list =>
        List.foldl( 
            fn ( (id, name, grade_1, grade_2), acc ) => ( id, score(id, name, grade_1, grade_2) ) :: acc
        ) [] student_list


val whoFailedMidterm =
    fn student_list =>    
        List.foldl(
            fn ( (id, name, grade_1, grade_2), acc ) => name :: acc
        ) [] ( List.filter( fn (id, name, grade_1, grade_2) => grade_1 < 60.0) student_list )


val allPassedFinal =
    fn student_list =>
        List.foldl(
            fn ( (id, name, grade_1, grade_2), acc ) => not(grade_2 < 60.0) andalso acc
        ) true student_list


val countPassedCourse = 
    fn student_list => 
        List.foldl(
            fn ( (id, name, grade_1, grade_2), acc ) => if score(id, name, grade_1, grade_2) < 60.0 then acc else 1 + acc
        ) 0 student_list


val studentsInRange =
    fn student_list =>
        fn (low, high) =>
            List.filter(
                fn (id, name, grade_1, grade_2) =>  score (id,name,grade_1,grade_2) > low andalso score (id, name,grade_1,grade_2) < high
            ) student_list

