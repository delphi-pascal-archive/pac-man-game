unit Search;

interface
Const R=17; //определяет размерность карты;
const Stena = 300;
const Mini = R*R;
const Tk=R*R+1;
type TMap=record //Тип КАРТА
 XY:array[1 .. R, 1 .. R] of Integer;
end;
 Type TPUT=record //Тип Путь
DX:integer ;
DY: integer ;
End;

TArrayPut=record
Puti:array of TPut;
KOL:Integer;
end;

TMP=array of TPUT;

Function Poisk(NX, NY,KX, KY:Integer; var MAP:TMAP; out P:TArrayPut):Boolean;
implementation
Function Poisk(NX, NY,KX, KY:Integer; var MAP:TMAP; out P:TArrayPut):Boolean;
var
i,j,ii,jj,k,n,m,xx:integer;
MP:TMP;
COPYMAP:TMAP;
Flag:Boolean;
min:integer;
MN:single; //Минимальная длина между точкой начала и смежных точек
Rad:single;
begin
n:=0;
k:=0;
m:=0;
setlength(MP,MINI);
COPYMAP:=MAP;
COPYMAP.XY[nx,ny]:=1;
COPYMAP.XY[kx,ky]:=tk;
MP[0].DX:=NX;
MP[0].DY:=NY;
min:=MINI;
repeat
flag:=false;
for i:=n to k do
    For ii := -1 To 1 do
        For jj := -1 To 1 do
            If ((ii =0) Xor (jj = 0)) Then
                If (MP[i].DX + ii >= 1) And (MP[i].DX + ii <= R) And (MP[i].DY + jj >= 1) And (MP[i].DY + jj <= R) Then
                        If COPYMAP.XY[MP[i].DX + ii, MP[i].DY + jj] = 0 Then begin m:=m+1;MP[m].DX:=MP[i].DX + ii;MP[m].DY:=MP[i].DY + jj; COPYMAP.XY[MP[i].DX + ii, MP[i].DY + jj] := COPYMAP.XY[MP[i].DX, MP[i].DY] + 1; Flag := True; end;

n:=k+1;
k:=m;
until  flag=false;

 For ii := -1 To 1 do
    For jj := -1 To 1 do
        If (KX + ii >= 1) And (KX + ii <= R) And (KY + jj >= 1) And (KY + jj <= R) And ((ii = 0) Xor (jj = 0)) Then
            If  (COPYMAP.XY[kx + ii, ky + jj] <> 0) And (COPYMAP.XY[kx + ii, ky + jj] <> stena) Then If min > COPYMAP.XY[kx + ii, ky + jj] Then begin min := COPYMAP.XY[kx + ii, ky + jj] +1;result := True; end ;

 if result=true then
    begin
        p.KOL :=min;
//освобождение от ресурсов
        p.Puti:=nil;
//выделение ресурсов
        setlength(p.Puti,min+1);
        p.Puti[min].DX := KX ;
        p.Puti[min].DY := KY ;

        for min:=P.KOL downto 1  do
            begin
                MN := mini;
                For i := -1 To 1 do
    			    For j := -1 To 1 do
                        begin
                            If (p.Puti[min].DX + i >= 1) And (p.Puti[min].DX + i <= R) And (p.Puti[min].DY + j >= 1) And (p.Puti[min].DY + j <= R) And ((i = 0) xor (j = 0)) Then
                                begin
                                    xx := COPYMAP.XY[p.Puti[min].DX + i, p.Puti[min].DY + j];
                                    If xx = min - 1 Then
                                        begin
                                            Rad:=Sqrt(sqr((p.Puti[min].DX + i) - KX)  + sqr((p.Puti[min].DY + j) - KY) );
                                            If MN >Rad  Then
                                                begin
                                                    MN := Rad; p.Puti[xx].DX := p.Puti[min].DX + i; p.Puti[xx].DY := p.Puti[min].Dy + j;
                                                end;
                                        end;
                                end;
                        end;
            end;


 end;
mp:=nil;
 end;


end.
