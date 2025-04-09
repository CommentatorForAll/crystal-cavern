rec {
  ssh = [
    rutile-bigrpi
    rutile-perovskite
    rutile-nixrpi
    rutile-celestine
    rutile-work
    lucy
    piegames
  ];
  host = [ quartz-host azurite-host ];
  all = ssh ++ host;
  rutile-nixrpi = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF3kWw7i1az9QIe9RlxhTdcwIotBukvhbrmy2dvSwCh2'';
  rutile-bigrpi = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFreswWvgIPc3s3X9rjdRxGYmgpLmsU3UA2R3X+UGYpZ'';
  rutile-perovskite = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF9aakNG9hVLV1fW7zjbjPtM1gyup/5KoWqmoGzhUf+5'';
  rutile-celestine = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINkk3bjlkJWq5y4S9sMfW2Wzo5jQFodVqm/Vn226etjW'';
  rutile-work = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClTAvMxiHZrFm9NjVabelkROPmC+2Ym2XbKqF9g2R2/'';
  lucy = ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSXPk6yg1XOeWFytbLnfEEFZUD5Ah0D1k+SWK82JUvC'';
  piegames = ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0+vFmtDUgIg18r6a2ezNBRMrZVpAB6dhj37JDhYUu7CSr7o1pR8Sp/UUe/yAEjeyo0R/GfvKIKugCBDCd+6VsDuTkcWX9bwVdrelG3X7pIIt3tWdbqVVGZHFJ/qgdngvIYu3pY++ci6zFlBl8Z8SIXYXpDnVFYTvvBhDIOZJzvyyqL7B/Wm19fTf/HPLTtbuPFMg2gQxo8o5GW3Ow2keJRR1daSGYmGSA1y/F3UumoLuK85Zm0+Kt+yYTO2pMAUBN7Axv1yvnNGbdX9l+3eRHdKatfhCscs720cwR+HtMAfqvN1G5FAWnXdxPa8XIzyZIyrWRoEGPPuK1w2GlWUnDdYLVDMJOmLDz4TvYx2eodfWMRIdppLJYwWpv+Eg8JirO5bnbOnKzVM4C5ESYU8b1mRBI23ncqV+BAno+zehdzLPYg0q3N9wNDF6jqyw08YyiTDwlua4aZJzHDrDt7OjcFaC6t8W1/VimtE0bylhAzVeenJ8C+o3q2jPBvuNLIxk='';
  quartz-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMD015VnsMHOeFHs2wQGWEO24IuzC1V/MleiZzg3yUNI";
  azurite-host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzl+vE88usJ7TEQIc8HEucK/eMluoNrmNvpdJoRTI0g root@nixos";
}
