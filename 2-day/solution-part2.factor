USING: io io.encodings.utf8 io.files kernel math math.parser
prettyprint ranges sequences sets splitting grouping ;
IN: 2-day

: get-ranges ( line -- seq-ranges ) 
    "," split
    [ "-" split ] map
    ;

: is-dup-group ( num group-group-size  -- bool ) 
    group dup first '[ _ = ] all?
    ;

: is-dup ( num -- duped? )
    dup length dup dup 2 < [ drop drop drop f ]
    [
        2 /i 1 swap [a..b]
        swap '[ _ swap mod 0 = ] filter
        swap '[ _ swap is-dup-group ] any?
    ] if
    ;
    
: update-h ( dup? val hash -- hash ) 
    [ over adjoin ] [ drop ] if
    ;

: get-invalid ( range the-set -- seq-ranges )
    [ first string>number ] [ second string>number ] bi
    [a..b] swap [ dup number>string is-dup update-h ] reduce
    ;

: solve ( -- )
    "./input.txt" utf8 file-lines first get-ranges
    HS{ } clone [ get-invalid ] reduce members sum
    .
    ;

MAIN: solve
