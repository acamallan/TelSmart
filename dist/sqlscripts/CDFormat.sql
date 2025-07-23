CREATE or replace FUNCTION CDFormat (dateString Varchar) return varchar is
begin

     begin
          RETURN concat(right(dateString,4),concat(MID(dateString,4,2),left(dateString,2)));
     end;

end CDFormat;
