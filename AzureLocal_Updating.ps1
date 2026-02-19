# Check for Health Check Errors
(Get-SolutionUpdateEnvironment).HealthCheckResult | Where-Object { ( $_.Status -ne "SUCCESS" ) -and ( $_.Severity -ne "INFORMATIONAL" ) } | Format-Table Title,Status,Severity,Description,Remediation

# Show the currently installed version, health state and update state
Get-SolutionUpdateEnvironment

# ResourceId        :
# SbeFamily         :
# HardwareModel     :
# LastChecked       :
# PackageVersions   :
# CurrentVersion    :
# CurrentSbeVersion :
# LastUpdated       :
# State             :
# HealthState       :
# HealthCheckResult :
# HealthCheckDate   :
# AdditionalData    :

# Get all installed, failed, installing and avaliable updates. NB: This command can be unstable during update installation

Get-SolutionUpdate

# ResourceId            :
# InstalledDate         :
# Description           :
# State                 :
# KbLink                :
# MinVersionRequired    :
# MinSbeVersionRequired :
# PackagePath           :
# PackageSizeInMb       :
# DisplayName           :
# Version               :
# SbeVersion            :
# Publisher             :
# ReleaseLink           :
# AvailabilityType      :
# PackageType           :
# Prerequisites         :
# UpdateStateProperties :
# AdditionalProperties  :
# ComponentVersions     :
# RebootRequired        :
# HealthState           :
# HealthCheckResult     :
# HealthCheckDate       :
# BillOfMaterials       :

# Force start an update inside the node. Azure Portal will after a short time show the update as running

Get-SolutionUpdate | Where-Object Version -eq "**.****.****.**" | Start-SolutionUpdate

# Lists all installed and failed updates, along with their resource ID which includes the updaterunid. NB: The actionPlanInstanceID can be infered from the resource ID
# ResourceId: <Revision>/Solution<Version>/<actionPlanInstanceId>

Get-SolutionUpdate | Get-SolutionUpdateRun | Sort-Object TimeStarted

# ResourceId      :
# Progress        :
# TimeStarted     :
# LastUpdatedTime :
# Duration        :
# State           :

# Get the status of updates, and their installation percentage. NB: As this uses the Get-SolutionUpdate command, it can be unstable during updates. Be patient.

Get-SolutionUpdate | Format-Table Version, State, UpdateStateProperties

# Version             State UpdateStateProperties
# -------             ----- ---------------------

# Follow the current update stage using the actionPlanInstanceId

Start-MonitoringActionplanInstanceToComplete -actionPlanInstanceID $currentupdaterunID
