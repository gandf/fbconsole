{
 * The contents of this file are subject to the InterBase Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License.
 *
 * You may obtain a copy of the License at http://www.Inprise.com/IPL.html.
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
 * the License for the specific language governing rights and limitations
 * under the License.  The Original Code was created by Inprise
 * Corporation and its predecessors.
 *
 * Portions created by Inprise Corporation are Copyright (C) Inprise
 * Corporation. All Rights Reserved.
 *
 * Contributor(s):  Krzysztof Golko.
}

unit zluPersistent;
{ This unit is going to be used to group together access to registry
  and alternatively to XML file. It shall step by step incorporate more and more
  like Aliases, AppSessings etc until all references to registry are done through
  this class, then visibility of Registry shall change to private. }

interface

uses
  Windows, SysUtils, Classes, Registry, Forms,
  IBServices,
  zluGlobal;

type
{ Most of the procedures might raise an exception, eg when there's no a key in the registry
  these situation are considered abnormal }

  EPersistent = class(Exception);

  // temporary this type is defined here
  TibcServerProps = record
    ServerName: string;
    UserName: string;
    Description: string;
    Protocol: TProtocol;
    LastAccessed: TDateTime;
  end;

  TibcDatabaseProps = record
    DatabaseFiles: string;
    UserName: string;
    Role: string;
    CaseSensitiveRole: boolean;
    CharacterSet: string;
  end;

  TPersistentSetting = record
    Name: string;
    Value: Variant;
  end;


  TibcPersistentInfo = class
  private
    gRegSettingsKey: string;
    FRegistry: TRegistry;
    procedure GetSetting(var Setting: TPersistentSetting);
    procedure StoreSetting(Setting: TPersistentSetting);
  public
    constructor Create;
    destructor Destroy; override;
    procedure InitRegistry;
    procedure GetFormSettings(AForm: TForm; Id: string);
    procedure StoreFormSettings(AForm: TForm; Id: string);
    // preferences
    procedure GetSettings(var Settings: TAppSettings);
    procedure StoreSettings(Settings: TAppSettings);
    // server aliases
    function ServerAliasExists(Alias: string): boolean;
    procedure DeleteServerAlias(Alias: string);
    procedure RenameServerAlias(SrcAlias, DestAlias: string);
    procedure GetServerAliases(Aliases: TStrings);
    procedure GetServerProps(Alias: string; var ServerProps: TibcServerProps);
    procedure StoreServerProps(Alias: string; ServerProps: TibcServerProps);
    // database aliases
    function DatabaseAliasExists(ServerName, AliasName: string): boolean;
    procedure GetDatabaseProps(ServerAlias, DatabaseAlias: string; var DatabaseProps: TibcDatabaseProps);
    procedure StoreDatabaseProps(ServerAlias, DatabaseAlias: string; var DatabaseProps: TibcDatabaseProps);
    // external Apps/Tools
    procedure GetExternalApps(ExternalApps: TStrings);
    procedure StoreExternalApp(Title, Path, WordDir, Params: string; Update: boolean);
    procedure DeleteExternalApp(Title: string);
    property Registry: TRegistry read Fregistry;
  end;

var
  PersistentInfo: TibcPersistentInfo;

implementation

type
  TWinSettings = record
    _Top,
    _Left,
    _Height,
    _Width: integer;
    _State: TWindowState;
    _Read: boolean;
  end;

var
  gRegSettingsKey: string;
//  gRegServersKey: string;

  { TibcPersistentInfo }
constructor TibcPersistentInfo.Create;
begin
  FRegistry := TRegistry.Create;
  InitRegistry;
end;

destructor TibcPersistentInfo.Destroy;
begin
  FRegistry.Free;
end;

procedure TibcPersistentInfo.GetSetting(var Setting: TPersistentSetting);
begin
  case (VarType(Setting.Value) and varTypeMask) of
    varSmallint: Setting.Value := FRegistry.ReadInteger(Setting.Name);
    varInteger: Setting.Value := FRegistry.ReadInteger(Setting.Name);
    varBoolean: Setting.Value := FRegistry.ReadBool(Setting.Name);
    varString: Setting.Value := FRegistry.ReadString(Setting.Name);
  end;
end;

procedure TibcPersistentInfo.StoreSetting(Setting: TPersistentSetting);
begin
  case (VarType(Setting.Value) and varTypeMask) of
    varSmallint: FRegistry.WriteInteger(Setting.Name, Setting.Value);
    varInteger: FRegistry.WriteInteger(Setting.Name, Setting.Value);
    varBoolean: FRegistry.WriteBool(Setting.Name, Setting.Value);
    varString: FRegistry.WriteString(Setting.Name, Setting.Value);
  end;
end;

procedure TibcPersistentInfo.InitRegistry;
var
  i: integer;
begin
  with FRegistry do
  begin
    // This is of cource highly redundant, to be fixed later
    RootKey := HKEY_CURRENT_USER;
    OpenKey('Software',true);
    OpenKey('Borland',true);
    OpenKey('InterBase',true);
    OpenKey('IBConsole',true);
    CreateKey('Servers');
    gRegServersKey := Format('\%s\Servers\',[CurrentPath]);
    CreateKey('Settings');
    gRegSettingsKey := Format('\%s\Settings',[CurrentPath]);
    gRegToolsKey := Format('%s\Tools',[gRegSettingsKey]);
  end;

  with FRegistry do
  begin
    OpenKey(gRegSettingsKey,false);
    for i := 0 to NUM_SETTINGS - 1 do
    begin
      if not ValueExists(gAppSettings[i].Name) then
      begin
        StoreSetting(TPersistentSetting(gAppSettings[i]));
{        case (VarType(gAppSettings[i].Setting) and varTypeMask) of
          varSmallint: WriteInteger (gAppSettings[i].Name, gAppSettings[i].Setting);
          varInteger: WriteInteger (gAppSettings[i].Name, gAppSettings[i].Setting);
          varBoolean: WriteBool (gAppSettings[i].Name, gAppSettings[i].Setting);
          varString: WriteString (gAppSettings[i].Name, gAppSettings[i].Setting);
        end; }
      end;
    end;
    CloseKey;
  end;
end;

procedure TibcPersistentInfo.GetFormSettings(AForm: TForm; Id: string);
var
  wSettings: TWinSettings;
  begin
  if FRegistry.OpenKey(gRegSettingsKey, TRUE) then
    begin
    if FRegistry.ReadBinaryData(Id, wSettings, SizeOf(TWinSettings)) >= SizeOf(TWinSettings) then
      begin
      AForm.Top := wSettings._Top;
      AForm.Left := wSettings._Left;
      AForm.Height := wSettings._Height;
      AForm.Width := wSettings._Width;
      AForm.WindowState := wSettings._State;
    end;
    FRegistry.CloseKey;
  end;
end;

procedure TibcPersistentInfo.StoreFormSettings(AForm: TForm; Id: string);
var
  wSettings: TWinSettings;
begin
  if FRegistry.OpenKey(gRegSettingsKey, TRUE) then
  begin
    wSettings._Top := AForm.Top;
    wSettings._Left := AForm.Left;
    wSettings._Height := AForm.Height;
    wSettings._Width := AForm.Width;
    wSettings._State := AForm.WindowState;
    wSettings._Read := TRUE;
    FRegistry.WriteBinaryData(Id, wSettings, SizeOf(TWinSettings));
    FRegistry.CloseKey;
  end;
end;

procedure TibcPersistentInfo.GetSettings(var Settings: TAppSettings);
var
  i: integer;
begin
  if FRegistry.OpenKey(gRegSettingsKey, FALSE) then
  begin
    for i := 0 to NUM_SETTINGS - 1 do
    GetSetting(TPersistentSetting(Settings[i]));
    FRegistry.CloseKey;
  end;
end;

procedure TibcPersistentInfo.StoreSettings(Settings: TAppSettings);
var
  i: integer;
begin
  FRegistry.OpenKey(gRegSettingsKey, true);
  for i := 0 to NUM_SETTINGS - 1 do
  begin
{        case TVarData(gAppSettings[i].Setting).VType of
          varBoolean:
            WriteBool(gAppSettings[l].Name, gAppSettings[l].Setting);
          varString:
            WriteString(gAppSettings[l].Name, gAppSettings[l].Setting);
          varInteger:
            WriteInteger(gAppSettings[l].Name, gAppSettings[l].Setting); }
    StoreSetting(TPersistentSetting(Settings[i]));
  end;
  FRegistry.CloseKey;
end;

function TibcPersistentInfo.ServerAliasExists(Alias: string): boolean;
begin
  Result := FRegistry.KeyExists(Format('%s%s',[gRegServersKey, Alias]));
end;

procedure TibcPersistentInfo.DeleteServerAlias(Alias: string);
begin
  FRegistry.CloseKey;
//  FRegistry.DeleteKey(Format('%s%s\Databases',[gRegServersKey,Node]));
  FRegistry.DeleteKey(Format('%s%s',[gRegServersKey, Alias]));
end;

procedure TibcPersistentInfo.RenameServerAlias(SrcAlias, DestAlias: string);
begin
  // if an alias already exists an exception should be raised here?
  FRegistry.MoveKey(Format('%s%s',[gRegServersKey, SrcAlias]),
        Format('%s%s',[gRegServersKey, DestAlias]), TRUE);
end;

procedure TibcPersistentInfo.GetServerAliases(Aliases: TStrings);
begin
  if FRegistry.OpenKey(gRegServersKey, FALSE) then
  begin
    FRegistry.GetKeyNames(Aliases);
    FRegistry.CloseKey;
  end else
    Aliases.Clear;
end;

procedure TibcPersistentInfo.GetServerProps(Alias: string; var ServerProps: TibcServerProps);
begin
  ServerProps.ServerName := '';
  ServerProps.UserName := '';
  ServerProps.Description := '';
  ServerProps.Protocol := Local;

  if FRegistry.OpenKey(Format('%s%s',[gRegServersKey, Alias]), FALSE) then
  begin
    try
      case FRegistry.ReadInteger('Protocol') of
        0: ServerProps.Protocol := TCP;
        1: ServerProps.Protocol := NamedPipe;
        2: ServerProps.Protocol := SPX;
        3: ServerProps.Protocol := Local;
      end;

      ServerProps.ServerName := FRegistry.ReadString('ServerName');
      ServerProps.UserName := FRegistry.ReadString('UserName');
      ServerProps.Description := FRegistry.ReadString('Description');
      ServerProps.LastAccessed := FRegistry.ReadDateTime ('Last Accessed');
    finally
      FRegistry.CloseKey;
    end;
  end else
    raise EPersistent.Create('Persistent data read error. Server alias not found: ' + Alias);
      end;

procedure TibcPersistentInfo.StoreServerProps(Alias: string; ServerProps: TibcServerProps);
      begin
  if FRegistry.OpenKey(Format('%s%s',[gRegServersKey, Alias]), TRUE) then
  begin
    try
      FRegistry.WriteString('ServerName', ServerProps.ServerName);
      case ServerProps.Protocol of
        TCP: FRegistry.WriteInteger('Protocol',0);
        NamedPipe: FRegistry.WriteInteger('Protocol',1);
        SPX: FRegistry.WriteInteger('Protocol',2);
        Local: FRegistry.WriteInteger('Protocol',3);
      end;
      FRegistry.WriteString('Username', ServerProps.Username);
      FRegistry.WriteString('Description', ServerProps.Description);
      FRegistry.WriteDateTime('Last Accessed', ServerProps.LastAccessed);
    finally
      FRegistry.CloseKey;
    end;
  end else
    raise EPersistent.Create('Persistent data write error. Cannot access server alias: ' + Alias);
  end;

function TibcPersistentInfo.DatabaseAliasExists(ServerName, AliasName: string): boolean;
begin
  Result := FRegistry.KeyExists(Format('%s%s\Databases\%s',[gRegServersKey, ServerName, AliasName]));
end;

procedure TibcPersistentInfo.GetDatabaseProps(ServerAlias, DatabaseAlias: string; var DatabaseProps: TibcDatabaseProps);
begin
  DatabaseProps.DatabaseFiles := '';
  DatabaseProps.UserName := '';
  DatabaseProps.Role := '';
  DatabaseProps.CharacterSet := '';
  DatabaseProps.CaseSensitiveRole := FALSE;

  if FRegistry.OpenKey(Format('%s%s\Databases\%s',[gRegServersKey, ServerAlias, DatabaseAlias]), FALSE) then
  begin
    try
      DatabaseProps.DatabaseFiles := FRegistry.ReadString('DatabaseFiles');
      DatabaseProps.UserName := FRegistry.ReadString('Username');
      DatabaseProps.Role := FRegistry.ReadString('Role');
      DatabaseProps.CharacterSet := FRegistry.ReadString('CharacterSet');
      try
        DatabaseProps.CaseSensitiveRole := FRegistry.ReadBool('CaseSensitiveRole');
      except
        DatabaseProps.CaseSensitiveRole := FALSE;
      end;
    finally
      FRegistry.CloseKey;
    end  
  end else
    raise EPersistent.Create('Persistent data read error. Database alias not found: ' + DatabaseAlias);
end;

procedure TibcPersistentInfo.StoreDatabaseProps(ServerAlias, DatabaseAlias: string; var DatabaseProps: TibcDatabaseProps);
begin
  if FRegistry.OpenKey(Format('%s%s\Databases\%s',[gRegServersKey, ServerAlias, DatabaseAlias]), TRUE) then
      begin
    try
      FRegistry.WriteString('DatabaseFiles', DatabaseProps.DatabaseFiles);
      FRegistry.WriteString('Username', DatabaseProps.Username);
      FRegistry.WriteString('Role', DatabaseProps.Role);
      FRegistry.WriteBool('CaseSensitiveRole', DatabaseProps.CaseSensitiveRole);
      FRegistry.WriteString('CharacterSet', DatabaseProps.CharacterSet);
    finally
      FRegistry.CloseKey;
        end;
  end 
  else
    raise EPersistent.Create('Persistent data write error. Cannot access database alias: ' + DatabaseAlias);
end;

procedure TibcPersistentInfo.GetExternalApps(ExternalApps: TStrings);
var
  iCount, i: integer;
begin
  with FRegistry do
  begin
    if OpenKey (gRegToolsKey, false) and ValueExists('Count') then
    begin
      iCount := ReadInteger ('Count');
      for i := 0 to iCount - 1 do
        gExternalApps.Add(ReadString (Format('Title%d', [i])));
    end;
    CloseKey;
  end;
end;

procedure TibcPersistentInfo.StoreExternalApp(Title, Path, WordDir, Params: string; Update: boolean);
begin

end;

procedure TibcPersistentInfo.DeleteExternalApp(Title: string);
begin

end;

end.
