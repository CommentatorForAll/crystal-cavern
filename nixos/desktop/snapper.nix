{
# apparently i am using ext4 and not btrfs, so this won't work -_-
/*
    services.snapper = {
        # do backups every quater hour
        snapshotInterval = "*:00/15:00";

        configs = {
            "home" = {
                SUBVOLUME = "/home";

                FSTYPE = "btrfs";
                SPACE_LIMIT = 0.5;
                FREE_LIMIT = 0.2;

                # Enable timeline at all
                TIMELINE_CREATE = true;
                # Enable timeline cleanup
                TIMELINE_CLEANUP = true;
                # Snapshot must be at least half an hour old to be deleted
                TIMELINE_MIN_AGE = 1800;
                # Number of hours, even if there are multiple snapshots within an hour
                TIMELINE_LIMIT_HOURLY = 8;

                TIMELINE_LIMIT_DAILY = 7;
                TIMELINE_LIMIT_WEEKLY = 4;
            };

            "root" = {
                SUBVOLUME = "/";

                FSTYPE = "btrfs";
                SPACE_LIMIT = 0.5;
                FREE_LIMIT = 0.2;

                # Enable timeline at all
                TIMELINE_CREATE = true;
                # Enable timeline cleanup
                TIMELINE_CLEANUP = true;
                # Snapshot must be at least half an hour old to be deleted
                TIMELINE_MIN_AGE = 3600;
                # Number of hours, even if there are multiple snapshots within an hour
                TIMELINE_LIMIT_HOURLY = 1;

                TIMELINE_LIMIT_DAILY = 4;
                TIMELINE_LIMIT_WEEKLY = 1;
            };
        };
    };*/
}
