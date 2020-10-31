%token IF ELSE DRONE PROGRAM_BEGIN PROGRAM_END TYPE_STRING TYPE_FLOAT TYPE_INT TYPE_BOOL RETURN TRUE FALSE WHILE_LOOP OR AND NOT PRINT_STATEMENT VOID FUNC WİFİ_IDENTIFIER INCLINE_FUNC ALTITUDE_FUNC ACCEL_FUNC TEMPR_FUNC ON_FUNC OFF_FUNC PICTURE_FUNC CAPTURE_FUNC CONNECT_FUNC MAIN_FUNC TIME_FUNC TIMER_FUNC VARIABLE INTEGER COMMA BELONGS SMALLER_THAN BIGGER_THAN ADD SUBTRACT DIVIDE MULTIPLY LP RP LC RC LSQ  END_STATEMENT RSQ SEMI_COL ASGN_OP COMMENT QUOTE
%%
program:		PROGRAM_BEGIN functions PROGRAM_END 
			|

functions:		functions function | function 

function:		ident_type function_name LSQ parameter list RSQ END_STATEMENT				body

func_start:		function_name LSQ parameter_list RSQ

function_name:	VARIABLE

parameter_list:		ident_type parameter COMMA SMALLER_THAN parameter_list			 		BIGGER_THAN 
| ident_type  parameter
|

parameter:		variable

variable:		VARIABLE | CONST?

body:			stmts RETURN variable

stmts:			stmt
| stmt stmts
| COMMENT stmts
| stmts COMMENT

stmt:			matched | unmatched

matched:		IF logic_expr END_STATEMENT matched ELSE END_STATEMENT				matched

                     		| non-if_stmts

unmatched:		IF logic_expr END_STATEMENT stmt
			| IF logic_expr END_STATEMENT matched ELSE END_STATEMENT				unmatched

non-if_stmts:		assignment
| primitive_func
| WHILE_LOOP
| FOR_LOOP
| PRINT_STATEMENT

primitive_func:	inclination
                               	| altitude
                               	| temperature 
                               	| acceleration 
                               	| camera-on        
                               	| camera-off
                               	| picture
                               	| capture
                               	| connect
                               	| time
                               	| get-timer

inclination:		INCLINE_FUNC LSQ RSQ

altitude:		ALTITUDE_FUNC LSQ RSQ END_STATEMENT

temperature:		TEMPR_FUNC LSQ RSQ END_STATEMENT

acceleration:		ACCEL_FUNC LSQ RSQ END_STATEMENT

camera-on:		ON_FUNC LSQ variable RSQ END_STATEMENT

camera-off:		OFF_FUNC LSQ variable RSQ END_STATEMENT

picture:		ident_type PICTURE_FUNC LSQ variable RSQ END_STATEMENT

capture:		ident_type CAPTURE_FUNC LSQ RSQ END_STATEMENT

connect:		ident_type CONNECT_FUNC LSQ variable COMMA variable RSQ			 	END_STATEMENT

time:			ident_type TIME_FUNC LSQ variable RSQ END_STATEMENT

get-timer:		ident_type TIMER_FUNC LSQ variable RSQ END_STATEMENT

log_stmts:		log_stmts OR and_cond
                           	| and_cond

and_cond:		and_cond AND not_cond
                      		| not_cond

not_cond:		NOT log_stmts
                      		| log_stmts 

assignment:		ident_type var ASGN_OP log_stmts
                        	| ident_type var ASGN_OP math_expr
                        | ident_type var ASGN_OP var BELONGS func_start
                        | ident_type var ASGN_OP dronic>
			| var ASGN_OP var
| var  ASGN_OP log_stmts
| var ASGN_OP math_expr		
		| var ASGN_OP VARIABLE BELONGS func_start

var → 			VARIABLE

math_expr:		math_expr + term
			| math_expr - term
			| term

term:			term MULTIPLY factor
			| term | factor
			| factor

factor:		 
			| ADD factor
			| SUBTRACT factor

print:			print LSQ dronic RSQ
              		| print LSQ log_stmts RSQ
            	| print LSQ primitive_func RSQ
              		| print LSQ variable RSQ
 
input: 

dronic:			TYPE_STRING
                    		| TYPE_FLOAT
                    		| TYPE_INT
                    		| TYPE_BOOL

ident_type:		TYPE_INT | TYPE_BOOL | TYPE_FLOAT | TYPE_STRING | VOID_FUNC | DRONE | Timer |