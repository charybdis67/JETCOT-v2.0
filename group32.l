integer [0-9]+
letters [a-zA-Z]+
float [0-9]+\.[0-9]+
%{
int lineCounter = 1;
%}
%%
Drone            return(DRONE );
begin            return(PROGRAM_BEGIN );
end              return(PROGRAM_END );
Timer            return(TIMER );
string           return(TYPE_STRING );
float            return(TYPE_FLOAT );
int              return(TYPE_INT );
boolean          return(TYPE_BOOL );
const            return(CONST );
this             return(RETURN );
if               return(IF );
else             return(ELSE );
true             return(TRUE );
false            return(FALSE );
while            return(WHILE_LOOP );
for			     return(FOR_LOOP );
print            return(PRINT_STATEMENT );
or               return(OR );
and              return(AND );
not              return(NOT );
nada             return(VOID_FUNC );
wifiPassword     return(WİFİ_IDENTIFIER );
readIncline      return(INCLINE_FUNC );
readAltitude     return(ALTITUDE_FUNC );
readAcceleration return(ACCEL_FUNC );
readTemperature  return(TEMPR_FUNC );
turnOnCamera     return(ON_FUNC );
turnOffCamera    return(OFF_FUNC );
takePicture      return(PICTURE_FUNC );
capture          return(CAPTURE_FUNC );
connect          return(CONNECT_FUNC );
main             return(MAIN_FUNC );
readTime         return(TIME_FUNC );
getTimer         return(TIMER_FUNC );
for              return(FOR_LOOP );
{letters}        return(VARIABLE );
{integer}        return(INTEGER );
\,               return(COMMA );
\.               return(BELONGS );
\<               return(SMALLER_THAN );
\>               return(BIGGER_THAN );
\+               return(ADD );
\-               return(SUBTRACT );
\|               return(DIVIDE );
\#               return(MULTIPLY );
\(               return(LP );
\)               return(RP );
\{               return(LC );
\}               return(RC );
\[               return(LSQ );
\:               return(END_STATEMENT );
\]               return(RSQ );
\>               return(BIGGER_THAN );
\<               return(LESS_THAN );
\>=              return(BIGGER_EQUAL );
\<=              return(LESS_EQUAL );
\==              return(EQUAL );
\!=               return(NOT_EQUAL );
\;               return(SEMI_COL );
\=               return(ASGN_OP );
$.+\$            return(COMMENT );
\"               return(QUOTE);
\n               {lineCounter++;}
.;
%%
int yywrap(){return 1;}
