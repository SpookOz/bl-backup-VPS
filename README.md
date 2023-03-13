# bl-backup-VPS
Creates a temp snapshot of the current BinaryLAne VPS.

### This must be run on a BinaryLane Linux VPS.
### Tested on RockyLinux8, but should work on all versions of Centos, Debian, Rocky, Ubuntu.

To run
- Download BL-Create-Snapshot.sh
- Uncomment `#APITOKEN=`
- Add API token after `APITOKEN=`
  (eg: `APITOKEN=43509845093745234060438765340567`)

This shell script will:
- Lookup the hostname of the server
- Install jq if required
- Fetch the server ID from BinaryLane using the hostname
- Create a new Temporary snapshot of the VPS in BinaryLane

NB: There is no error-checking in the script, however, it is non-destructive. It will not harm the running VPS
NB: The snapshot will overwrite the old Temporary snapshot if one exists.
  
There is probably room for improvement. Happy for contributions and suggestions.
