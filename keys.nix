rec {
  ssh = [
    rutile-bigrpi
    rutile-nixrpi
    rutile-celestine
    rutile-work
    lucy
  ];
  host = [ quartz-host azurite-host ];
  all = ssh ++ host;
  rutile-nixrpi = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF3kWw7i1az9QIe9RlxhTdcwIotBukvhbrmy2dvSwCh2'';
  rutile-bigrpi = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFreswWvgIPc3s3X9rjdRxGYmgpLmsU3UA2R3X+UGYpZ'';
  rutile-perovskite = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF9aakNG9hVLV1fW7zjbjPtM1gyup/5KoWqmoGzhUf+5'';
  rutile-celestine = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINkk3bjlkJWq5y4S9sMfW2Wzo5jQFodVqm/Vn226etjW'';
  rutile-work = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClTAvMxiHZrFm9NjVabelkROPmC+2Ym2XbKqF9g2R2/'';
  lucy = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSXPk6yg1XOeWFytbLnfEEFZUD5Ah0D1k+SWK82JUvC'';
  quartz-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMD015VnsMHOeFHs2wQGWEO24IuzC1V/MleiZzg3yUNI";
  azurite-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzl+vE88usJ7TEQIc8HEucK/eMluoNrmNvpdJoRTI0g root@nixos";
}
