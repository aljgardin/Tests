program OKButtonTest;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils,
  fpg_base, fpg_main, fpg_form, fpg_Dialogs, typinfo,
  {%units 'Auto-generated GUI code'}
  fpg_button
  {%endunits}
  ;

type

  { TMainForm }

  TMainForm = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: MainForm}
    Button1: TfpgButton;
    Button2: TfpgButton;
    btnS: TfpgButton;
    btnSM: TfpgButton;
    {@VFD_HEAD_END: MainForm}
  protected
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FrmOnClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure btnShowClick(Sender: TObject);
    procedure btnShowModalClick(Sender: TObject);
    procedure myCloseQuery(Sender: TObject; var CanClose: boolean);
  public
    procedure ShowModal; reintroduce;
    procedure AfterCreate; override;
  end;

var
  Fpostfix: Integer;

{@VFD_NEWFORM_DECL}



{@VFD_NEWFORM_IMPL}

procedure TMainForm.OKBtnClick(Sender: TObject);
begin
  ShowMessage('OK Click.');
  ModalResult := mrOK;

  //TWindowType = (wtChild, wtWindow, wtModalForm, wtPopup)

  if WindowType <> wtModalForm then
    Close;
end;

procedure TMainForm.CancelBtnClick(Sender: TObject);
begin
  ShowMessage('Cancel Click.');
  ModalResult := mrCancel;

  if WindowType <> wtModalForm then
    Close;
end;

procedure TMainForm.FrmOnClose(Sender: TObject; var CloseAction: TCloseAction);
var
  ca: String;
  mr: String;
  wt: String;
  pti: PTypeINfo;
begin

  pti := TypeInfo(TWindowType);
  wt := typinfo.GetEnumName(pti, INteger(WindowType));
  pti := TypeInfo(TCloseAction);
  ca := typinfo.GetEnumName(pti, Integer(CloseAction));
  pti := TypeInfo(TfpgModalResult);
  mr := typinfo.GetEnumName(pti, Integer(ModalResult));
  ShowMessage('On Close.' + LineEnding +
    'Close Action = ' + ca + LineEnding +
    'Modal Result = ' + mr + LineEnding +
    'Window Type = ' + wt);

  if WindowType = wtModalForm then
    if CloseAction = caHide then
      CloseAction := cafree;

  pti := TypeInfo(TCloseAction);
  ca := typinfo.GetEnumName(pti, Integer(CloseAction));

  ShowMessage('On Close.' + LineEnding +
    'Close Action = ' + ca + LineEnding +
    'Modal Result = ' + mr + LineEnding +
    'Window Type = ' + wt);
end;

procedure TMainForm.btnShowClick(Sender: TObject);
var
  f: TMainForm;
  fn: String;
begin
  inc(Fpostfix);
  f := TMainForm.Create(self);
  try
    f.Name := 'Dialog' + IntToStr(Fpostfix);
    f.WindowTitle := f.Name;
    f.Show;
  finally
  end;

  if Assigned(f) then
    ShowMessage('f is Assigned.')
  else
    ShowMessage('f Not Assigned.');
end;

procedure TMainForm.btnShowModalClick(Sender: TObject);
var
  f: TMainForm;
  fn: String;
  res: TfpgModalResult;
  pyi: PTypeInfo;
  mr: String;
begin
  inc(Fpostfix);
  f := TMainForm.Create(nil);
  try
    f.Name := 'Dialog' + IntToStr(Fpostfix);
    f.WindowTitle := f.Name;
    res := f.ShowModal;
    pyi := typeinfo(TfpgModalResult);
    mr := GetEnumName(pyi, integer(res));
    ShowMEssage('ShowModal = ' + mr);
  finally
  end;
end;

procedure TMainForm.myCloseQuery(Sender: TObject; var CanClose: boolean);
begin

end;

procedure TMainForm.ShowModal;
var
  lCloseAction: TCloseAction;
begin
  if WindowAllocated and (FWindowType <> wtModalForm) then
    HandleHide;
  FWindowType := wtModalForm;

  fpgApplication.PushModalForm(self);
  ModalResult := mrNone;

  try
    Show;
    // processing messages until this form ends.
    // delivering the remaining messages
    fpgApplication.ProcessMessages;
    try
      repeat
        fpgWaitWindowMessage;
      until (ModalResult <> mrNone) or (not Visible);
    except
      on E: Exception do
      begin
        Visible := False;
        fpgApplication.HandleException(self);
      end;
    end;  { try..except }
  finally
    { we have to pop the form even in an error occurs }
    fpgApplication.PopModalForm;
    Result := ModalResult;
  end;  { try..finally }

  if ModalResult <> mrNone then
  begin
    lCloseAction := caHide; // Dummy variable - we do nothing with it
    DoOnClose(lCloseAction); // Simply so the OnClose event fires.
    //Close;
  end;
end;

procedure TMainForm.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: MainForm}
  Name := 'MainForm';
  SetPosition(536, 186, 300, 250);
  WindowTitle := 'MainForm';
  IconName := '';
  BackGroundColor := $80000001;

  Button1 := TfpgButton.Create(self);
  with Button1 do
  begin
    Name := 'Button1';
    SetPosition(32, 24, 80, 24);
    Text := 'OK';
    FontDesc := '#Label1';
    ImageName := '';
    ModalResult := mrOK;
    ParentShowHint := False;
    TabOrder := 1;
    default := true;
    OnClick := @OKBtnClick;
  end;

  Button2 := TfpgButton.Create(self);
  with Button2 do
  begin
    Name := 'Button2';
    SetPosition(32, 68, 80, 24);
    Text := 'Cancel';
    FontDesc := '#Label1';
    ImageName := '';
    ModalResult := mrCancel;
    ParentShowHint := False;
    TabOrder := 2;
    OnClick := @CancelBtnClick;
  end;

  btnS := TfpgButton.Create(self);
  with btnS do
  begin
    Name := 'btnS';
    SetPosition(40, 160, 160, 24);
    Text := 'New Form Show';
    FontDesc := '#Label1';
    ImageName := '';
    ParentShowHint := False;
    TabOrder := 3;
    OnCLick := @btnShowClick;
  end;

  btnSM := TfpgButton.Create(self);
  with btnSM do
  begin
    Name := 'btnSM';
    SetPosition(44, 196, 160, 24);
    Text := 'New Form ShowModal';
    FontDesc := '#Label1';
    ImageName := '';
    ParentShowHint := False;
    TabOrder := 4;
    OnClick := @btnShowModalClick;
  end;

  {@VFD_BODY_END: MainForm}
  {%endregion}

  OnClose := @FrmOnClose;
end;


procedure MainProc;
var
  frm: TMainForm;
  res: TfpgModalResult;
  ri: Integer;

  pti: PTypeInfo;
  mr: String;
begin
  fpgApplication.Initialize;
  fpgApplication.CreateForm(TMainForm, frm);
  try
    //res := frm.ShowModal;
    //ri := Integer(res);
    //pti := TypeInfo(TfpgModalResult);
    //mr := typinfo.GetEnumName(pti, Integer(res));
    //ShowMessage('ShowModal result = ' + mr);
    frm.Show;
    fpgApplication.Run;
  finally
    frm.Free;
  end;
end;

begin
  MainProc;
end.

