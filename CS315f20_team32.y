%token DRONE PROGRAM_BEGIN PROGRAM_END TIMER TYPE_STRING TYPE_FLOAT TYPE_INT TYPE_BOOL CONST RETURN IF ELSE TRUE FALSE WHILE_LOOP FOR_LOOP PRINT_STATEMENT OR AND NOT VOID_FUNC WIFI_IDENTIFIER INCLINE_FUNC ALTITUDE_FUNC ACCEL_FUNC TEMPR_FUNC ON_FUNC OFF_FUNC PICTURE_FUNC CAPTURE_FUNC CONNECT_FUNC MAIN_FUNC TIME_FUNC TIMER_FUNC FOR_LOOP VARIABLE INTEGER COMMA BELONGS ADD SUBTRACT DIVIDE MULTIPLY LP RP LC RC LSQ  END_STATEMENT RSQ BIGGER_THAN LESS_THAN BIGGER_EQUAL LESS_EQUAL EQUAL NOT_EQUAL  SEMI_COL ASGN_OP COMMENT QUOTE %right '='
%right '='
%left '+' '-'
%left '#''|'
%%
start: program
;
program:		PROGRAM_BEGIN functions PROGRAM_END 
			|
;
functions:		functions function | function 
;
function:		ident_type function_name LSQ parameter_list RSQ END_STATEMENT body
;
func_start:		function_name LSQ parameter_list RSQ
;
function_name:	VARIABLE
;
parameter_list:		ident_type parameter COMMA LESS_THAN parameter_list			 		BIGGER_THAN 
| ident_type  parameter
|
;
parameter:		variable
;
variable:		VARIABLE | CONST
;
body:			stmts RETURN variable
;
stmts:			stmt
| stmt stmts
| COMMENT stmts
| stmts COMMENT
;
stmt:			matched | unmatched
;
matched:		IF log_stmts END_STATEMENT matched ELSE END_STATEMENT				matched

                     		| non_if_stmts
;
unmatched:		IF log_stmts END_STATEMENT stmt
			| IF log_stmts END_STATEMENT matched ELSE END_STATEMENT				unmatched
;
non_if_stmts:		assignment
| primitive_func
| WHILE_LOOP
| FOR_LOOP
| PRINT_STATEMENT
;
primitive_func:	inclination
                               	| altitude
                               	| temperature 
                               	| acceleration 
                               	| camera_on        
                               	| camera_off
                               	| picture
                               	| capture
                               	| connect
                               	| time
                               	| get_timer
;
while_loop: WHILE log_stmts END_STATEMENT stmts
                      | WHILE comparison END_STATEMENT stmts
;
for: FOR_LOOP ident_type var COMMA comparison COMMA assignment END_STATEMENT stmts
;
inclination:		INCLINE_FUNC LSQ RSQ
;
altitude:		ALTITUDE_FUNC LSQ RSQ END_STATEMENT
;
temperature:		TEMPR_FUNC LSQ RSQ END_STATEMENT
;
acceleration:		ACCEL_FUNC LSQ RSQ END_STATEMENT
;
camera_on:		ON_FUNC LSQ variable RSQ END_STATEMENT
;
camera_off:		OFF_FUNC LSQ variable RSQ END_STATEMENT
;
picture:		ident_type PICTURE_FUNC LSQ variable RSQ END_STATEMENT
;
capture:		ident_type CAPTURE_FUNC LSQ RSQ END_STATEMENT
;
connect:		ident_type CONNECT_FUNC LSQ variable COMMA variable RSQ			 	END_STATEMENT
;
time:			ident_type TIME_FUNC LSQ variable RSQ END_STATEMENT
;
get_timer:		ident_type TIMER_FUNC LSQ variable RSQ END_STATEMENT
;
log_stmts:		log_stmts OR and_cond
                          	| and_cond
;
and_cond:		and_cond AND not_cond
                      		| not_cond
;
not_cond:		NOT log_stmts
                      		| log_stmts 
;
assignment:		ident_type var ASGN_OP log_stmts
                        	| ident_type var ASGN_OP math_expr
                        | ident_type var ASGN_OP var BELONGS func_start
                        | ident_type var ASGN_OP dronic
			| var ASGN_OP var
| var  ASGN_OP log_stmts
| var ASGN_OP math_expr		
		| var ASGN_OP VARIABLE BELONGS func_start
;
comparison: var BIGGER_THAN var
	| dronic BIGGER_THAN dronic
	|var LESS_THAN var
	| dronic LESS_THAN dronic
	|var BIGGER_EQUAL var
	| dronic BIGGER_EQUAL dronic
	|var LESS_EQUAL var
	| dronic LESS_EQUAL dronic
	|var EQUAL var
	| dronic EQUAL dronic
	|var NOT_EQUAL var
	| dronic NOT_EQUAL dronic
;
var:			VARIABLE
;
math_expr:		math_expr ADD term
			| math_expr SUBTRACT term
			| term
;
term:			term MULTIPLY factor
			| term | factor
			| factor
;
factor:		 
			| ADD factor
			| SUBTRACT factor
;
print:			print LSQ dronic RSQ
              		| print LSQ log_stmts RSQ
            	| print LSQ primitive_func RSQ
              		| print LSQ variable RSQ
;
input: 
;
dronic:			TYPE_STRING
                    		| TYPE_FLOAT
                    		| TYPE_INT
                    		| TYPE_BOOL
;
ident_type:		TYPE_INT | TYPE_BOOL | TYPE_FLOAT | TYPE_STRING | VOID_FUNC | DRONE | TIMER |
;
%%
#include "lex.yy.c"
extern int lineCounter;
int main(){
yyparse();
printf("Valid Input");
return 0;
}
int yyerror(const char *s){fprintf(stderr, "%s in line %d\n", s, lineCounter); }