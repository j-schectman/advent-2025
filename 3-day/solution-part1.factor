USING: io io.files kernel math math.parser sequences ;
IN: 3-day

: pair-index ( num-arr -- hash )
    [ 2array ] map-index
    [ first ] inv-sort-by
    ;

: is-end ( length ind -- bool ) 
    1 - >=
    ;

: filter-higher-indexes ( ind array -- lower-arr ) 
    swap [ second < ] with filter
    ;

: get-second-number ( arr -- next )
    ! get index of biggest
    dup first second
    filter-higher-indexes
    [ first ] inv-sort-by
    first first
    ;
    
: solve ( -- )
    "./input.txt" utf8 file-lines [
        dup length swap
        [ 1string string>number ] { } map-as
        pair-index
        dup first second rot is-end 
         [ 
             [ second first ] [ first first ] bi 
         ] [
             [ first first ] [ get-second-number ] bi 
         ] if
         2array
         [ number>string ] map "" join string>number
    ] map
    sum
    .
    ;

MAIN: solve

