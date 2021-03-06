unit Utils;

interface
uses
  System.Beacon, FMX.ListView, FMX.ListView.Appearances, System.SysUtils, BusExitTime,
  IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient;

function ProximityToString(Proximity: TBeaconProximity): string;
function GetLVItem(DeviceId: string; LV: TListView): TListViewItem;
function WeekDayToStr(wd: TWeekDay): string;
function pingIp(host: String): Boolean;

var
  IPServer: string;

implementation

function ProximityToString(Proximity: TBeaconProximity): string;
begin
  case Proximity of
    Immediate: Result := 'Muito perto';
    Near: Result := 'Perto';
    Far: Result := 'Longe';
    Away: Result := 'Muito Longe';
  end;
end;

function GetLVItem(DeviceId: string; LV: TListView): TListViewItem;
var
  Item: TListViewItem;
begin
  Result := nil;
  for Item in LV.Items do
    if Item.Text.Equals(DeviceId) then
      Result := Item;
end;

function WeekDayToStr(wd: TWeekDay): string;
begin
  case wd of
    wdSunday: Result := 'Domingo';
    wdMonday: Result := 'Segunda';
    wdTuesday: Result := 'Ter�a';
    wdWednesday: Result := 'Quarta';
    wdThursday: Result := 'Quinta';
    wdFriday: Result := 'Sexta';
    wdSaturday: Result := 'S�bado';
  end;
end;

function pingIp(host: String): Boolean;
var
  IdICMPClient: TIdICMPClient;
begin
  try
    IdICMPClient := TIdICMPClient.Create(nil);
    IdICMPClient.Host := host;
    IdICMPClient.ReceiveTimeout := 500;
    IdICMPClient.Ping;
    result := (IdICMPClient.ReplyStatus.BytesReceived > 0);
  finally
    IdICMPClient.Free;
  end
end;


end.
