unit aboutunit;

{$MODE Delphi}

interface

uses
  windows, LCLIntf, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, LResources,shellapi, vmxfunctions, NewKernelHandler;

type

  { TAbout }

  TAbout = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Label6: TLabel;
    Button1: TButton;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Button2: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lblDBVM: TLabel;
    Label11: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblDBVMClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About: TAbout;

implementation

uses tlgUnit,MainUnit2,
{$ifdef net}
unit2;
{$else}
MainUnit;
{$endif}

resourcestring
  rsYourSystemDOESNOTSupportDBVM = 'YOUR SYSTEM DOES NOT SUPPORT D*B*V*M';
  rsThisMeansThatYouWillNeedANewCpuIntelToBeAbleToUseT = 'THIS MEANS THAT YOU WILL NEED A NEW CPU (INTEL) TO BE ABLE TO USE THE ADVANCED D*B*V*M OPTIONS';
  rsYourSystemIsRunningDBVMVersion = 'YOUR SYSTEM IS RUNNING D*B*V*M VERSION %S';
  rsThisMeansThatYourSystemIsRunningDbvm = 'THIS MEANS THAT YOUR SYSTEM IS RUNNING D*B*V*M. THIS MEANS CE WILL MAKE USE OF SOME ADVANCED TOOLS THAT ARE OTHERWISE UNAVAILABLE';
  rsYourSystemSupportsDBVM = 'YOUR SYSTEM SUPPORTS D*B*V*M';
  rsThisMeansThatYouReCurrentlyNotRunningDbvm = 'THIS MEANS THAT YOU''RE CURRENTLY NOT RUNNING D*B*V*M, BUT THAT YOUR SYSTEM IS CAPABLE OF RUNNING IT';
  rsDidYouReallyThinkYouDFindAnEasterEggByDoingThisWel = 'DID YOU REALLY THINK YOU''D FIND AN *EASTER *EGG BY DOING THIS? WELL, YOU KNOW WHAT? YOU WHERE RIGHT!';
  rsAreYouSureYouWantToLaunchDBVM = 'ARE YOU SURE YOU WANT TO LAUNCH D*B*V*M? YOU SEEM TO BE RUNNING IN 32-BIT, SO DON''T REALLY NEED IT THAT BADLY (EXCEPT FOR ULTIMAP AND CLOAKED OPERATIONS)';

procedure TAbout.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=caFree;
end;

procedure TAbout.Button2Click(Sender: TObject);
begin

  // shellexecute(0,'open','https://www.paypal.com/xclick/business=dark_byte%40hotmail.com&no_note=1&tax=0&lc=US',nil,nil,sw_maximize);
end;

procedure TAbout.FormShow(Sender: TObject);
var supportsdbvm: boolean;
    a,b,c,d: dword;
begin
  {$ifdef net}
    groupbox1.Caption:=unit2.CEnorm;
  {$else}
    groupbox1.Caption:=mainunit2.CEnorm;
  {$endif}


  if (vmx_password1=0) and (vmx_password2=0) then
  begin
    vmx_password1:=$76543210;
    vmx_password2:=$fedcba98;
  end;

  if not isDBVMCapable then
  begin
    //force the default password


    vmx_password1:=$76543210;
    vmx_password2:=$fedcba98;
  end;


  if not isDBVMCapable then
  begin
    lblDBVM.Font.Color:=clRed;
    lbldbvm.caption:=rsYourSystemDOESNOTSupportDBVM;
    lbldbvm.Hint:=rsThisMeansThatYouWillNeedANewCpuIntelToBeAbleToUseT;
    lbldbvm.ShowHint:=true;
  end
  else
  begin

//{$ifdef cpu32}
//    Loaddbk32;
//{$endif}
    if (dbvm_version>0) then
    begin
      lblDBVM.Font.Color:=clLime;
      lbldbvm.caption:=Format(rsYourSystemIsRunningDBVMVersion, [inttostr(dbvm_version and $00ffffff)]);
      lbldbvm.Hint:=rsThisMeansThatYourSystemIsRunningDbvm;
      lbldbvm.ShowHint:=true;
    end
    else
    begin
      lblDBVM.Font.Color:=clGreen;
      lbldbvm.caption:=rsYourSystemSupportsDBVM;
      lbldbvm.Hint:=rsThisMeansThatYouReCurrentlyNotRunningDbvm;
      lbldbvm.ShowHint:=true;
    end;
  end;


  if (dbvm_version=0) then
  begin
    supportsdbvm:=isDBVMCapable;

    if supportsdbvm then
    begin
      lblDBVM.Font.Color:=clGreen;
      lbldbvm.caption:=rsYourSystemSupportsDBVM;
      lbldbvm.Hint:=rsThisMeansThatYouReCurrentlyNotRunningDbvm;
      lbldbvm.ShowHint:=true;
      lbldbvm.Cursor:=crHandPoint;
    end
    else
    begin
      lblDBVM.Font.Color:=clRed;
      lbldbvm.caption:=rsYourSystemDOESNOTSupportDBVM;
      lbldbvm.Hint:=rsThisMeansThatYouWillNeedANewCpuIntelToBeAbleToUseT;
      lbldbvm.ShowHint:=true;
      lbldbvm.Cursor:=crNo;
    end;
  end
  else
  begin
    lblDBVM.Font.Color:=clLime;
    lbldbvm.caption:=Format(rsYourSystemIsRunningDBVMVersion, [inttostr(dbvm_version and $00ffffff)]);
    lbldbvm.Hint:=rsThisMeansThatYourSystemIsRunningDbvm;
    lbldbvm.ShowHint:=true;
    lbldbvm.Cursor:=crDefault;
  end;
end;

procedure TAbout.Label8Click(Sender: TObject);
begin
  ShellExecute(0, pchar('open'),pchar('http://mycheat.org/'), pchar(''),pchar(''), SW_MAXIMIZE	);
end;

procedure TAbout.Label9Click(Sender: TObject);
begin
  ShellExecute(0, pchar('open'),pchar('http://forum.mycheat.org/'), pchar(''),pchar(''), SW_MAXIMIZE	);
end;

procedure TAbout.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssCtrl in Shift) and (ssAlt in Shift) and (ssShift in Shift) then
  begin
    ShowMessage(rsDidYouReallyThinkYouDFindAnEasterEggByDoingThisWel);
    with TTlg.create(self) do show;
  end;
end;

procedure TAbout.lblDBVMClick(Sender: TObject);
begin
  if not isRunningDBVM then
  begin
    if not isDBVMCapable then exit;
    
    if not Is64bitOS then
    begin
      if messagedlg(rsAreYouSureYouWantToLaunchDBVM, mtWarning, [mbno, mbyes], 0)=mryes then
      begin
        loaddbk32;
        if assigned(launchdbvm) then
          launchdbvm
        else
          raise exception.create('LAUNCH*D*B*V*M WAS NOT ASSIGNED');

        formshow(self);
      end;
    end
    else
    begin
      if loaddbvmifneeded then
      begin
        formshow(self);
      end;
    end;
  end;
end;

initialization
  {$i aboutunit.lrs}

end.
