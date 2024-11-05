rec {
  ssh = [
    rutile-bigrpi
    rutile-nixrpi
    rutile-work
    lucy
  ];
  host = [ quartz-host ];
  all = ssh ++ host;
  rutile-nixrpi = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF3kWw7i1az9QIe9RlxhTdcwIotBukvhbrmy2dvSwCh2'';
  rutile-bigrpi = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFreswWvgIPc3s3X9rjdRxGYmgpLmsU3UA2R3X+UGYpZ'';
  rutile-perovskite = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF9aakNG9hVLV1fW7zjbjPtM1gyup/5KoWqmoGzhUf+5'';
  rutile-work = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClTAvMxiHZrFm9NjVabelkROPmC+2Ym2XbKqF9g2R2/'';
  lucy = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSXPk6yg1XOeWFytbLnfEEFZUD5Ah0D1k+SWK82JUvC'';
  quartz-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMD015VnsMHOeFHs2wQGWEO24IuzC1V/MleiZzg3yUNI";
}
