# When running updates on a cluster, it may become that the volumes are 'unhealthy' - To check the status of the repair use the following

Get-StorageJob

# Name               IsBackgroundTask  ElapsedTime  JobState  PercentComplete  BytesProcessed  BytesTotal
# ----               ----------------  -----------  --------  ---------------  --------------  ----------
# VMS-Repair         True              00:01:00     Running   12                        15 GB      500 GB 
# VMS-Regeneration   True              00:00:30     Paused    8                         15 GB      500 GB
# Data-Repair        True              00:01:00     Running   18                       120 GB     1200 GB
# Data-Regenration   True              00:00:30     Paused    2                        120 GB     1200 GB
