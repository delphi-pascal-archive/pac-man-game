unit PuckMen;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ActnMan, ActnCtrls, ActnMenus,
  XPStyleActnCtrls, Menus,StdCtrls,SeARCH , ExtCtrls, ImgList,
  ActnColorMaps;
type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Timer1: TTimer;
    Image3: TImage;
    Image1: TImage;
    Label1: TLabel;
    XPColorMap1: TXPColorMap;
    Image2: TImage;
    Label2: TLabel;
    procedure Action4Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
   
 procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);                                
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    { Private declarations }
     Procedure Paint();
     Procedure LoadLevel();
     Procedure Death();
     Procedure ReLoad();
  public
    { Public declarations }
  end;
 const SH = 0.1;
  var
  Form1: TForm1;
  Road:array[1..4] of TArrayPut; {� ���� ���������� �������� ����}
  XY:TMap;{�����}
  {���������� �����}
  XP,YP:array[1..4] of currency;
    fv:array[1..4] of boolean;
  CL:integer;
  BX:array[1..4] of integer;
  BY:array[1..4] of integer;
  RB:array[1..4] of currency ;
  CB:array[1..r*r] of TPUT;
  BBB:TBitMAp;
   clb:integer;
  {���������� ������}
  XI,YI:currency;
  BPOL:TBitMap; {����������� ����������� ����}
  BMAP:TBitMap; {����������� ����� �������� ��������}
  BIT:TBitMap;{����������� ���������}
  BOT:array[1..4] of TBitMap; {����������� ����}
  Player:TBitMap;{����������� ������}
  BON:TBitMap; {����������� ���������� �����}
  Col:array[1..r,1..r] of integer;{����� ������������ ���������� ����� }
  Ran:integer;
i,j,PXY,xx,t,cc,l,Liv:integer;{��������������� ����������}
  F:file of TMAP;{�������������� ���� ����}
  implementation
  {$R IMG.res}
{$R *.dfm}
//----------------------------------------------------------------------------------------------
Procedure TForm1.Reload(); //��������� ������������ ����
 begin
 L:=1;
 LoadLevel;
end;
//---------------------------------------------------------------------------
Procedure TForm1.Death();//���������, ����������� ��� "������ ������"
begin
  randomize;
 Timer1.Enabled :=false ;
 Action2.Enabled:=false;
 Action3.Enabled:=true;
 liv:=liv-1; //���������� ����� �� �������
 //����� ����������� ������
 Image1.Canvas.FillRect(Rect(0,0,90,30));  
 For i:=(4-liv) to 3 do
    Image1.Canvas.Draw((i)*30-30,0,Player);
 Application.MessageBox('��� �������', '����',MB_OK);
//��������� ��������� � ���������, � ������� ������������ ������ ���� ������
 if liv=0 then
    begin
        if Application.MessageBox('�� ���������, ������ ������  ������?','����',MB_YESNO) =6 then ReLoad else Application.Terminate;
    end;
PXY:=0;

//���������� ������ � "�����" ��������� ��������� ��������
 XP[1] := 7;
 YP[1] := 9;
 XP[2] := 8;
 YP[2] := 9;
 XP[3] := 10;
 YP[3] := 9;
 XP[4] := 11;
 YP[4] := 9;
 XI := 9;
 YI := 17;
 for i:=1 to 4  do
     begin
      rb[i]:=sh;
      ran:=1+random(cl-1);
 bx[i]:=cb[ran].DX;
 by[i]:=cb[ran].Dy ;
     Poisk (round(XP[i]), round(YP[i]), BX[i], BY[i], XY, Road[i]) ;
     end;
 Paint;
end;

//---------------------------------------------------------------------------
procedure TForm1.LoadLevel();
//�������� ���������� ������


begin
 randomize;
 Action2.Enabled:=false;
 Action3.Enabled:=true;
 Timer1.Enabled :=false;
 cl:=0;
 liv:=3;
PXY:=0;
//���������� ������ � "�����" ��������� ��������� ��������
 XP[1] := 7;
 YP[1] := 9;
 XP[2] := 8;
 YP[2] := 9;
 XP[3] := 10;
 YP[3] := 9;
 XP[4] := 11;
 YP[4] := 9;
 XI := 9;
 YI := 17;
//��������� � ���, ��� �� ��������
 if l>3 then
    begin
        Application.MessageBox('�� ��������!!!','����',MB_OK);
        Reload;
        exit;
    end;
 label2.Caption := IntToStr(l);
//���������� ������ � ����� � ���������� XY
 AssignFile(f,'LEVEL\MAP' + IntToStr(l) + '.DAT') ;
 reset(f);
 Read(f,XY);
 CloseFile(f);
//������������ ����������� ����
 Bit.LoadFromResourceName(HInstance,'PLIT' + intToStr(l));
 BMAP.Canvas.StretchDraw(rect(0,0,510,510),BPOL);
 For i:=1 to r do
    for j:=1 to r do
        begin
            if XY.XY[i,j]=300 then BMAP.Canvas.draw(i*30-30,j*30-30,BIT) else begin cl:=cl+1;cb[cl].DX:=i;cb[cl].DY:=j;  BMAP.Canvas.draw(i*30-30,j*30-30,Bon); end ;
        end;
 clB:=cl;
for i:=1 to 4  do
     begin
        rb[i]:=sh;
        ran:=1+random(clb-1);
        bx[i]:=cb[ran].DX;
        by[i]:=cb[ran].Dy ;
        Poisk (round(XP[i]), round(YP[i]), BX[i], BY[i], XY, Road[i]) ;
     end;
//��������� �������� ����� �������
 for i:=1 to r do
    for j:=1 to r do
        col[i,j]:=0;
//����� ����������� ������
 Image1.Canvas.FillRect(Rect(0,0,90,30));
 For i:=1 to liv do
    Image1.Canvas.Draw(i*30-30,0,Player);
 Paint;
end;
//---------------------------------------------------------------------------
procedure TForm1.Paint();
//����� �������� �����������
 Var n:integer;
 begin
//�����  ������� ����������� ������� �� Image3
Image3.Picture.Graphic :=BMAp;
//�����  �������� ����������� ������ �� Image3
Image3.Canvas.StretchDraw(Rect(trunc(xi*30),trunc(yi*30)-30,trunc(xi*30)-30,trunc(yi*30)),Player) ;
//�����  ������� ����������� ����� �� Image3
 if col[round(xi),round(yi)]=0  then begin col[round(xi),round(yi)]:=1 ;bmap.Canvas.CopyRect( Rect(round(xi)*30,round(yi)*30,round(xi)*30-30,round(yi)*30-30),bpol.Canvas, Rect(round(xi)*30,round(yi)*30,round(xi)*30-30,round(yi)*30-30));cl:=cl-1;end;
for n:=1 to 4 do
    Image3.Canvas.StretchDraw(rect(trunc(xp[n]*30),trunc(yp[n]*30-30),trunc(xp[n]*30-30),trunc(yp[n]*30)),Bot[n]);


 // �������� �� ��������� ���� �������
 if cl=0 then
    begin
 		l:=l+1;            
        LoadLevel;
 	end;
 end;

//---------------------------------------------------------------------------
procedure TForm1.Action4Execute(Sender: TObject); // ����� �� ���������
begin
 Application.Terminate;
end;
//---------------------------------------------------------------------------
procedure TForm1.Action2Execute(Sender: TObject); //��������� ���� (�����)
begin
 Action2.Enabled:=false;
 Action3.Enabled:=true;
 Timer1.Enabled:=false;
end;
//---------------------------------------------------------------------------
procedure TForm1.Action3Execute(Sender: TObject); //����� ���� �� �����
begin
 Action3.Enabled:=false;
 Action2.Enabled:=true;
 Timer1.Enabled:=True;                
end;                        
//---------------------------------------------------------------------------
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState); //���������� ���� 
begin
 Timer1.Enabled := True;
 Action3.Enabled:=false;                             
 Action2.Enabled:=true;
 //���������� ��� ����, ����� ����� �� �������� "���������"

  If Key = 39 Then if (xy.XY[trunc((Xi+1)), round(Yi)] <> 300) And (XI < R) and (yi =trunc(yi)) then begin  PXY:= 1;xx:=0 end else xx:=1;
 If Key = 37 Then if (xy.XY[trunc((Xi - SH)), round(Yi)] <> 300) And (Xi > 1) and (yi =trunc(yi)) then  begin  PXY := 2;xx:=0 end else xx:=2;
 If Key = 38 Then If (xy.XY[round(XI), trunc(Yi-SH)] <> 300) And (Yi > 1) and (xi =trunc(xi)) Then   begin PXY := 3;xx:=0  end else xx:=3;
 If Key = 40 Then if (xy.XY[round(XI), trunc(YI + 1)] <> 300) And (YI < R)and (xi =trunc(xi))  then   begin   PXY := 4;xx:=0 end else xx:=4;

end;

//---------------------------------------------------------------------------
procedure TForm1.FormCreate(Sender: TObject); // ��������� �������� ��� ���������� ���� TBitMap, � �� ���������
begin

//�������� ����������� ������
 Player:=TBitMap.Create;
 Player.LoadFromResourceName(HInstance,'PLR');
 Player.Transparent:=true;
    Player.TransparentColor:=clwhite;

//�������� ����������� �����������
 Bit:=TBitMap.Create;
  Bit.Transparent:=true;
   Bit.TransparentColor:=clwhite;
 //�������� ����������� ����������� ����

 BPOL:=TBitMap.Create;
 BPOL.LoadFromResourceName(HInstance,'POL');
bbb:=TBitMap.Create;
bbb.LoadFromResourceName(HInstance,'POL');
 //�������� ����������� ����
 BMAP:=TBitMap.Create;
 BMAP.Transparent:=true;
 BMAP.Width :=510;
 BMAP.Height:=510;
//�������� ����������� ������
 Bon:=TBitMap.Create;
 Bon.LoadFromResourceName(HInstance,'COL');
  Bon.Transparent:=true;
   bon.TransparentColor:=clwhite;
 //�������� �����������  �����
for i:=1 to 4 do
    begin
        BOT[i]:=TBitMap.Create;
 	    Bot[i].Transparent:=true;
 	    bot[i].TransparentColor:=clwhite;
        BOT[i].LoadFromResourceName(HInstance,'BOT'+intToStr(i));

    end;
 L:=1;
 LoadLevel;
 Paint;
end;
//---------------------------------------------------------------------------
procedure TForm1.Timer1Timer(Sender: TObject); //���������� ���� ������� ����
begin
 //������������� �������� �����
 randomize;
 for i:=1 to 4 do
    begin
        if (round(xp[i])=bx[i]) and (round(yp[i])=by[i]) then begin
             ran:=1+random(clb-1);
 bx[i]:=cb[ran].DX;
 by[i]:=cb[ran].Dy ;
         end;
   if sqrt(sqr(xi -xp[i])+sqr(yi -yp[i]))<0.8  then begin ;death;exit;end; //1 - �  �������� �� ������.
        RB[i]:=RB[i]-sh;
         if RB[i]<sh then
            begin
                RB[i]:=1;
                FV[i]:= Poisk (round(XP[i]), round(YP[i]), BX[i], BY[i], XY, Road[i]) ;
            end;

        if FV[i]=true then
            begin
                XP[i] :=Road[i].PUTI[2].DX + rb[i]*(Road[i].PUTI[1].DX-Road[i].PUTI[2].DX) ;
                YP[i] :=Road[i].PUTI[2].DY + rb[i]*(Road[i].PUTI[1].DY-Road[i].PUTI[2].DY);
            end;
    end;





//������������� �������� ������

        if (xx=1) and  (xy.XY[trunc((Xi+1)), round(Yi)] <> 300) And (XI < R) then if yi=trunc(yi) then  begin pxy:=1;xx:=0; end;
        if (xx=2) and  (xy.XY[trunc((Xi - SH)), round(Yi)] <> 300) And (Xi > 1) then if yi=trunc(yi) then  begin pxy:=2;xx:=0; end;
        if (xx=3) and  (xy.XY[round(XI), trunc(Yi-SH)] <> 300) And (Yi > 1) then if xi=trunc(xi) then  begin pxy:=3;xx:=0; end;
        if (xx=4) and  (xy.XY[round(XI), trunc(YI + 1)] <> 300) And (YI < R) then if xi=trunc(xi) then  begin pxy:=4;xx:=0; end;
        If (PXY = 1)  Then  If  (xy.XY[trunc((Xi+1)), round(Yi)] <> 300) And (XI < R)Then   begin XI := XI + SH end  else xx:=0;
        If (PXY = 2)  Then If (xy.XY[trunc((Xi - SH)), round(Yi)] <> 300) And (Xi > 1)Then begin  XI := XI - SH  end else xx:=0;
        If (PXY = 3)  Then If (xy.XY[round(XI), trunc(Yi-SH)] <> 300) And (Yi > 1)Then  begin  YI := YI -SH  end else xx:=0;
        If (PXY = 4)  Then If (xy.XY[round(XI), trunc(YI + 1)] <> 300) And (YI < R)Then  begin  YI := YI + SH end else xx:=0;

 Paint;
end;
//---------------------------------------------------------------------------
procedure TForm1.Action1Execute(Sender: TObject);//����� ����
begin
 Reload;
end;
end.
