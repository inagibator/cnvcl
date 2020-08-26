{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     �й����Լ��Ŀ���Դ�������������                         }
{                   (C)Copyright 2001-2020 CnPack ������                       }
{                   ------------------------------------                       }
{                                                                              }
{            ���������ǿ�Դ���������������������� CnPack �ķ���Э������        }
{        �ĺ����·�����һ����                                                }
{                                                                              }
{            ������һ��������Ŀ����ϣ�������ã���û���κε���������û��        }
{        �ʺ��ض�Ŀ�Ķ������ĵ���������ϸ���������� CnPack ����Э�顣        }
{                                                                              }
{            ��Ӧ���Ѿ��Ϳ�����һ���յ�һ�� CnPack ����Э��ĸ��������        }
{        ��û�У��ɷ������ǵ���վ��                                            }
{                                                                              }
{            ��վ��ַ��http://www.cnpack.org                                   }
{            �����ʼ���master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnPolynomial;
{* |<PRE>
================================================================================
* �������ƣ�������������
* ��Ԫ���ƣ�����ʽ����ʵ�ֵ�Ԫ
* ��Ԫ���ߣ���Х��liuxiao@cnpack.org��
* ��    ע��֧����ͨ����ϵ������ʽ�������㣬����ֻ֧�ֳ�����ߴ���Ϊ 1 �����
*           ֧����������Χ�ڵĶ���ʽ�������㣬ϵ���� mod p ���ҽ���Ա�ԭ����ʽ����
* ����ƽ̨��PWin7 + Delphi 5.0
* ���ݲ��ԣ���δ����
* �� �� �����õ�Ԫ���豾�ػ�����
* �޸ļ�¼��2020.08.21 V1.0
*               ������Ԫ��ʵ�ֹ���
================================================================================
|</PRE>}

interface

{$I CnPack.inc}

uses
  SysUtils, Classes, SysConst, Math, CnNativeDecl;

type
  ECnPolynomialException = class(Exception);

  TCnIntegerList = class(TList)
  {* �����б�}
  private
    function Get(Index: Integer): Integer;
    procedure Put(Index: Integer; const Value: Integer);
  public
    function Add(Item: Integer): Integer; reintroduce;
    procedure Insert(Index: Integer; Item: Integer); reintroduce;
    property Items[Index: Integer]: Integer read Get write Put; default;
  end;

  TCnIntegerPolynomial = class(TCnIntegerList)
  {* ��ϵ������ʽ}
  private
    function GetMaxDegree: Integer;
    procedure SetMaxDegree(const Value: Integer);

  public
    constructor Create(LowToHighCoefficients: array of const); overload;
    constructor Create; overload;
    destructor Destroy; override;

    procedure SetCoefficents(LowToHighCoefficients: array of const);
    {* һ���������ôӵ͵��ߵ�ϵ��}
    procedure CorrectTop;
    {* �޳��ߴε� 0 ϵ��}
    function ToString: string; {$IFDEF OBJECT_HAS_TOSTRING} override; {$ENDIF}
    {* ������ʽת���ַ���}
    function IsZero: Boolean;
    {* �����Ƿ�Ϊ 0}
    procedure SetZero;
    {* ��Ϊ 0}
    property MaxDegree: Integer read GetMaxDegree write SetMaxDegree;
    {* ��ߴ�����0 ��ʼ}
  end;

function IntegerPolynomialNew: TCnIntegerPolynomial;
{* ����һ����̬�������ϵ������ʽ���󣬵�ͬ�� TCnIntegerPolynomial.Create}

procedure IntegerPolynomialFree(const P: TCnIntegerPolynomial);
{* �ͷ�һ����ϵ������ʽ���󣬵�ͬ�� TCnIntegerPolynomial.Free}

function IntegerPolynomialDuplicate(const P: TCnIntegerPolynomial): TCnIntegerPolynomial;
{* ��һ����ϵ������ʽ�����¡һ���¶���}

function IntegerPolynomialCopy(const Dst: TCnIntegerPolynomial;
  const Src: TCnIntegerPolynomial): TCnIntegerPolynomial;
{* ����һ����ϵ������ʽ���󣬳ɹ����� Dst}

function IntegerPolynomialToString(const P: TCnIntegerPolynomial;
  const VarName: string = 'X'): string;
{* ��һ����ϵ������ʽ����ת���ַ�����δ֪��Ĭ���� X ��ʾ}

function IntegerPolynomialIsZero(const P: TCnIntegerPolynomial): Boolean;
{* �ж�һ����ϵ������ʽ�����Ƿ�Ϊ 0}

procedure IntegerPolynomialSetZero(const P: TCnIntegerPolynomial);
{* ��һ����ϵ������ʽ������Ϊ 0}

procedure IntegerPolynomialShiftLeft(const P: TCnIntegerPolynomial; N: Integer);
{* ��һ����ϵ������ʽ�������� N �Σ�Ҳ���Ǹ���ָ������ N}

procedure IntegerPolynomialShiftRight(const P: TCnIntegerPolynomial; N: Integer);
{* ��һ����ϵ������ʽ�������� N �Σ�Ҳ���Ǹ���ָ������ N��С�� 0 �ĺ�����}

// =========================== ����ʽ��ͨ���� ==================================

procedure IntegerPolynomialAddWord(const P: TCnIntegerPolynomial; N: Integer);
{* ��һ����ϵ������ʽ����ĳ�ϵ������ N}

procedure IntegerPolynomialSubWord(const P: TCnIntegerPolynomial; N: Integer);
{* ��һ����ϵ������ʽ����ĳ�ϵ����ȥ N}

procedure IntegerPolynomialMulWord(const P: TCnIntegerPolynomial; N: Integer);
{* ��һ����ϵ������ʽ����ĸ���ϵ�������� N}

procedure IntegerPolynomialDivWord(const P: TCnIntegerPolynomial; N: Integer);
{* ��һ����ϵ������ʽ����ĸ���ϵ�������� N���粻��������ȡ��}

procedure IntegerPolynomialNonNegativeModWord(const P: TCnIntegerPolynomial; N: LongWord);
{* ��һ����ϵ������ʽ����ĸ���ϵ������ N �Ǹ�����}

function IntegerPolynomialAdd(const Res: TCnIntegerPolynomial; const P1: TCnIntegerPolynomial;
  const P2: TCnIntegerPolynomial): Boolean;
{* ������ϵ������ʽ������ӣ�������� Res �У���������Ƿ�ɹ���P1 ������ P2��Res ������ P1 �� P2}

function IntegerPolynomialSub(const Res: TCnIntegerPolynomial; const P1: TCnIntegerPolynomial;
  const P2: TCnIntegerPolynomial): Boolean;
{* ������ϵ������ʽ���������������� Res �У���������Ƿ�ɹ���P1 ������ P2��Res ������ P1 �� P2}

function IntegerPolynomialMul(const Res: TCnIntegerPolynomial; P1: TCnIntegerPolynomial;
  P2: TCnIntegerPolynomial): Boolean;
{* ������ϵ������ʽ������ˣ�������� Res �У���������Ƿ�ɹ���P1 ������ P2��Res ������ P1 �� P2}

function IntegerPolynomialDiv(const Res: TCnIntegerPolynomial; const Remain: TCnIntegerPolynomial;
  const P: TCnIntegerPolynomial; const Divisor: TCnIntegerPolynomial): Boolean;
{* ������ϵ������ʽ����������̷��� Res �У��������� Remain �У���������Ƿ�ɹ���
   Res �� Remail ������ nil����������Ӧ�����P ������ Divisor��Res ������ P �� Divisor}

function IntegerPolynomialMod(const Res: TCnIntegerPolynomial; const P: TCnIntegerPolynomial;
  const Divisor: TCnIntegerPolynomial): Boolean;
{* ������ϵ������ʽ�������࣬�������� Res �У����������Ƿ�ɹ���
   Res ������ P �� Divisor��P ������ Divisor}

function IntegerPolynomialPower(const Res: TCnIntegerPolynomial;
  const P: TCnIntegerPolynomial;  Exponent: LongWord): Boolean;
{* ������ϵ������ʽ�� Exponent ���ݣ�������ϵ����������⣬
   ���ؼ����Ƿ�ɹ���Res ������ P}

// ===================== ���������µ���ϵ������ʽģ���� =========================

function IntegerPolynomialGaloisAdd(const Res: TCnIntegerPolynomial; const P1: TCnIntegerPolynomial;
  const P2: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial = nil): Boolean;
{* ������ϵ������ʽ������ P �η�������������ӣ�������� Res �У�
   �����������б�֤ P �������� Res �������ڱ�ԭ����ʽ
   ��������Ƿ�ɹ���P1 ������ P2��Res ������ P1 �� P2}

function IntegerPolynomialGaloisSub(const Res: TCnIntegerPolynomial; const P1: TCnIntegerPolynomial;
  const P2: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial = nil): Boolean;
{* ������ϵ������ʽ������ P �η�������������ӣ�������� Res �У�
   �����������б�֤ P �������� Res �������ڱ�ԭ����ʽ
   ��������Ƿ�ɹ���P1 ������ P2��Res ������ P1 �� P2}

function IntegerPolynomialGaloisMul(const Res: TCnIntegerPolynomial; P1: TCnIntegerPolynomial;
  P2: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial = nil): Boolean;
{* ������ϵ������ʽ������ P �η�������������ˣ�������� Res �У�
   �����������б�֤ P �������ұ�ԭ����ʽ Primitive Ϊ����Լ����ʽ
   ��������Ƿ�ɹ���P1 ������ P2��Res ������ P1 �� P2}

function IntegerPolynomialGaloisDiv(const Res: TCnIntegerPolynomial;
  const Remain: TCnIntegerPolynomial; const P: TCnIntegerPolynomial;
  const Divisor: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial = nil): Boolean;
{* ������ϵ������ʽ������ P �η�����������������̷��� Res �У��������� Remain �У���������Ƿ�ɹ���
   �����������б�֤ P �������ұ�ԭ����ʽ Primitive Ϊ����Լ����ʽ
   Res �� Remail ������ nil����������Ӧ�����P ������ Divisor��Res ������ P �� Divisor}

function IntegerPolynomialGaloisMod(const Res: TCnIntegerPolynomial; const P: TCnIntegerPolynomial;
  const Divisor: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial = nil): Boolean;
{* ������ϵ������ʽ������ P �η��������������࣬�������� Res �У����������Ƿ�ɹ���
   �����������б�֤ P �������ұ�ԭ����ʽ Primitive Ϊ����Լ����ʽ
   Res ������ P �� Divisor��P ������ Divisor}

function IntegerPolynomialGaloisPower(const Res, P: TCnIntegerPolynomial;
  Exponent, Prime: LongWord; Primitive: TCnIntegerPolynomial): Boolean;
{* ������ϵ������ʽ�� P �η����������ϵ� Exponent ���ݣ�
   �����������б�֤ P �������ұ�ԭ����ʽ Primitive Ϊ����Լ����ʽ
   ���ؼ����Ƿ�ɹ���Res ������ P}

implementation

resourcestring
  SCnInvalidDegree = 'Invalid Degree %d';
  SCnErrorDivMaxDegree = 'Only MaxDegree 1 Support for Integer Polynomial.';

// ��װ�ķǸ����ຯ����Ҳ��������Ϊ��ʱ���Ӹ���������
function NonNegativeMod(N: Integer; P: LongWord): Integer;
begin
  Result := N mod P;
  if N < 0 then
    Inc(Result, P);
end;

{ TCnIntegerList }

function TCnIntegerList.Add(Item: Integer): Integer;
begin
  Result := inherited Add(IntegerToPointer(Item));
end;

function TCnIntegerList.Get(Index: Integer): Integer;
begin
  Result := PointerToInteger(inherited Get(Index));
end;

procedure TCnIntegerList.Insert(Index, Item: Integer);
begin
  inherited Insert(Index, IntegerToPointer(Item));
end;

procedure TCnIntegerList.Put(Index: Integer; const Value: Integer);
begin
  inherited Put(Index, IntegerToPointer(Value));
end;

{ TCnIntegerPolynomial }

procedure TCnIntegerPolynomial.CorrectTop;
begin
  while (MaxDegree > 0) and (Items[MaxDegree] = 0) do
    Delete(MaxDegree);
end;

constructor TCnIntegerPolynomial.Create;
begin
  inherited;
  Add(0);   // ��ϵ����
end;

constructor TCnIntegerPolynomial.Create(LowToHighCoefficients: array of const);
begin
  inherited Create;
  SetCoefficents(LowToHighCoefficients);
end;

destructor TCnIntegerPolynomial.Destroy;
begin

  inherited;
end;

function TCnIntegerPolynomial.GetMaxDegree: Integer;
begin
  if Count = 0 then
    Add(0);
  Result := Count - 1;
end;

function TCnIntegerPolynomial.IsZero: Boolean;
begin
  Result := IntegerPolynomialIsZero(Self);
end;

procedure TCnIntegerPolynomial.SetCoefficents(LowToHighCoefficients: array of const);
var
  I: Integer;
begin
  Clear;
  for I := Low(LowToHighCoefficients) to High(LowToHighCoefficients) do
  begin
    case LowToHighCoefficients[I].VType of
    vtInteger:
      begin
        Add(LowToHighCoefficients[I].VInteger);
      end;
    vtBoolean:
      begin
        if LowToHighCoefficients[I].VBoolean then
          Add(1)
        else
          Add(0);
      end;
    vtString:
      begin
        Add(StrToInt(LowToHighCoefficients[I].VString^));
      end;
    else
      raise ECnPolynomialException.CreateFmt(SInvalidInteger, ['Coefficients ' + IntToStr(I)]);
    end;
  end;

  if Count = 0 then
    Add(0)
  else
    CorrectTop;
end;

procedure TCnIntegerPolynomial.SetMaxDegree(const Value: Integer);
begin
  if Value < 0 then
    raise ECnPolynomialException.CreateFmt(SCnInvalidDegree, [Value]);
  Count := Value + 1;
end;

procedure TCnIntegerPolynomial.SetZero;
begin
  IntegerPolynomialSetZero(Self);
end;

function TCnIntegerPolynomial.ToString: string;
begin
  Result := IntegerPolynomialToString(Self);
end;

// ============================ ����ʽϵ�в������� =============================

function IntegerPolynomialNew: TCnIntegerPolynomial;
begin
  Result := TCnIntegerPolynomial.Create;
end;

procedure IntegerPolynomialFree(const P: TCnIntegerPolynomial);
begin
  P.Free;
end;

function IntegerPolynomialDuplicate(const P: TCnIntegerPolynomial): TCnIntegerPolynomial;
begin
  if P = nil then
  begin
    Result := nil;
    Exit;
  end;

  Result := IntegerPolynomialNew;
  if Result <> nil then
    IntegerPolynomialCopy(Result, P);
end;

function IntegerPolynomialCopy(const Dst: TCnIntegerPolynomial;
  const Src: TCnIntegerPolynomial): TCnIntegerPolynomial;
var
  I: Integer;
begin
  Result := Dst;
  if Src <> Dst then
  begin
    Dst.Clear;
    for I := 0 to Src.Count - 1 do
      Dst.Add(Src[I]);
    Dst.CorrectTop;
  end;
end;

function IntegerPolynomialToString(const P: TCnIntegerPolynomial;
  const VarName: string = 'X'): string;
var
  I, C: Integer;

  function VarPower(E: Integer): string;
  begin
    if E = 0 then
      Result := ''
    else if E = 1 then
      Result := VarName
    else
      Result := VarName + '^' + IntToStr(E);
  end;

begin
  Result := '';
  if IntegerPolynomialIsZero(P) then
  begin
    Result := '0';
    Exit;
  end;

  for I := P.MaxDegree downto 0 do
  begin
    C := P[I];
    if C = 0 then
    begin
      Continue;
    end
    else if C > 0 then
    begin
      if Result = '' then  // ���������Ӻ�
        Result := IntToStr(C) + VarPower(I)
      else
        Result := Result + '+' + IntToStr(C) + VarPower(I);
    end
    else // С�� 0��Ҫ�ü���
      Result := Result + IntToStr(C) + VarPower(I);
  end;
end;

function IntegerPolynomialIsZero(const P: TCnIntegerPolynomial): Boolean;
begin
  Result := (P.MaxDegree = 0) and (P[0] = 0);
end;

procedure IntegerPolynomialSetZero(const P: TCnIntegerPolynomial);
begin
  P.Clear;
  P.Add(0);
end;

procedure IntegerPolynomialShiftLeft(const P: TCnIntegerPolynomial; N: Integer);
var
  I: Integer;
begin
  if N = 0 then
    Exit
  else if N < 0 then
    IntegerPolynomialShiftRight(P, -N)
  else
  begin
    for I := 1 to N do
      P.Insert(0, 0);
  end;
end;

procedure IntegerPolynomialShiftRight(const P: TCnIntegerPolynomial; N: Integer);
var
  I: Integer;
begin
  if N = 0 then
    Exit
  else if N < 0 then
    IntegerPolynomialShiftLeft(P, -N)
  else
  begin
    for I := 1 to N do
    begin
      if P.Count = 0 then
        Break;
      P.Delete(0);
    end;

    if P.Count = 0 then
      P.Add(0);
  end;
end;

procedure IntegerPolynomialAddWord(const P: TCnIntegerPolynomial; N: Integer);
begin
  P[0] := P[0] + N;
end;

procedure IntegerPolynomialSubWord(const P: TCnIntegerPolynomial; N: Integer);
begin
  P[0] := P[0] - N;
end;

procedure IntegerPolynomialMulWord(const P: TCnIntegerPolynomial; N: Integer);
var
  I: Integer;
begin
  if N = 0 then
  begin
    IntegerPolynomialSetZero(P);
    Exit;
  end
  else
  begin
    for I := 0 to P.MaxDegree do
      P[I] := P[I] * N;
  end;
end;

procedure IntegerPolynomialDivWord(const P: TCnIntegerPolynomial; N: Integer);
var
  I: Integer;
begin
  if N = 0 then
    raise ECnPolynomialException.Create(SZeroDivide);

  for I := 0 to P.MaxDegree do
    P[I] := P[I] div N;
end;

procedure IntegerPolynomialNonNegativeModWord(const P: TCnIntegerPolynomial; N: LongWord);
var
  I: Integer;
begin
  if N = 0 then
    raise ECnPolynomialException.Create(SZeroDivide);

  for I := 0 to P.MaxDegree do
    P[I] := NonNegativeMod(P[I], N);
end;

function IntegerPolynomialAdd(const Res: TCnIntegerPolynomial; const P1: TCnIntegerPolynomial;
  const P2: TCnIntegerPolynomial): Boolean;
var
  I, D1, D2: Integer;
  PBig: TCnIntegerPolynomial;
begin
  D1 := Max(P1.MaxDegree, P2.MaxDegree);
  D2 := Min(P1.MaxDegree, P2.MaxDegree);

  Res.MaxDegree := D1;
  if D1 > D2 then
  begin
    if P1.MaxDegree > P2.MaxDegree then
      PBig := P1
    else
      PBig := P2;

    for I := D1 downto D2 + 1 do
      Res[I] := PBig[I];
  end;

  for I := D2 downto 0 do
    Res[I] := P1[I] + P2[I];
  Res.CorrectTop;
  Result := True;
end;

function IntegerPolynomialSub(const Res: TCnIntegerPolynomial; const P1: TCnIntegerPolynomial;
  const P2: TCnIntegerPolynomial): Boolean;
var
  I, D1, D2: Integer;
begin
  D1 := Max(P1.MaxDegree, P2.MaxDegree);
  D2 := Min(P1.MaxDegree, P2.MaxDegree);

  Res.MaxDegree := D1;
  if D1 > D2 then
  begin
    if P1.MaxDegree > P2.MaxDegree then // ����ʽ��
    begin
      for I := D1 downto D2 + 1 do
        Res[I] := P1[I];
    end
    else  // ��ʽ��
    begin
      for I := D1 downto D2 + 1 do
        Res[I] := -P2[I];
    end;
  end;

  for I := D2 downto 0 do
    Res[I] := P1[I] - P2[I];
  Res.CorrectTop;
  Result := True;
end;

function IntegerPolynomialMul(const Res: TCnIntegerPolynomial; P1: TCnIntegerPolynomial;
  P2: TCnIntegerPolynomial): Boolean;
var
  R: TCnIntegerPolynomial;
  I, J, M: Integer;
begin
  if IntegerPolynomialIsZero(P1) or IntegerPolynomialIsZero(P2) then
  begin
    IntegerPolynomialSetZero(Res);
    Result := True;
    Exit;
  end;

  if (Res = P1) or (Res = P2) then
    R := TCnIntegerPolynomial.Create
  else
    R := Res;

  M := P1.MaxDegree + P2.MaxDegree;
  R.MaxDegree := M;

  for I := 0 to P1.MaxDegree do
  begin
    // �ѵ� I �η������ֳ��� P2 ��ÿһ�����֣��ӵ������ I ��ͷ�Ĳ���
    for J := 0 to P2.MaxDegree do
    begin
      R[I + J] := R[I + J] + P1[I] * P2[J];
    end;
  end;

  R.CorrectTop;
  if (Res = P1) or (Res = P2) then
  begin
    IntegerPolynomialCopy(Res, R);
    R.Free;
  end;
  Result := True;
end;

function IntegerPolynomialDiv(const Res: TCnIntegerPolynomial; const Remain: TCnIntegerPolynomial;
  const P: TCnIntegerPolynomial; const Divisor: TCnIntegerPolynomial): Boolean;
var
  SubRes: TCnIntegerPolynomial; // ���ɵݼ���
  MulRes: TCnIntegerPolynomial; // ���ɳ����˻�
  DivRes: TCnIntegerPolynomial; // ������ʱ��
  I, D: Integer;
begin
  if IntegerPolynomialIsZero(Divisor) then
    raise ECnPolynomialException.Create(SDivByZero);

  if Divisor[Divisor.MaxDegree] <> 1 then
    raise ECnPolynomialException.Create(SCnErrorDivMaxDegree);

  if Divisor.MaxDegree > P.MaxDegree then // ��ʽ�����߲�������ֱ�ӱ������
  begin
    if Res <> nil then
      IntegerPolynomialSetZero(Res);
    if (Remain <> nil) and (P <> Remain) then
      IntegerPolynomialCopy(Remain, P);
    Result := True;
    Exit;
  end;

  // ������ѭ��
  SubRes := nil;
  MulRes := nil;
  DivRes := nil;

  try
    SubRes := TCnIntegerPolynomial.Create;
    IntegerPolynomialCopy(SubRes, P);

    D := P.MaxDegree - Divisor.MaxDegree;
    DivRes := TCnIntegerPolynomial.Create;
    DivRes.MaxDegree := D;
    MulRes := TCnIntegerPolynomial.Create;

    for I := 0 to D do
    begin
      IntegerPolynomialCopy(MulRes, Divisor);
      IntegerPolynomialShiftLeft(MulRes, D - I);                 // ���뵽 SubRes ����ߴ�
      IntegerPolynomialMulWord(MulRes, SubRes[P.MaxDegree - I]); // ��ʽ�˵���ߴ�ϵ����ͬ
      DivRes[D - I] := SubRes[P.MaxDegree - I];                  // �̷ŵ� DivRes λ��
      IntegerPolynomialSub(SubRes, SubRes, MulRes);              // ���������·Ż� SubRes
    end;

    if Remain <> nil then
      IntegerPolynomialCopy(Remain, SubRes);
    if Res <> nil then
      IntegerPolynomialCopy(Res, DivRes);
    Result := True;
  finally
    SubRes.Free;
    MulRes.Free;
    DivRes.Free;
  end;
end;

function IntegerPolynomialMod(const Res: TCnIntegerPolynomial; const P: TCnIntegerPolynomial;
  const Divisor: TCnIntegerPolynomial): Boolean;
begin
  Result := IntegerPolynomialDiv(nil, Res, P, Divisor);
end;

function IntegerPolynomialPower(const Res: TCnIntegerPolynomial;
  const P: TCnIntegerPolynomial; Exponent: LongWord): Boolean;
var
  T: TCnIntegerPolynomial;
begin
  if Exponent = 0 then
  begin
    Res.SetCoefficents([1]);
    Result := True;
    Exit;
  end
  else if Exponent = 1 then
  begin
    if Res <> P then
      IntegerPolynomialCopy(Res, P);
    Result := True;
    Exit;
  end;

  T := IntegerPolynomialDuplicate(P);
  try
    // ��������ʽ���ټ��� T �Ĵη���ֵ�� Res
    Res.SetCoefficents([1]);
    while Exponent > 0 do
    begin
      if (Exponent and 1) <> 0 then
        IntegerPolynomialMul(Res, Res, T);

      Exponent := Exponent shr 1;
      IntegerPolynomialMul(T, T, T);
    end;
    Result := True;
  finally
    T.Free;
  end;
end;

function IntegerPolynomialGaloisAdd(const Res: TCnIntegerPolynomial; const P1: TCnIntegerPolynomial;
  const P2: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial): Boolean;
begin
  Result := IntegerPolynomialAdd(Res, P1, P2);
  if Result then
  begin
    IntegerPolynomialNonNegativeModWord(Res, Prime);
    if Primitive <> nil then
      IntegerPolynomialGaloisMod(Res, Res, Primitive, Prime);
  end;
end;

function IntegerPolynomialGaloisSub(const Res: TCnIntegerPolynomial; const P1: TCnIntegerPolynomial;
  const P2: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial): Boolean;
begin
  Result := IntegerPolynomialSub(Res, P1, P2);
  if Result then
  begin
    IntegerPolynomialNonNegativeModWord(Res, Prime);
    if Primitive <> nil then
      IntegerPolynomialGaloisMod(Res, Res, Primitive, Prime);
  end;
end;

function IntegerPolynomialGaloisMul(const Res: TCnIntegerPolynomial; P1: TCnIntegerPolynomial;
  P2: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial): Boolean;
var
  R: TCnIntegerPolynomial;
  I, J, M: Integer;
begin
  if IntegerPolynomialIsZero(P1) or IntegerPolynomialIsZero(P2) then
  begin
    IntegerPolynomialSetZero(Res);
    Result := True;
    Exit;
  end;

  if (Res = P1) or (Res = P2) then
    R := TCnIntegerPolynomial.Create
  else
    R := Res;

  M := P1.MaxDegree + P2.MaxDegree;
  R.MaxDegree := M;

  for I := 0 to P1.MaxDegree do
  begin
    // �ѵ� I �η������ֳ��� P2 ��ÿһ�����֣��ӵ������ I ��ͷ�Ĳ��֣���ȡģ
    for J := 0 to P2.MaxDegree do
    begin
      R[I + J] := NonNegativeMod(R[I + J] + P1[I] * P2[J], Prime);
    end;
  end;

  R.CorrectTop;
  // �ٶԱ�ԭ����ʽȡģ��ע�����ﴫ��ı�ԭ����ʽ�� mod �����ĳ��������Ǳ�ԭ����ʽ����
  IntegerPolynomialGaloisMod(R, R, Primitive, Prime);
  if (Res = P1) or (Res = P2) then
  begin
    IntegerPolynomialCopy(Res, R);
    R.Free;
  end;
  Result := True;
end;

function IntegerPolynomialGaloisDiv(const Res: TCnIntegerPolynomial;
  const Remain: TCnIntegerPolynomial; const P: TCnIntegerPolynomial;
  const Divisor: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial): Boolean;
var
  SubRes: TCnIntegerPolynomial; // ���ɵݼ���
  MulRes: TCnIntegerPolynomial; // ���ɳ����˻�
  DivRes: TCnIntegerPolynomial; // ������ʱ��
  I, D: Integer;
begin
  if IntegerPolynomialIsZero(Divisor) then
    raise ECnPolynomialException.Create(SDivByZero);

  if Divisor[Divisor.MaxDegree] <> 1 then
    raise ECnPolynomialException.Create(SCnErrorDivMaxDegree);

  if Divisor.MaxDegree > P.MaxDegree then // ��ʽ�����߲�������ֱ�ӱ������
  begin
    if Res <> nil then
      IntegerPolynomialSetZero(Res);
    if (Remain <> nil) and (P <> Remain) then
      IntegerPolynomialCopy(Remain, P);
    Result := True;
    Exit;
  end;

  // ������ѭ��
  SubRes := nil;
  MulRes := nil;
  DivRes := nil;

  try
    SubRes := TCnIntegerPolynomial.Create;
    IntegerPolynomialCopy(SubRes, P);

    D := P.MaxDegree - Divisor.MaxDegree;
    DivRes := TCnIntegerPolynomial.Create;
    DivRes.MaxDegree := D;
    MulRes := TCnIntegerPolynomial.Create;

    for I := 0 to D do
    begin
      if P.MaxDegree - I > SubRes.MaxDegree then                 // �м���������λ
        Continue;
      IntegerPolynomialCopy(MulRes, Divisor);
      IntegerPolynomialShiftLeft(MulRes, D - I);                 // ���뵽 SubRes ����ߴ�
      IntegerPolynomialMulWord(MulRes, SubRes[P.MaxDegree - I]); // ��ʽ�˵���ߴ�ϵ����ͬ
      DivRes[D - I] := SubRes[P.MaxDegree - I];                  // �̷ŵ� DivRes λ��
      IntegerPolynomialGaloisSub(SubRes, SubRes, MulRes, Prime); // ����ģ�������·Ż� SubRes
    end;

    // ������ʽ����Ҫ��ģ��ԭ����ʽ
    if Primitive <> nil then
    begin
      IntegerPolynomialGaloisMod(SubRes, SubRes, Primitive, Prime);
      IntegerPolynomialGaloisMod(DivRes, DivRes, Primitive, Prime);
    end;

    if Remain <> nil then
      IntegerPolynomialCopy(Remain, SubRes);
    if Res <> nil then
      IntegerPolynomialCopy(Res, DivRes);
    Result := True;
  finally
    SubRes.Free;
    MulRes.Free;
    DivRes.Free;
  end;
end;

function IntegerPolynomialGaloisMod(const Res: TCnIntegerPolynomial; const P: TCnIntegerPolynomial;
  const Divisor: TCnIntegerPolynomial; Prime: LongWord; Primitive: TCnIntegerPolynomial): Boolean;
begin
  Result := IntegerPolynomialGaloisDiv(nil, Res, P, Divisor, Prime, Primitive);
end;

function IntegerPolynomialGaloisPower(const Res, P: TCnIntegerPolynomial;
  Exponent, Prime: LongWord; Primitive: TCnIntegerPolynomial): Boolean;
var
  T: TCnIntegerPolynomial;
begin
  if Exponent = 0 then
  begin
    Res.SetCoefficents([1]);
    Result := True;
    Exit;
  end
  else if Exponent = 1 then
  begin
    if Res <> P then
      IntegerPolynomialCopy(Res, P);
    Result := True;
    Exit;
  end;

  T := IntegerPolynomialDuplicate(P);
  try
    // ��������ʽ���ټ��� T �Ĵη���ֵ�� Res
    Res.SetCoefficents([1]);
    while Exponent > 0 do
    begin
      if (Exponent and 1) <> 0 then
        IntegerPolynomialGaloisMul(Res, Res, T, Prime, Primitive);

      Exponent := Exponent shr 1;
      IntegerPolynomialGaloisMul(T, T, T, Prime, Primitive);
    end;
    Result := True;
  finally
    T.Free;
  end;
end;

end.